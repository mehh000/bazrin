import 'package:bazrin/feature/data/API/Helper/Customer/getCustomers.dart';
import 'package:bazrin/feature/presentation/common/Components/customdropdown.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/Components/iconEvButton.dart';
import 'package:bazrin/feature/presentation/screens/Sale/Presentation/checkout/check_out.dart';
import 'package:bazrin/feature/presentation/screens/Sale/Presentation/payemnt/widgets/item_card.dart';
import 'package:bazrin/feature/presentation/screens/Sale/Presentation/payemnt/widgets/last_action_buttons.dart';
import 'package:bazrin/feature/presentation/screens/Customers/Presentation/Customer/Add/add_customer.dart';

class Paayment extends StatefulWidget {
  final dynamic selectedItems;
  const Paayment({super.key, required this.selectedItems});

  @override
  State<Paayment> createState() => _PaaymentState();
}

class _PaaymentState extends State<Paayment> {
  dynamic selectedItems = [];
  dynamic grandTotal = 00;
  List<Map<String, dynamic>> customer = [];
  dynamic selectedCustomer = {};
  String discountType = '';
  double discount = 0;
  bool iscustomerLoaded = false;
  double originalTotal = 0;
  Timer? _debounce;
  int page = 0;
  bool isLoadingMore = false;
  bool noMoreData = false;

  // Inout Controllers
  TextEditingController dropDownController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController deliveryChangeController = TextEditingController();
  TextEditingController vatController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
    getCustomerList();

    setState(() {
      selectedItems = widget.selectedItems;
    });
    getSubTotal();
    discountController.addListener(() {
      if (discountType.isEmpty) {
        TostMessage.showToast(
          context,
          message: "Select a discount type",
          isSuccess: false,
        );
        return;
      }

      final discount = double.tryParse(discountController.text) ?? 0;

      setState(() {
        if (discountType == "Amount") {
          grandTotal = originalTotal - discount;
        } else if (discountType == "Percent") {
          grandTotal = originalTotal - (originalTotal * (discount / 100));
        }
      });
    });
    deliveryChangeController.addListener(() {
      final deliveryC = double.tryParse(deliveryChangeController.text) ?? 0;
      final discount = double.tryParse(discountController.text) ?? 0;
      if (discountType.isEmpty) {
        TostMessage.showToast(
          context,
          message: "Select a discount type",
          isSuccess: false,
        );
        return;
      }

      setState(() {
        if (discountType == "Amount") {
          grandTotal = originalTotal - discount;
        } else if (discountType == "Percent") {
          grandTotal = originalTotal - (originalTotal * (discount / 100));
        }
        grandTotal = grandTotal + deliveryC;
      });

      // setState(() {
      //   grandTotal = originalTotal + deliveryC;
      // });
    });

    vatController.addListener(() {
      final deliveryC = double.tryParse(deliveryChangeController.text) ?? 0;
      final discount = double.tryParse(discountController.text) ?? 0;
      final vat = double.tryParse(vatController.text) ?? 0;

      if (discountType.isEmpty) {
        TostMessage.showToast(
          context,
          message: "Select a discount type",
          isSuccess: false,
        );
        return;
      }

      setState(() {
        if (discountType == "Amount") {
          grandTotal = originalTotal - discount;
        } else if (discountType == "Percent") {
          grandTotal = originalTotal - (originalTotal * (discount / 100));
        }
        grandTotal = grandTotal + deliveryC;
        grandTotal = grandTotal + (grandTotal * (vat / 100));
      });
    });
  }

  void incrementAddedItemToCart(item) {
    final id = item['id'];

    final index = selectedItems.indexWhere((e) => e['id'] == id);

    if (index != -1) {
      selectedItems[index] = item;
    }
    setState(() {});
    getSubTotal();
  }

  void cleanAll() async {
    setState(() {
      selectedItems = [];
    });
    getSubTotal();
  }

  void getSubTotal() {
    double newTotal = 0;
    for (var item in selectedItems) {
      final qty = (item['posQty'] is List)
          ? item['posQty'][0]
          : item['posQty'] ?? 0;

      final price = (item['salePriceRange'] is List)
          ? item['salePriceRange'][0]
          : item['salePriceRange'] ?? 0;

      final subtotal = qty * price;

      // item['subTotal'] = subtotal;
      newTotal += subtotal;
    }

    setState(() {
      grandTotal = newTotal;
      originalTotal = newTotal;
    });

    print("Grand Total: $grandTotal");
  }

  void getCustomerList() async {
    page = 0;
    noMoreData = false;

    setState(() => iscustomerLoaded = true);

    final response = await Getcustomers.getCustomersList(
      page,
      searchController.text,
    );

    final List<Map<String, dynamic>> parsedList =
        List<Map<String, dynamic>>.from(response['data'] ?? []);

    setState(() {
      customer = parsedList; // 🔥 REPLACE, NOT APPEND
      iscustomerLoaded = false;
    });
  }

  void addToCheakOut() {
    dynamic cheakoutData = {
      "customerId": selectedCustomer['id'],
      "items": selectedItems,
      "discountType": discountType,
      "discount": discountController.text,
      "deliveryCharge": deliveryChangeController.text,
      "vat": vatController.text,
      "model": selectedItems[0]['selectedModel'],
    };
    // PrettyPrint.print(cheakoutData);

    Navigator.of(context).push(
      SlidePageRoute(
        page: CheckOut(cheakoutData: cheakoutData),
        direction: SlideDirection.right,
      ),
    );
  }

  void onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    setState(() {
      searchController.text = value;
    });

    _debounce = Timer(const Duration(milliseconds: 400), () {
      getCustomerList();
    });
  }

  Future<void> loadMore() async {
    if (isLoadingMore || noMoreData) return;

    isLoadingMore = true;
    page++;

    final response = await Getcustomers.getCustomersList(page);

    int totalPage = response["totalPage"] ?? 0;

    // SAFELY read API list
    final List<dynamic> rawData = response["data"] ?? [];

    // Convert to correct type
    final List<Map<String, dynamic>> newData = rawData
        .cast<Map<String, dynamic>>();

    if (newData.isEmpty || page >= totalPage) {
      noMoreData = true;
    }

    print('Customers: $newData');

    setState(() {
      customer = [...customer, ...newData];
    });

    isLoadingMore = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.containerColor,
        bottomNavigationBar: LastActionButtons(
          selectedItems: selectedItems,
          cleanAll: cleanAll,
          addToCheakOut: addToCheakOut,
        ),
        body: Column(
          children: [
            Container(
              height: 80,
              color: AppColors.Colorprimary,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        SlidePageRoute(
                          page: const Pos(),
                          direction: SlideDirection.right,
                        ),
                      );
                    },
                    child: Icon(Icons.keyboard_arrow_left, color: Colors.white),
                  ),

                  // Search bar
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SearchDropdown(
                        textController: searchController,
                        searchOnchanged: (value) => onSearchChanged(value),
                        items: customer ?? [],
                        hint: "search Customer",
                        onChanged: (e) {
                          selectedCustomer = e;
                        },
                        scrollController: scrollController,
                      ),
                    ),
                  ),
                  Iconevbutton(
                    title: '',
                    colorData: Colors.white,
                    iconName: Icons.person_add_alt_1,
                    iconColor: AppColors.Colorprimary,
                    iconSize: 22,
                    height: 40,
                    buttonFunction: () {
                      Navigator.of(context).push(
                        SlidePageRoute(
                          page: const AddCustomer(),
                          direction: SlideDirection.right,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // ✅ Scrollable content below header
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: Column(
                          children: [
                            Headercomponent(title: "Item List"),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                              child: Column(
                                children: selectedItems
                                    .map<Widget>(
                                      (item) => PosSellItem(
                                        item: item,
                                        incrementAddedItemToCart: (e) {
                                          incrementAddedItemToCart(e);
                                        },
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),

                      //
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          spacing: 12,
                          children: [
                            StatusDropdown(
                              label: "Discount Type",
                              hint: "Discount Type",
                              data: ['Amount', "Percent"],
                              selectedStatus: (e) {
                                setState(() {
                                  discountType = e;
                                });
                              },
                            ),
                            InputComponent(
                              spcae: 5,
                              hintitle: 'Enter Discount',
                              label: "Discount",
                              islabel: true,
                              controller: discountController,
                            ),
                            InputComponent(
                              spcae: 5,
                              hintitle: 'Enter Delivery Charge',
                              label: "Delivery Charge",
                              islabel: true,
                              controller: deliveryChangeController,
                            ),
                            InputComponent(
                              spcae: 5,
                              hintitle: 'Percent',
                              label: "Vat%",
                              islabel: true,
                              controller: vatController,
                            ),

                            Divider(height: 1, thickness: 2),
                            Rowlinedatashow(
                              fontSize: 14,
                              left: 'Customer Name',
                              right: "${selectedCustomer['name'] ?? ''}",
                            ),
                            Divider(height: 1, thickness: 2),
                            Rowlinedatashow(
                              fontSize: 14,
                              left: 'Total:',
                              right: "$grandTotal",
                            ),
                            Divider(height: 1, thickness: 2),
                            Rowlinedatashow(
                              fontSize: 18,
                              left: 'Grand Total:',
                              right: "${grandTotal}",
                              fontw: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

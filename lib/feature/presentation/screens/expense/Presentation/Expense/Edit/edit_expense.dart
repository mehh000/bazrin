import 'package:bazrin/feature/data/API/Helper/Accounts/getaccountList.dart';
import 'package:bazrin/feature/data/API/Helper/Expense/getExpenseByid.dart';
import 'package:bazrin/feature/data/API/Helper/Expense/getExpenseCategoryList.dart';
import 'package:bazrin/feature/data/API/Helper/Expense/getExpenseProductsList.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/Components/search_dropdown.dart';
import 'package:bazrin/feature/presentation/common/Components/tost_message.dart';
import 'package:bazrin/feature/presentation/screens/expense/Presentation/Expense/Edit/widgets/selected_product_card.dart';
import 'package:bazrin/feature/presentation/screens/expense/Components/previous_payment_card.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

class EditExpense extends StatefulWidget {
  final String id;
  const EditExpense({super.key, required this.id});

  @override
  State<EditExpense> createState() => _EditExpenseState();
}

class _EditExpenseState extends State<EditExpense> {
  // --- Data lists ---
  List<Map<String, dynamic>> expenseCategoryListData = [];
  List<Map<String, dynamic>> accountList = [];
  List<Map<String, dynamic>> productsList = [];

  // single source of truth for products shown in UI (existing + newly added)
  List<Map<String, dynamic>> selectedProducts = [];

  // (optional) kept for compatibility with other logic you had
  List<Map<String, dynamic>> addexpenseData = [];

  // --- Controllers ---
  final TextEditingController refController = TextEditingController();
  final TextEditingController totalPayController = TextEditingController();
  final TextEditingController payAmountController = TextEditingController();
  final TextEditingController totalAmountController = TextEditingController();
  final TextEditingController totalPaidController = TextEditingController();
  final TextEditingController payableController = TextEditingController();
  final TextEditingController _productSearchController =
      TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _paytypeSearchController =
      TextEditingController();
  final noteController = QuillController.basic();

  // --- other state ---
  DateTime selectedDate = DateTime.now();
  Map<String, dynamic>? paymentData;
  Map<String, dynamic>? catgeoryObject;
  double sum = 0.0;
  Map<String, dynamic>? expenseData;
  bool isloaded = true;

  @override
  void initState() {
    super.initState();
    _initAll();
  }

  Future<void> _initAll() async {
    // parallel load
    await Future.wait([
      getCategory(),
      getacconts(),
      getProducts(),
      getExpenseByid(),
    ]);
  }

  // -------------------------
  // Fetch & initialize
  // -------------------------
  Future<void> getExpenseByid() async {
    try {
      final response = await Getexpensebyid.getExpenseById(widget.id);
      // print('Expense Data from ID: $response');

      if (response != null && response is Map<String, dynamic>) {
        // populate local state
        setState(() {
          expenseData = response;
          isloaded = false;

          refController.text = expenseData?['invoiceNumber']?.toString() ?? '';
          totalPaidController.text =
              expenseData?['totalPaid']?.toString() ?? '0';
          payableController.text =
              expenseData?['totalRemaining']?.toString() ?? '0';

          // init category & payment objects (if any)
          if (expenseData?['category'] != null) {
            catgeoryObject = Map<String, dynamic>.from(
              expenseData!['category'],
            );
            _categoryController.text =
                catgeoryObject?['name']?.toString() ?? '';
          }

          if ((expenseData?['payments'] as List<dynamic>?)?.isNotEmpty ??
              false) {
            paymentData = Map<String, dynamic>.from(
              expenseData!['payments'][0],
            );
            _paytypeSearchController.text =
                paymentData?['account']?['type']?.toString() ?? '';
          }

          // populate selectedProducts from API items (preserve any existing edits if somehow present)
          selectedProducts = (expenseData?['items'] as List<dynamic>? ?? [])
              .map<Map<String, dynamic>>((p) {
                // ensure keys exist with expected names
                final Map<String, dynamic> map = Map<String, dynamic>.from(p);
                return {
                  'id': map['id'],
                  'name': map['name'],
                  'quantity': (map['quantity'] ?? 0).toString(),
                  'unitPrice': (map['unitPrice'] ?? 0).toString(),
                  // keep both forms for compatibility: 'totalAmount' (api) and 'total' (local)
                  'totalAmount': map['totalAmount'] ?? 0,
                  'total': map['totalAmount'] ?? 0,
                  // keep original payload in case you need it
                  '_raw': map,
                };
              })
              .toList();

          // initial sum
          _recalculateSum();
        });
      } else {
        // print('Error: Invalid response format.');
        setState(() => isloaded = false);
      }
    } catch (e, stack) {
      // print('Error fetching expense by ID: $e');
      // print(stack);
      setState(() => isloaded = false);
    }
  }

  Future<void> getCategory() async {
    try {
      final response = await Getexpensecategorylist.getExpenseCategoryList();
      final List<Map<String, dynamic>> parsedList = (response as List)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
      setState(() {
        expenseCategoryListData = parsedList;
      });
    } catch (e) {
      // print('Error loading categories: $e');
    }
  }

  Future<void> getacconts() async {
    try {
      final response = await Getaccountlist.getAccountsList();
      final List<Map<String, dynamic>> parsedList = (response['data'] as List)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
      setState(() {
        accountList = parsedList;
      });
    } catch (e) {
      // print('Error loading accounts: $e');
    }
  }

  Future<void> getProducts() async {
    try {
      final response = await Getexpenseproductslist.getExpenseProductsList();
      final List<Map<String, dynamic>> parsedList = (response as List)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
      setState(() {
        productsList = parsedList;
      });
    } catch (e) {
      // print('Error loading products: $e');
    }
  }

  // -------------------------
  // Product handling helpers
  // -------------------------
  /// Add a new product to selectedProducts (when user picks from dropdown)
  void addProductToSelection(Map<String, dynamic> product) {
    final id = product['id'];
    // avoid duplicates
    final exists = selectedProducts.any((p) => p['id'] == id);
    if (exists) return;

    final initialQty = (product['quantity'] ?? 1).toString();
    final initialUnit = (product['unitPrice'] ?? product['price'] ?? 0)
        .toString();
    final qtyNum = double.tryParse(initialQty) ?? 0;
    final unitNum = double.tryParse(initialUnit) ?? 0;
    final total = qtyNum * unitNum;

    setState(() {
      selectedProducts.add({
        'id': product['id'],
        'name': product['name'],
        'quantity': initialQty,
        'unitPrice': initialUnit,
        'total': total,
        '_raw': Map<String, dynamic>.from(product),
      });
    });

    _recalculateSum();
  }

  /// Called by SelectedProductCard whenever qty/unitPrice changes.
  /// Expects a map like: { 'productId': '...', 'quantity': 'x', 'unitPrice': 'y', 'total': <double> }
  void onProductUpdated(Map<String, dynamic> updated) {
    final pid = updated['productId'];
    final idx = selectedProducts.indexWhere((p) => p['id'] == pid);
    if (idx != -1) {
      setState(() {
        selectedProducts[idx]['quantity'] =
            updated['quantity']?.toString() ?? '0';
        selectedProducts[idx]['unitPrice'] =
            updated['unitPrice']?.toString() ?? '0';
        // prefer provided 'total' if present, else compute
        final providedTotal = updated['total'];
        if (providedTotal != null) {
          selectedProducts[idx]['total'] = (providedTotal is num)
              ? providedTotal.toDouble()
              : double.tryParse(providedTotal.toString()) ?? 0;
        } else {
          final q =
              double.tryParse(
                selectedProducts[idx]['quantity']?.toString() ?? '0',
              ) ??
              0;
          final u =
              double.tryParse(
                selectedProducts[idx]['unitPrice']?.toString() ?? '0',
              ) ??
              0;
          selectedProducts[idx]['total'] = q * u;
        }
      });
    } else {
      // Not found (shouldn't usually happen) — add as new
      final q = double.tryParse(updated['quantity']?.toString() ?? '0') ?? 0;
      final u = double.tryParse(updated['unitPrice']?.toString() ?? '0') ?? 0;
      setState(() {
        selectedProducts.add({
          'id': updated['productId'],
          'name': updated['name'] ?? '',
          'quantity': updated['quantity']?.toString() ?? '0',
          'unitPrice': updated['unitPrice']?.toString() ?? '0',
          'total': q * u,
          '_raw': updated,
        });
      });
    }

    _recalculateSum();
  }

  /// Remove product from selection (called by SelectedProductCard delete)
  void removeProductFromSelection(String productId) {
    setState(() {
      selectedProducts.removeWhere((p) => p['id'] == productId);
    });
    _recalculateSum();
  }

  /// Recalculate sum from selectedProducts list and update controller
  void _recalculateSum() {
    final totalSum = selectedProducts.fold<double>(0.0, (prev, item) {
      final t = item['total'];
      if (t is num) return prev + t.toDouble();
      return prev + (double.tryParse(t?.toString() ?? '0') ?? 0.0);
    });

    setState(() {
      sum = totalSum;
      totalAmountController.text = sum.toStringAsFixed(2);
    });
  }

  // keep compatibility with your legacy cheakAndAdd function
  void cheakAndAdd(Map<String, dynamic> pro) {
    final index = addexpenseData.indexWhere((item) => item['id'] == pro['id']);
    if (index != -1) {
      addexpenseData[index] = pro;
    } else {
      addexpenseData.add(pro);
    }
  }

  // -------------------------
  // Delete product wrapper (used by SelectedProductCard)
  // -------------------------
  void deleteProductFromSelect(Map<String, dynamic> product) {
    final id = product['id'];
    removeProductFromSelection(id);
  }

  // -------------------------
  // Submit
  // -------------------------
  void addExpense() async {
    final invoiceNumber = refController.text.trim();
    final totalpay = totalPayController.text.trim();
    final payamount = payAmountController.text.trim();
    final onlyDate = selectedDate.toIso8601String().split('T').first;

    final delta = noteController.document.toDelta();
    final converter = QuillDeltaToHtmlConverter(delta.toJson());
    final html = converter.convert();

    if (invoiceNumber.isEmpty) {
      TostMessage.showToast(
        context,
        message: 'Invoice is Required',
        isSuccess: false,
      );
      return;
    }
    if (catgeoryObject == null || catgeoryObject!.isEmpty) {
      TostMessage.showToast(
        context,
        message: 'Category is Required',
        isSuccess: false,
      );
      return;
    }
    if (paymentData == null || paymentData!.isEmpty) {
      TostMessage.showToast(
        context,
        message: 'Payment Account is Required',
        isSuccess: false,
      );
      return;
    }

    // Prepare items payload --- keep same structure you used before: items = selectedProducts
    final itemsPayload = selectedProducts.map((p) {
      return {
        'productId': p['id'],
        'quantity': double.tryParse(p['quantity']?.toString() ?? '0') ?? 0,
        'unitCost': double.tryParse(p['unitPrice']?.toString() ?? '0') ?? 0,
      };
    }).toList();

    final payload = {
      'invoiceNumber': invoiceNumber,
      'totalPay': totalpay,
      'payamount': payamount,
      'date': onlyDate,
      'items': itemsPayload,
      'note': html,
      'category': catgeoryObject,
      'paymentData': paymentData,
    };

    // print('add expense data : $payload');

    // The API call was commented in your original — keep same behavior
    // try {
    //   final respose = await Addexpense.addExpense(payload);
    //   ...
    // } catch (e) { print(e); }
  }

  @override
  void dispose() {
    refController.dispose();
    totalPayController.dispose();
    payAmountController.dispose();
    totalAmountController.dispose();
    totalPaidController.dispose();
    payableController.dispose();
    _productSearchController.dispose();
    _categoryController.dispose();
    _paytypeSearchController.dispose();
    noteController.dispose();
    super.dispose();
  }

  // -------------------------
  // UI (kept same structure)
  // -------------------------
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.Colorprimary,
        appBar: AppBar(
          backgroundColor: AppColors.Colorprimary,
          leading: Row(
            children: [
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    SlidePageRoute(
                      page: ExpenseList(),
                      direction: SlideDirection.left,
                    ),
                  );
                },
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ],
          ),
          title: const Text(
            'Expense Edit',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F7),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: isloaded
              ? Center(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      color: AppColors.Colorprimary,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        child: Container(
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
                              Headercomponent(title: "Expense Edit"),
                              Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 15,
                                ),
                                child: Column(
                                  spacing: 12,
                                  children: [
                                    DatePicker(
                                      label: "Expense Date",
                                      initialDate: expenseData?['date'] != null
                                          ? DateTime.tryParse(
                                              expenseData!['date'],
                                            )
                                          : null,
                                      required: true,
                                      onDateSelected: (date) {
                                        setState(() {
                                          selectedDate = date;
                                        });
                                      },
                                    ),

                                    Row(
                                      children: [
                                        Text(
                                          'Expense Category',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: AppColors.colorBlack,
                                          ),
                                        ),
                                        const Text(
                                          '*',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 45,
                                      child: MySearchDropdown(
                                        items: expenseCategoryListData,
                                        dropDownSearchController:
                                            _categoryController,
                                        hint: 'Search Category',
                                        onChanged: (e) {
                                          setState(() {
                                            catgeoryObject = e;
                                            _categoryController.text =
                                                e['name'];
                                          });
                                        },
                                      ),
                                    ),

                                    InputComponent(
                                      hintitle: "Number Reference",
                                      islabel: true,
                                      label: "Reference",
                                      required: true,
                                      spcae: 12,
                                      controller: refController,
                                    ),
                                    const SizedBox(height: 10),

                                    // product search + selected products
                                    Column(
                                      spacing: 5,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                              255,
                                              247,
                                              247,
                                              247,
                                            ).withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            border: Border.all(
                                              width: 1,
                                              color: Colors.blueGrey
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: double.infinity,
                                                width: 50,
                                                color: Colors.black.withOpacity(
                                                  0.1,
                                                ),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.search,
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: MySearchDropdown(
                                                  items: productsList,
                                                  isBorder: false,
                                                  addButtonTitle:
                                                      "Add New Product",
                                                  dropDownSearchController:
                                                      _productSearchController,
                                                  hint:
                                                      'Search By Product Name / SKU / Barcode',
                                                  onChanged: (e) {
                                                    // Add selected product to local selectedProducts
                                                    addProductToSelection(e);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // selected product cards
                                        selectedProducts.isNotEmpty
                                            ? Column(
                                                spacing: 8,
                                                children: selectedProducts
                                                    .map<Widget>(
                                                      (
                                                        product,
                                                      ) => SelectedProductCard(
                                                        deleteProductFromSelect: (p) {
                                                          // SelectedProductCard passes map {'id':..., 'sum': ...}
                                                          deleteProductFromSelect(
                                                            p,
                                                          );
                                                        },
                                                        product: product,
                                                        latestData: (e) {
                                                          // legacy: keep cheakAndAdd behavior
                                                          if (e
                                                              is Map<
                                                                String,
                                                                dynamic
                                                              >)
                                                            cheakAndAdd(e);
                                                        },
                                                        latestsum: (e) {
                                                          // e expected: {productId, quantity, unitPrice, total}
                                                          if (e
                                                              is Map<
                                                                String,
                                                                dynamic
                                                              >)
                                                            onProductUpdated(e);
                                                        },
                                                      ),
                                                    )
                                                    .toList(),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),

                                    RichTextEditor(
                                      label: "Note",
                                      noteQuillController: noteController,
                                    ),
                                    FileUpload(label: "Attachments"),

                                    InputComponent(
                                      hintitle: '$sum ',
                                      islabel: true,
                                      label: "Total Amount",
                                      read: true,
                                      spcae: 12,
                                      controller: totalAmountController,
                                    ),

                                    InputComponent(
                                      hintitle: "0",
                                      islabel: true,
                                      label: "Total Paid",
                                      spcae: 12,
                                      read: true,
                                      controller: payAmountController,
                                    ),

                                    Text(
                                      'Payment Account',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: AppColors.colorBlack,
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.blueGrey.withOpacity(
                                            0.5,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: double.infinity,
                                            width: 40,
                                            child: Center(
                                              child: Icon(
                                                Icons.search,
                                                color: Colors.black.withOpacity(
                                                  0.4,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: MySearchDropdown(
                                              items: accountList,
                                              isBorder: false,
                                              dropDownSearchController:
                                                  _paytypeSearchController,
                                              hint: 'MFS- Ayesha Telecom',
                                              getterName: 'type',
                                              addButtonTitle: 'Add New Account',
                                              onChanged: (e) {
                                                setState(() {
                                                  paymentData = e;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    InputComponent(
                                      hintitle: "0",
                                      islabel: true,
                                      label: "Payable",
                                      read: true,
                                      spcae: 12,
                                      controller: payableController,
                                    ),

                                    InputComponent(
                                      hintitle: "0",
                                      islabel: true,
                                      label: "Pay Amount",
                                      spcae: 12,
                                      controller: payAmountController,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Row(
                        spacing: 15,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(width: 20),
                          Expanded(
                            child: ButtonEv(
                              title: 'Cancle',
                              textColor: AppColors.colorRed,
                              isBorder: true,
                              borderColor: AppColors.colorRed,
                            ),
                          ),
                          Expanded(
                            child: ButtonEv(
                              title: 'Update Expense',
                              colorData: AppColors.Colorprimary,
                              buttonFunction: addExpense,
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),

                      const SizedBox(height: 20),
                      // previous payment header + list
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 25),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: AppColors.colorGray.withOpacity(0.2),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 1,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: AppColors.Colorprimary,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Previous Payment',
                                        style: TextStyle(
                                          fontSize: 16,
                                          height: 2,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.colorBlack,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      Column(
                        children:
                            (expenseData?['payments'] as List<dynamic>? ?? [])
                                .map((pre) => PreviousPaymentCard(pre: pre))
                                .toList(),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

import 'package:bazrin/feature/data/API/Helper/Product/Brand/getBrandList.dart';
import 'package:bazrin/feature/data/API/Helper/Product/Unit/getUnitList.dart';
import 'package:bazrin/feature/data/API/Helper/Product/getProductList.dart';
import 'package:bazrin/feature/data/API/Helper/Supplier/getSuppliers.dart';
import 'package:bazrin/feature/presentation/common/Components/customdropdown.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/classes/prettyPrint.dart';
import 'package:intl/intl.dart';

class PurchaseFilter extends StatefulWidget {
  final Function filterSubmit;
  const PurchaseFilter({super.key, required this.filterSubmit});

  @override
  State<PurchaseFilter> createState() => _PurchaseFilterState();
}

class _PurchaseFilterState extends State<PurchaseFilter> {
  List<Map<String, dynamic>> suppliers = [];
  List<Map<String, dynamic>> returntypes = [];
  List<Map<String, dynamic>> product = [];

  final ScrollController supplierScroll = ScrollController();
  final ScrollController returntypesScroll = ScrollController();
  final ScrollController productScroll = ScrollController();

  TextEditingController suppliersearchController = TextEditingController();
  TextEditingController returntypessearchController = TextEditingController();
  TextEditingController productearchController = TextEditingController();

  int supplierPage = 0;
  int returntypesPage = 0;
  int productpage = 0;

  bool isLoadingMoreForSupplier = false;
  bool isLoadingMoreForreturntypes = false;
  bool isLoadingMoreForProduct = false;

  bool noMoreDataForSupplier = false;
  bool noMoreDataForreturntypes = false;
  bool noMoreDataForProduct = false;

  bool isloading = false;
  Timer? _debounce;

  dynamic selectedSupplier = {};
  dynamic selectedreturntypes = {};
  dynamic selectedProduct = {};

  DateTime? staringDate;
  DateTime? endingDate;

  @override
  void initState() {
    super.initState();

    supplierScroll.addListener(() {
      if (supplierScroll.position.pixels ==
          supplierScroll.position.maxScrollExtent) {
        loadMoreSupplier();
      }
    });
    productScroll.addListener(() {
      if (productScroll.position.pixels ==
          productScroll.position.maxScrollExtent) {
        loadMoreproduct();
      }
    });
    returntypesScroll.addListener(() {
      if (returntypesScroll.position.pixels ==
          returntypesScroll.position.maxScrollExtent) {
        loadMorereturntypes();
      }
    });
    getSupplie();
    getproduct();
    getUnits();
  }

  void getSupplie() async {
    supplierPage = 0;
    noMoreDataForSupplier = false;
    setState(() => isloading = true);

    final res = await Getsuppliers.getSuppliersList(
      supplierPage,
      suppliersearchController.text,
    );

    final List<Map<String, dynamic>> parsedSuppliers =
        List<Map<String, dynamic>>.from(res['data'] ?? []);

    setState(() {
      if (supplierPage == 0) {
        suppliers = parsedSuppliers;
      } else {
        suppliers = [...suppliers, ...parsedSuppliers];
      }

      isloading = false;
    });
  }

  Future<void> getUnits() async {
    returntypesPage = 0;
    noMoreDataForreturntypes = false;
    final response = await Getunitlist.getUnitList(
      returntypesPage,
      returntypessearchController.text,
    );

    final List<Map<String, dynamic>> parsedSuppliers =
        List<Map<String, dynamic>>.from(response['data'] ?? []);

    setState(() {
      if (returntypesPage == 0) {
        returntypes = parsedSuppliers;
      } else {
        returntypes = [...returntypes, ...parsedSuppliers];
      }
    });
  }

  Future<void> getproduct() async {
    productpage = 0;
    isLoadingMoreForProduct = false;

    final response = await Getproductlist.getProductList(
      productpage,
      productearchController.text,
    );
    final List<Map<String, dynamic>> parsedSuppliers =
        List<Map<String, dynamic>>.from(response['data'] ?? []);

    // PrettyPrint.print(response);
    setState(() {
      if (productpage == 0) {
        product = parsedSuppliers;
      } else {
        product = [...product, ...parsedSuppliers];
      }
    });
  }

  Future<void> loadMoreSupplier() async {
    if (isLoadingMoreForSupplier || noMoreDataForSupplier) return;

    isLoadingMoreForSupplier = true;
    supplierPage++;

    final response = await Getsuppliers.getSuppliersList(supplierPage);

    int totalPage = response["totalPage"];
    List<dynamic> newData = response["data"];

    if (newData.isEmpty || supplierPage >= totalPage) {
      noMoreDataForSupplier = true;
    }

    // Convert safely
    final List<Map<String, dynamic>> parsedNew =
        List<Map<String, dynamic>>.from(newData);

    setState(() {
      suppliers = [...suppliers, ...parsedNew];
    });

    print('supplier scroll triggered $parsedNew');

    isLoadingMoreForSupplier = false;
  }

  Future<void> loadMoreproduct() async {
    if (isLoadingMoreForProduct || noMoreDataForProduct) return;

    isLoadingMoreForProduct = true;
    productpage++;

    final response = await Getproductlist.getProductList(productpage);

    int totalPage = response["totalPage"];
    List<dynamic> newData = response["data"];

    if (newData.isEmpty || productpage >= totalPage) {
      noMoreDataForSupplier = true;
    }

    // Convert safely
    final List<Map<String, dynamic>> parsedNew =
        List<Map<String, dynamic>>.from(newData);

    setState(() {
      product = [...product, ...parsedNew];
    });

    print('product scroll triggered $parsedNew');

    isLoadingMoreForProduct = false;
  }

  Future<void> loadMorereturntypes() async {
    if (isLoadingMoreForreturntypes || noMoreDataForreturntypes) return;

    isLoadingMoreForreturntypes = true;
    returntypesPage++;

    final response = await Getunitlist.getUnitList(returntypesPage);

    int totalPage = response["totalPage"];
    List<dynamic> newData = response["data"];

    if (newData.isEmpty || returntypesPage >= totalPage) {
      noMoreDataForreturntypes = true;
    }

    // Convert safely
    final List<Map<String, dynamic>> parsedNew =
        List<Map<String, dynamic>>.from(newData);

    setState(() {
      returntypes = [...returntypes, ...parsedNew];
    });

    // print('product scroll triggered $parsedNew');

    isLoadingMoreForreturntypes = false;
  }

  void submitFilter() {
    dynamic filterData = {
      "supplier": selectedSupplier['id'] ?? "",
      // "returntypes": selectedreturntypes['id'] ?? "",
      "Product": selectedProduct['id'] ?? "",
      "startMonth": staringDate == null
          ? ''
          : DateFormat(
              'yyyy/MM/dd',
            ).format(DateTime.parse(staringDate.toString())),
      "endingMonth": endingDate == null
          ? ''
          : DateFormat(
              'yyyy/MM/dd',
            ).format(DateTime.parse(endingDate.toString())),
    };
    widget.filterSubmit(filterData);
    Navigator.of(context).pop();
    // PrettyPrint.print(filterData);
  }

  void cleanFilterData() {}

  void onSearchSupplierChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    setState(() {
      suppliersearchController.text = value;
    });

    _debounce = Timer(const Duration(milliseconds: 400), () {
      getSupplie();
    });
  }

  void onSearchproductChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    setState(() {
      productearchController.text = value;
    });

    _debounce = Timer(const Duration(milliseconds: 400), () {
      getproduct();
    });
  }

  void onSearchreturntypesChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    setState(() {
      returntypessearchController.text = value;
    });

    _debounce = Timer(const Duration(milliseconds: 400), () {
      getUnits();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      // padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        // color: Color(0xFFF5F5F7),
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Headercomponent(title: 'Filter'),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 13,
                  children: [
                    SizedBox(height: 20),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: DatePicker(
                            onDateSelected: (date) {
                              setState(() {
                                staringDate = date;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.Colorprimary,
                          ),
                          child: Center(
                            child: Image.asset('assets/images/arrowupdown.png'),
                          ),
                        ),
                        Expanded(
                          child: DatePicker(
                            onDateSelected: (date) {
                              setState(() {
                                endingDate = date;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Supplier',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.colorBlack,
                      ),
                    ),
                    SearchDropdown(
                      items: isloading ? [] : suppliers,
                      hint: "search Supplier",
                      onChanged: (e) {
                        selectedSupplier = e;
                      },
                      scrollController: supplierScroll,
                      searchOnchanged: (value) =>
                          onSearchSupplierChanged(value),
                    ),

                    // Text(
                    //   'returntypes',
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.w500,
                    //     fontSize: 16,
                    //     color: AppColors.colorBlack,
                    //   ),
                    // ),
                    // SearchDropdown(
                    //   items: isloading ? [] : returntypes,
                    //   hint: "Search returntypes",
                    //   onChanged: (e) {
                    //     selectedreturntypes = e;
                    //   },
                    //   scrollController: supplierScroll,
                    //   searchOnchanged: (value) =>
                    //       onSearchreturntypesChanged(value),
                    // ),
                    Text(
                      'Product',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.colorBlack,
                      ),
                    ),
                    SearchDropdown(
                      items: isloading ? [] : product,
                      hint: "search Product",
                      onChanged: (e) {
                        selectedProduct = e;
                      },
                      scrollController: productScroll,
                      searchOnchanged: (value) => onSearchproductChanged(value),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            width: double.infinity,
            child: Row(
              spacing: 20,
              children: [
                Expanded(
                  child: ButtonEv(
                    title: "Clear",
                    isBorder: true,
                    textColor: Colors.red,
                    borderColor: Colors.red,
                  ),
                ),

                Expanded(
                  child: ButtonEv(
                    title: "Filter",
                    colorData: AppColors.Colorprimary,
                    buttonFunction: submitFilter,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

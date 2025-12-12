import 'package:bazrin/feature/data/API/Helper/Accounts/getaccountList.dart';
import 'package:bazrin/feature/data/API/Helper/Product/Brand/getBrandList.dart';
import 'package:bazrin/feature/data/API/Helper/Product/Unit/getUnitList.dart';
import 'package:bazrin/feature/data/API/Helper/Supplier/getSuppliers.dart';
import 'package:bazrin/feature/presentation/common/Components/customdropdown.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/classes/prettyPrint.dart';

class ProductFilter extends StatefulWidget {
  final Function filterSubmit;
  const ProductFilter({super.key, required this.filterSubmit});

  @override
  State<ProductFilter> createState() => _ProductFilterState();
}

class _ProductFilterState extends State<ProductFilter> {
  
  List<Map<String, dynamic>> suppliers = [];
  List<Map<String, dynamic>> category = [];
  List<Map<String, dynamic>> brands = [];

  final ScrollController supplierScroll = ScrollController();
  final ScrollController categoryScroll = ScrollController();
  final ScrollController brandsScroll = ScrollController();

  TextEditingController suppliersearchController = TextEditingController();
  TextEditingController categorysearchController = TextEditingController();
  TextEditingController brandsearchController = TextEditingController();

  int supplierPage = 0;
  int categoryPage = 0;
  int brandPage = 0;

  bool isLoadingMoreForSupplier = false;
  bool isLoadingMoreForCategory = false;
  bool isLoadingMoreForBrand = false;

  bool noMoreDataForSupplier = false;
  bool noMoreDataForCategory = false;
  bool noMoreDataForBrand = false;

  bool isloading = false;
  Timer? _debounce;

  dynamic selectedSupplier = {};
  dynamic selectedCategory = {};
  dynamic selectedBrand = {};

  @override
  void initState() {
    super.initState();

    supplierScroll.addListener(() {
      if (supplierScroll.position.pixels ==
          supplierScroll.position.maxScrollExtent) {
        loadMoreSupplier();
      }
    });
    brandsScroll.addListener(() {
      if (brandsScroll.position.pixels ==
          brandsScroll.position.maxScrollExtent) {
        loadMoreBrands();
      }
    });
    categoryScroll.addListener(() {
      if (categoryScroll.position.pixels ==
          categoryScroll.position.maxScrollExtent) {
        loadMoreCategory();
      }
    });
    getSupplie();
    getBrands();
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
    categoryPage = 0;
    noMoreDataForCategory = false;
    final response = await Getunitlist.getUnitList(
      categoryPage,
      categorysearchController.text,
    );

    final List<Map<String, dynamic>> parsedSuppliers =
        List<Map<String, dynamic>>.from(response['data'] ?? []);

    setState(() {
      if (categoryPage == 0) {
        category = parsedSuppliers;
      } else {
        category = [...category, ...parsedSuppliers];
      }
    });
  }

  Future<void> getBrands() async {
    brandPage = 0;
    isLoadingMoreForBrand = false;

    final response = await Getbrandlist.getBrandList(
      brandPage,
      brandsearchController.text,
    );
    final List<Map<String, dynamic>> parsedSuppliers =
        List<Map<String, dynamic>>.from(response['data'] ?? []);

    // PrettyPrint.print(response);
    setState(() {
      if (brandPage == 0) {
        brands = parsedSuppliers;
      } else {
        brands = [...brands, ...parsedSuppliers];
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

  Future<void> loadMoreBrands() async {
    if (isLoadingMoreForBrand || noMoreDataForBrand) return;

    isLoadingMoreForBrand = true;
    brandPage++;

    final response = await Getbrandlist.getBrandList(brandPage);

    int totalPage = response["totalPage"];
    List<dynamic> newData = response["data"];

    if (newData.isEmpty || brandPage >= totalPage) {
      noMoreDataForSupplier = true;
    }

    // Convert safely
    final List<Map<String, dynamic>> parsedNew =
        List<Map<String, dynamic>>.from(newData);

    setState(() {
      brands = [...brands, ...parsedNew];
    });

    print('brands scroll triggered $parsedNew');

    isLoadingMoreForBrand = false;
  }

  Future<void> loadMoreCategory() async {
    if (isLoadingMoreForCategory || noMoreDataForCategory) return;

    isLoadingMoreForCategory = true;
    categoryPage++;

    final response = await Getunitlist.getUnitList(categoryPage);

    int totalPage = response["totalPage"];
    List<dynamic> newData = response["data"];

    if (newData.isEmpty || categoryPage >= totalPage) {
      noMoreDataForCategory = true;
    }

    // Convert safely
    final List<Map<String, dynamic>> parsedNew =
        List<Map<String, dynamic>>.from(newData);

    setState(() {
      category = [...category, ...parsedNew];
    });

    // print('brands scroll triggered $parsedNew');

    isLoadingMoreForCategory = false;
  }

  void submitFilter() {
    dynamic filterData = {
      "supplier": selectedSupplier['id'] ?? "",
      "category": selectedCategory['id'] ?? "",
      "brand": selectedBrand['id'] ?? "",
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

  void onSearchBrandsChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    setState(() {
      brandsearchController.text = value;
    });

    _debounce = Timer(const Duration(milliseconds: 400), () {
      getBrands();
    });
  }

  void onSearchCategoryChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    setState(() {
      categorysearchController.text = value;
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

                    Text(
                      'Category',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.colorBlack,
                      ),
                    ),
                    SearchDropdown(
                      items: isloading ? [] : category,
                      hint: "Search Category",
                      onChanged: (e) {
                        selectedCategory = e;
                      },
                      scrollController: supplierScroll,
                      searchOnchanged: (value) =>
                          onSearchCategoryChanged(value),
                    ),

                    Text(
                      'Brand',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.colorBlack,
                      ),
                    ),
                    SearchDropdown(
                      items: isloading ? [] : brands,
                      hint: "search Brand",
                      onChanged: (e) {
                        selectedBrand = e;
                      },
                      scrollController: brandsScroll,
                      searchOnchanged: (value) => onSearchBrandsChanged(value),
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

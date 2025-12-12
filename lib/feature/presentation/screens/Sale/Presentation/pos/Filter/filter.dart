import 'package:bazrin/feature/data/API/Helper/Accounts/getaccountList.dart';
import 'package:bazrin/feature/data/API/Helper/Product/Brand/getBrandList.dart';
import 'package:bazrin/feature/data/API/Helper/Product/Unit/getUnitList.dart';
import 'package:bazrin/feature/data/API/Helper/Product/getProductList.dart';
import 'package:bazrin/feature/presentation/common/Components/customdropdown.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class PosFilter extends StatefulWidget {
  final Function filterSubmit;
  const PosFilter({super.key, required this.filterSubmit});

  @override
  State<PosFilter> createState() => _PosFilterState();
}

class _PosFilterState extends State<PosFilter> {
  List<Map<String, dynamic>> product = [];
  List<Map<String, dynamic>> category = [];
  List<Map<String, dynamic>> brands = [];

  final ScrollController productcroll = ScrollController();
  final ScrollController categoryScroll = ScrollController();
  final ScrollController brandsScroll = ScrollController();

  TextEditingController productearchController = TextEditingController();
  TextEditingController categorysearchController = TextEditingController();
  TextEditingController brandsearchController = TextEditingController();

  int productPage = 0;
  int categoryPage = 0;
  int brandPage = 0;

  bool isLoadingMoreForProduct = false;
  bool isLoadingMoreForCategory = false;
  bool isLoadingMoreForBrand = false;

  bool noMoreDataForProduct = false;
  bool noMoreDataForCategory = false;
  bool noMoreDataForBrand = false;

  bool isloading = false;
  Timer? _debounce;

  dynamic selectedProduct = {};
  dynamic selectedCategory = {};
  dynamic selectedBrand = {};

  @override
  void initState() {
    super.initState();

    productcroll.addListener(() {
      if (productcroll.position.pixels ==
          productcroll.position.maxScrollExtent) {
        loadMoreProduct();
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
    productPage = 0;
    noMoreDataForProduct = false;
    setState(() => isloading = true);

    final res = await Getproductlist.getProductList(
      productPage,
      productearchController.text,
    );

    final List<Map<String, dynamic>> parsedproduct =
        List<Map<String, dynamic>>.from(res['data'] ?? []);

    setState(() {
      if (productPage == 0) {
        product = parsedproduct;
      } else {
        product = [...product, ...parsedproduct];
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

    final List<Map<String, dynamic>> parsedproduct =
        List<Map<String, dynamic>>.from(response['data'] ?? []);

    setState(() {
      if (categoryPage == 0) {
        category = parsedproduct;
      } else {
        category = [...category, ...parsedproduct];
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
    final List<Map<String, dynamic>> parsedproduct =
        List<Map<String, dynamic>>.from(response['data'] ?? []);

    // PrettyPrint.print(response);
    setState(() {
      if (brandPage == 0) {
        brands = parsedproduct;
      } else {
        brands = [...brands, ...parsedproduct];
      }
    });
  }

  Future<void> loadMoreProduct() async {
    if (isLoadingMoreForProduct || noMoreDataForProduct) return;

    isLoadingMoreForProduct = true;
    productPage++;

    final response = await Getproductlist.getProductList(productPage);

    int totalPage = response["totalPage"];
    List<dynamic> newData = response["data"];

    if (newData.isEmpty || productPage >= totalPage) {
      noMoreDataForProduct = true;
    }

    // Convert safely
    final List<Map<String, dynamic>> parsedNew =
        List<Map<String, dynamic>>.from(newData);

    setState(() {
      product = [...product, ...parsedNew];
    });

    print('Product scroll triggered $parsedNew');

    isLoadingMoreForProduct = false;
  }

  Future<void> loadMoreBrands() async {
    if (isLoadingMoreForBrand || noMoreDataForBrand) return;

    isLoadingMoreForBrand = true;
    brandPage++;

    final response = await Getbrandlist.getBrandList(brandPage);

    int totalPage = response["totalPage"];
    List<dynamic> newData = response["data"];

    if (newData.isEmpty || brandPage >= totalPage) {
      noMoreDataForProduct = true;
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
      "Product": selectedProduct['id'] ?? "",
      "category": selectedCategory['id'] ?? "",
      "brand": selectedBrand['id'] ?? "",
    };
    widget.filterSubmit(filterData);
    Navigator.of(context).pop();
    // PrettyPrint.print(filterData);
  }

  void cleanFilterData() {}

  void onSearchProductChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    setState(() {
      productearchController.text = value;
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
                      scrollController: productcroll,
                      searchOnchanged: (value) => onSearchProductChanged(value),
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
                      scrollController: productcroll,
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

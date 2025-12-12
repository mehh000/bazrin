import 'package:bazrin/feature/data/API/Helper/Pos/Sale/getPosProductList.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/classes/prettyPrint.dart';
import 'package:bazrin/feature/presentation/screens/Sale/Presentation/pos/Filter/filter.dart';
import 'package:bazrin/feature/presentation/screens/Sale/Presentation/pos/Main/Components/pos_drawer.dart';
import 'package:bazrin/feature/presentation/screens/Sale/Presentation/pos/widgets/productCard.dart';
import 'package:bazrin/feature/presentation/screens/Sale/Presentation/payemnt/paayment.dart';
import 'package:bazrin/feature/presentation/screens/Sale/Components/product_search.dart';

class Pos extends StatefulWidget {
  const Pos({super.key});

  @override
  State<Pos> createState() => _PosState();
}

class _PosState extends State<Pos> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic posItems;
  bool isloading = false;
  dynamic selectedItems = [];

  final ScrollController _scrollController = ScrollController();
  int page = 0;
  bool isLoadingMore = false;
  bool noMoreData = false;

  String productId = '';
  String categoryId = '';
  String brandId = '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
    getposItems();
  }

  Future<void> getposItems() async {
    page = 0;
    noMoreData = false;
    setState(() => isloading = true);

    final response = await Getposproductlist.getPosProductList(page);

    setState(() {
      posItems = response;
      isloading = false;
    });
  }

  Future<void> loadMore() async {
    if (isLoadingMore || noMoreData) return;

    isLoadingMore = true;
    page = page + 1;

    final response = await Getposproductlist.getPosProductList(page);

    if (response.isEmpty) {
      noMoreData = true;
    } else {
      setState(() {
        posItems.addAll(response);
      });
    }

    isLoadingMore = false;
  }

  void addItemToCart(item) {
    final id = item['id'];

    final index = selectedItems.indexWhere((e) => e['id'] == id);

    if (index == -1) {
      selectedItems.add(item);
    } else {
      selectedItems.removeAt(index);
    }
    setState(() {});
  }

  void incrementAddedItemToCart(item) {
    final id = item['id'];

    final index = selectedItems.indexWhere((e) => e['id'] == id);

    if (index != -1) {
      selectedItems[index] = item;
    }
    setState(() {});
  }

  void filterFuntion(filter) {
    setState(() {
      productId = filter['Product'];
      categoryId = filter['category'];
      brandId = filter['brand'];
    });
    getposItems();
    // PrettyPrint.print(filter);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          backgroundColor: AppColors.Colorprimary,
          child: PosDrawer(),
        ),
        backgroundColor: AppColors.Colorprimary,
        body: Column(
          children: [
            const SizedBox(height: 20),

            // 🔹 Top Bar
            Container(
              color: AppColors.Colorprimary,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                spacing: 20, // ✅ works in latest Flutter
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    child: SvgPicture.asset(
                      'assets/images/icons/3bar.svg',
                      width: 30,
                      height: 30,
                    ),
                  ),

                  // Search bar expanded to fit space
                  const Expanded(child: ProductSearch()),
                  GestureDetector(
                    onTap: () {
                      FullScreenRightDialog.open(
                        context: context,
                        child: PosFilter(
                          filterSubmit: (f) {
                            filterFuntion(f);
                          },
                        ), // your custom widget
                      );
                    },
                    child: SvgPicture.asset(
                      'assets/images/icons/filter.svg',
                      height: 28,
                      width: 24,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                color: Color(0xFFF5F5F7),
                child: isloading
                    ? Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: getposItems,
                        child: AlignedGridView.count(
                          controller: _scrollController,
                          physics: AlwaysScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          itemCount: posItems.length,
                          itemBuilder: (context, index) {
                            return Productcard(
                              posItems: posItems[index],
                              addfuntion: (e) {
                                addItemToCart(e);
                              },
                              addremovefuntion: (e) {
                                incrementAddedItemToCart(e);
                              },
                            );
                          },
                        ),
                      ),
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              width: double.infinity,
              height: 65,
              color: Colors.white,
              child: Row(
                spacing: 35,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: AppColors.Colorprimary,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          color: AppColors.Colorprimary,
                          size: 20,
                        ),
                        Text(
                          '${selectedItems.length}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.Colorprimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ButtonEv(
                      title: "Add to cart",
                      colorData: AppColors.Colorprimary,
                      buttonFunction: () {
                        Navigator.of(context).push(
                          SlidePageRoute(
                            page: Paayment(selectedItems: selectedItems),
                            direction: SlideDirection.right,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:bazrin/feature/data/API/Helper/Pos/Sale/deletePosSalebyId.dart';
import 'package:bazrin/feature/data/API/Helper/Pos/Sale/getPosSale.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/classes/prettyPrint.dart';
import 'package:bazrin/feature/presentation/screens/Sale/Presentation/ManageSales/Filter/filter.dart';
import 'package:bazrin/feature/presentation/screens/Sale/Presentation/ManageSales/Main/Components/manage_sell_card.dart';
import 'package:flutter/widgets.dart';

class ManageSales extends StatefulWidget {
  const ManageSales({super.key});

  @override
  State<ManageSales> createState() => _ManageSalesState();
}

class _ManageSalesState extends State<ManageSales> {
  dynamic sales;

  final ScrollController _scrollController = ScrollController();
  int page = 0;
  bool isLoadingMore = false;
  bool noMoreData = false;
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
    getSales();
  }

  Future<void> getSales() async {
    page = 0;
    noMoreData = false;
    setState(() {
      isloading = true;
    });

    final response = await Getpossale.getPosSale(page);
    setState(() {
      sales = response['data'];
      isloading = false;
    });
  }

  Future<void> loadMore() async {
    if (isLoadingMore || noMoreData) return;

    isLoadingMore = true;
    page++;

    final response = await Getpossale.getPosSale(page);

    int totalPage = response["totalPage"];
    List<dynamic> newData = response["data"];

    if (newData.isEmpty || page >= totalPage) {
      noMoreData = true;
    }

    // Convert safely
    final List<Map<String, dynamic>> parsedNew =
        List<Map<String, dynamic>>.from(newData);

    setState(() {
      sales.addAll(parsedNew);
    });

    isLoadingMore = false;
  }

  void delete(id) async {
    final resposne = await Deletepossalebyid.deletePosSalebyId(id);
    if (resposne == 'success') {
      TostMessage.showToast(
        context,
        message: "Order Delete Successfully done",
        isSuccess: true,
      );
    }
    getSales();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.Colorprimary,
          leading: Row(
            children: [
              SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    SlidePageRoute(
                      page: HomeScreen(),
                      direction: SlideDirection.left,
                    ),
                  );
                },
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ],
          ),
          title: Text(
            'Manage Sales',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () {
                  FullScreenRightDialog.open(
                    context: context,
                    child: ManageSalesFilter(filterSubmit: (f) {}),
                  );
                },
                child: SvgPicture.asset(
                  'assets/images/icons/filter.svg',
                  height: 24,
                  width: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.Colorprimary,
        body: Column(
          children: [
            SizedBox(height: 20),

            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F7),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: isloading
                    ? Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () => getSales(),
                        child: ListView.separated(
                          controller: _scrollController,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 6),
                          itemCount: sales.length ?? 0,
                          itemBuilder: (context, index) {
                            if (sales.isEmpty) return SizedBox.shrink();

                            // 🔥 Load-more footer
                            if (index == sales.length) {
                              return isLoadingMore
                                  ? const Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : const SizedBox.shrink();
                            }
                            return ManageSellCard(
                              sale: sales[index],
                              delfuntion: (id) {
                                delete(id);
                              },
                            );
                          },
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

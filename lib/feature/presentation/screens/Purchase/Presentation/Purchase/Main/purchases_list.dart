import 'package:bazrin/feature/data/API/Helper/Purchase/deletePurchaseById.dart';
import 'package:bazrin/feature/data/API/Helper/Purchase/getPurchase.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/classes/prettyPrint.dart';
import 'package:bazrin/feature/presentation/screens/Purchase/Components/purchase.dart';
import 'package:bazrin/feature/presentation/screens/Purchase/Presentation/Purchase/Filter/filter.dart';

class PurchasesList extends StatefulWidget {
  const PurchasesList({super.key});

  @override
  State<PurchasesList> createState() => _PurchasesListState();
}

class _PurchasesListState extends State<PurchasesList> {
  dynamic purchaseList = [];
  bool _isExpanded = false;
  bool isLoaded = true;

  final ScrollController _scrollController = ScrollController();
  int page = 0;
  bool isLoadingMore = false;
  bool noMoreData = false;
  bool isloading = false;

  String supplierId = '';
  String returntypes = '';
  String productId = '';
  String startMonth = '';
  String endMonth = '';  

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
    getPurchases();
  }

  void _toggleExpand() {
    if (_isExpanded) {
      Navigator.of(context).push(
        SlidePageRoute(page: AddPurchase(), direction: SlideDirection.right),
      );
    } else {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }
  }

  Future<void> getPurchases() async {
    page = 0;
    noMoreData = false;
    final response = await Getpurchase.getPurchaseList(
      page,
      supplierId,
      productId,
      '',
      startMonth,
      endMonth,
    );
    setState(() {
      purchaseList = response['data'];
      isLoaded = true;
    });
  }

  Future<void> loadMore() async {
    if (isLoadingMore || noMoreData) return;

    isLoadingMore = true;
    page++;

    final response = await Getpurchase.getPurchaseList(page);

    int totalPage = response["totalPage"];
    List<dynamic> newData = response["data"];

    if (newData.isEmpty || page >= totalPage) {
      noMoreData = true;
    }

    // Convert safely
    final List<Map<String, dynamic>> parsedNew =
        List<Map<String, dynamic>>.from(newData);

    setState(() {
      purchaseList.addAll(parsedNew);
    });

    isLoadingMore = false;
  }

  void delete(id) async {
    final response = await Deletepurchasebyid.DeletePurchase(id);
    if (response == 'success') {
      getPurchases();
      TostMessage.showToast(
        context,
        message: "Customer deleted successfully",
        isSuccess: true,
      );
    }
  }

  void filterFuntion(filter) {
    setState(() {
      supplierId = filter['supplier'];
      productId = filter['Product'];
      startMonth = filter['startMonth'];
      endMonth = filter['endingMonth'];
    });
    getPurchases();
    // PrettyPrint.print(filter);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FlowtingIconButton(
          isExpanded: _isExpanded,
          toggleExpand: _toggleExpand,
          title: 'Add Purchase',
        ),
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
            'Purchase List',
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
                    child: PurchaseFilter(
                      filterSubmit: (e) {
                        filterFuntion(e);
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
            ),
          ],
        ),
        backgroundColor: AppColors.Colorprimary,
        body: Stack(
          children: [
            Column(
              children: [
                // ======Header=========
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
                    child: RefreshIndicator(
                      onRefresh: () => getPurchases(),
                      child: ListView.builder(
                        controller: _scrollController,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: purchaseList.length,

                        itemBuilder: (context, index) {
                          if (purchaseList.isEmpty) return SizedBox.shrink();

                          // 🔥 Load-more footer
                          if (index == purchaseList.length) {
                            return isLoadingMore
                                ? const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : const SizedBox.shrink();
                          }
                          final purchase = purchaseList[index];
                          return Purchase(purchase: purchase, delete: delete);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),

            if (_isExpanded)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => setState(() => _isExpanded = false),
                  child: Container(color: Colors.transparent),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

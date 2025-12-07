import 'package:bazrin/feature/data/API/Helper/Pos/Sale/deleteSaleReturnTypebyId.dart';
import 'package:bazrin/feature/data/API/Helper/Pos/Sale/getSaleReturnTypes.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/screens/Sale/Presentation/SaleReturnTypes/Add/add_sale_return_type.dart';
import 'package:bazrin/feature/presentation/screens/Sale/Presentation/SaleReturnTypes/Components/sale_return_type_card.dart';

class SaleReturnTypes extends StatefulWidget {
  const SaleReturnTypes({super.key});

  @override
  State<SaleReturnTypes> createState() => _SaleReturnTypesState();
}

class _SaleReturnTypesState extends State<SaleReturnTypes> {
  dynamic saleReturns = [];
  final ScrollController _scrollController = ScrollController();
  int page = 0;
  bool isLoadingMore = false;
  bool noMoreData = false;
  bool isloading = false;
  bool _isExpanded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
    getSaleReturnTypes();
  }

  void _toggleExpand() {
    if (_isExpanded) {
      Navigator.of(context).push(
        SlidePageRoute(
          page: AddSaleReturnType(),
          direction: SlideDirection.right,
        ),
      );
    } else {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }
  }

  Future<void> getSaleReturnTypes() async {
    page = 0;
    noMoreData = false;
    final response = await Getsalereturntypes.getSaleReturnTypes();
    setState(() {
      saleReturns = response['data'];
    });
  }

  Future<void> loadMore() async {
    if (isLoadingMore || noMoreData) return;

    isLoadingMore = true;
    page++;

    final response = await Getsalereturntypes.getSaleReturnTypes();

    int totalPage = response["totalPage"];
    List<dynamic> newData = response["data"];

    if (newData.isEmpty || page >= totalPage) {
      noMoreData = true;
    }

    // Convert safely
    final List<Map<String, dynamic>> parsedNew =
        List<Map<String, dynamic>>.from(newData);

    setState(() {
      saleReturns.addAll(parsedNew);
    });

    isLoadingMore = false;
  }

  void delete(id) async {
    final resposne = await Deletesalereturntypebyid.deleteSaleReturntypebyId(
      id,
    );
    if (resposne == 'success') {
      TostMessage.showToast(
        context,
        message: "Sale Return Type Successfully Deleted",
        isSuccess: true,
      );
    }
    getSaleReturnTypes();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FlowtingIconButton(
          isExpanded: _isExpanded,
          toggleExpand: _toggleExpand,
          title: 'Add Return Type',
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
            'Sales Return types',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: AppColors.Colorprimary,
        body: Stack(
          children: [
            Column(
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
                    child: RefreshIndicator(
                      onRefresh: getSaleReturnTypes, // your refresh function
                      child: ListView.separated(
                        controller:
                            _scrollController, // add if you want infinite scroll
                        physics: const AlwaysScrollableScrollPhysics(),
                        separatorBuilder: (_, __) => const SizedBox(height: 5),
                        itemCount:
                            saleReturns.length + 1, // +1 for load more footer
                        itemBuilder: (context, index) {
                          // Load more footer
                          if (index == saleReturns.length) {
                            return isLoadingMore
                                ? const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : const SizedBox.shrink();
                          }

                          final saleReturn = saleReturns[index];
                          return SaleReturnTypeCard(
                            pro: saleReturn,
                            delete: (id) {
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

import 'package:bazrin/feature/data/API/Helper/Supplier/suppliersPayments.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/classes/prettyPrint.dart';
import 'package:bazrin/feature/presentation/screens/supplier/Presentation/PurchaseDue/Filter/filter.dart';

class SupplierPurchaseDueList extends StatefulWidget {
  const SupplierPurchaseDueList({super.key});

  @override
  State<SupplierPurchaseDueList> createState() =>
      _SupplierPurchaseDueListState();
}

class _SupplierPurchaseDueListState extends State<SupplierPurchaseDueList> {
  dynamic advacneList;
  final ScrollController _scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  int page = 0;
  bool isLoadingMore = false;
  bool noMoreData = false;
  bool isloading = false;
  Timer? _debounce;
  String supplierID = '';
  String accountID = '';

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
    getAdvance();
  }

  void getAdvance() async {
    page = 0;
    noMoreData = false;
    final response = await Supplierspayments.getSupplierPayments(
      'PURCHASE_DUE_PAYMENT',
      page,
      searchController.text,
      supplierID,
      accountID,
    );
    setState(() {
      advacneList = response['data'];
    });
    print('advance : ${response['data']}');
  }

  Future<void> loadMore() async {
    if (isLoadingMore || noMoreData) return;

    isLoadingMore = true;
    page++;

    final response = await Supplierspayments.getSupplierPayments(
      'PURCHASE_DUE_PAYMENT',
      page,
    );

    int totalPage = response["totalPage"];
    List<dynamic> newData = response["data"];

    if (newData.isEmpty || page >= totalPage) {
      noMoreData = true;
    }

    // Convert safely
    final List<Map<String, dynamic>> parsedNew =
        List<Map<String, dynamic>>.from(newData);

    setState(() {
      advacneList.addAll(parsedNew);
    });

    isLoadingMore = false;
  }

  void onSearchChanged(String text) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    setState(() {
      searchController.text = text;
    });

    _debounce = Timer(const Duration(milliseconds: 400), () {
      // Call your API here
      // searchApi(text);
      getAdvance();
    });
  }

  void filterFuntion(filter) {
    setState(() {
      accountID = filter['account'];
      supplierID = filter['supplier'];
    });
    getAdvance();
    // PrettyPrint.print(filter);
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
            'Purchase Due',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: AppColors.Colorprimary,
        body: Column(
          children: [
            Container(
              color: AppColors.Colorprimary,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Row(
                spacing: 30,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) => onSearchChanged(value),
                      decoration: InputDecoration(
                        hint: Text(
                          'Search With InvoiceNumber',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.Colorprimary,
                          ),
                        ),
                        suffixIcon: Icon(
                          Icons.search,
                          size: 25,
                          color: AppColors.Colorprimary,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 13,
                          horizontal: 11,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 14, // match your design
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      FullScreenRightDialog.open(
                        context: context,
                        child: PurchaseDueFilter(
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
                ],
              ),
            ),
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
                  onRefresh: () async {
                    getAdvance();
                  },
                  child: RefreshIndicator(
                    onRefresh: () async {
                      getAdvance();
                    },
                    child: ListView.separated(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount:
                          (advacneList?.length ?? 0) + 1, // +1 for footer
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 6),

                      itemBuilder: (context, index) {
                        final list = advacneList ?? [];

                        // FOOTER ITEM
                        if (index == list.length) {
                          return isLoadingMore
                              ? const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : const SizedBox.shrink();
                        }

                        // NORMAL ITEM
                        final ad = list[index];
                        return SupplierPurchaseDueCard(pur: ad);
                      },
                    ),
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

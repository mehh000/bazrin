import 'package:bazrin/feature/data/API/Helper/Supplier/suppliersPayments.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/screens/Supplier/Presentation/ReturnDuePaid/Components/supplier_return_due_card.dart';
import 'package:bazrin/feature/presentation/screens/Supplier/Presentation/ReturnDuePaid/Filter/filter.dart';

class ReturnDueList extends StatefulWidget {
  const ReturnDueList({super.key});

  @override
  State<ReturnDueList> createState() => _ReturnDueListState();
}

class _ReturnDueListState extends State<ReturnDueList> {
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
      'PURCHASE_RETURN_DUE_PAYMENT',
      page,
      searchController.text,
      supplierID,
      accountID,
    );
    setState(() {
      advacneList = response['data'];
    });
    // print('advance : ${response[0]}');
  }

  Future<void> loadMore() async {
    if (isLoadingMore || noMoreData) return;

    isLoadingMore = true;
    page++;

    final response = await Supplierspayments.getSupplierPayments(
      'PURCHASE_RETURN_DUE_PAYMENT',
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
            'Return Due Paid',
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
                          'Search With Invoice Number',

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
                        child: ReturnDuePaidFilter(
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
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 5),

                    itemCount: advacneList?.length ?? 0,

                    itemBuilder: (context, index) {
                      if (index == advacneList.length) {
                        return isLoadingMore
                            ? const Padding(
                                padding: EdgeInsets.all(16),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : SizedBox.shrink();
                      }
                      final ad = advacneList[index];
                      return SupplierReturnDuePaidCard(ret: ad);
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

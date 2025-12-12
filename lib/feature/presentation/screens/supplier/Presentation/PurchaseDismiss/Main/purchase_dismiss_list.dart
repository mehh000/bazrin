import 'package:bazrin/feature/data/API/Helper/Supplier/suppliersPayments.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/screens/supplier/Presentation/PurchaseDismiss/Components/supplier_purchase_dismiss_card.dart';
import 'package:bazrin/feature/presentation/screens/supplier/Presentation/PurchaseDismiss/Filter/filter.dart';

class PurchaseDismissList extends StatefulWidget {
  const PurchaseDismissList({super.key});

  @override
  State<PurchaseDismissList> createState() => _PurchaseDismissListState();
}

class _PurchaseDismissListState extends State<PurchaseDismissList> {
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
    getItems();
  }

  void getItems() async {
    page = 0;
    noMoreData = false;
    setState(() {
      isloading = true;
    });
    final response = await Supplierspayments.getSupplierPayments(
      'PURCHASE_RETURN_DUE_PAYMENT',
      page,
      searchController.text,
      supplierID,
      accountID,
    );
    setState(() {
      advacneList = response['data'];
      isloading = false;
    });
    print('Purchase dismis : ${response}');
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
      getItems();
    });
  }

  void filterFuntion(filter) {
    setState(() {
      accountID = filter['account'];
      supplierID = filter['supplier'];
    });
    getItems();
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
            'Purchase Dismiss List',
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
                      onChanged: (value) => onSearchChanged(value),
                      controller: searchController,
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
                        child: SupplierPurchaseDismissFilter(
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
                child: isloading
                    ? Center(
                        child: Text(
                          'No More Data',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          getItems();
                        },
                        child: ListView.separated(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),

                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 5),

                          itemCount:
                              (advacneList?.length ?? 0) + 1, // +1 for footer

                          itemBuilder: (context, index) {
                            // FOOTER LOADER (last position)
                            if (index == advacneList.length) {
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
                            final ad = advacneList[index];
                            return SupplierPurchaseDismissCard(ret: ad);
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

import 'package:bazrin/feature/data/API/Helper/Supplier/suppliersPayments.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/classes/prettyPrint.dart';
import 'package:bazrin/feature/presentation/screens/Supplier/Presentation/Advance/Filter/filter.dart';
import 'package:bazrin/feature/presentation/screens/Supplier/Components/advancepaycard.dart';

class AdvanceSupplier extends StatefulWidget {
  const AdvanceSupplier({super.key});

  @override
  State<AdvanceSupplier> createState() => _AdvanceSupplierState();
}

class _AdvanceSupplierState extends State<AdvanceSupplier> {
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

  Future<void> loadMore() async {
    if (isLoadingMore || noMoreData) return;

    isLoadingMore = true;
    page++;

    final response = await Supplierspayments.getSupplierPayments(
      'ADVANCE_PAYMENT',
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

  void getAdvance() async {
    page = 0;
    noMoreData = false;
    setState(() {
      isloading = true;
    });
    final response = await Supplierspayments.getSupplierPayments(
      'ADVANCE_PAYMENT',
      page,
      searchController.text,
      supplierID,
      accountID,
    );
    setState(() {
      advacneList = response['data'];
      isloading = false;
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
            'Advance',
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
                          'Search Invoice Number',
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
                        child: SupplierAdvanceFilter(
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
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          getAdvance();
                        },
                        child: isloading
                            ? Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : ListView.separated(
                                controller: _scrollController,
                                physics: const AlwaysScrollableScrollPhysics(),

                                // +1 for footer
                                itemCount: (advacneList?.length ?? 0) + 1,

                                itemBuilder: (context, index) {
                                  if (index == advacneList.length) {
                                    // Footer widget
                                    if (noMoreData) {
                                      return Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 16,
                                          ),
                                          child: Text(
                                            "No more data",
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return SizedBox.shrink();
                                    }
                                  }

                                  final ad = advacneList[index];
                                  return AdvancePayCard(adv: ad);
                                },

                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 6),
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

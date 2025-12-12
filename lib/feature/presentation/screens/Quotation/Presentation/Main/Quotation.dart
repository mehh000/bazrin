import 'package:bazrin/feature/data/API/Helper/Quotation/deleteQuotationById.dart';
import 'package:bazrin/feature/data/API/Helper/Quotation/getQuotationList.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/classes/prettyPrint.dart';
import 'package:bazrin/feature/presentation/screens/Quotation/Presentation/Main/Components/QuotationCard.dart';
import 'package:flutter/widgets.dart';

class Quotation extends StatefulWidget {
  const Quotation({super.key});

  @override
  State<Quotation> createState() => _QuotationState();
}

class _QuotationState extends State<Quotation> {
  dynamic quotationList;
  bool _isExpanded = false;

  final ScrollController _scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  int page = 0;
  bool isLoadingMore = false;
  bool noMoreData = false;
  bool isloading = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
    getquotations();
  }

  void _toggleExpand() {
    if (_isExpanded) {
      Navigator.of(context).push(
        SlidePageRoute(page: AddQuation(), direction: SlideDirection.right),
      );
    } else {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }
  }

  Future<void> getquotations() async {
    page = 0;
    noMoreData = false;
    setState(() {
      isloading = true;
    });
    final response = await Getquotationlist.getQuotationList(
      page,
      searchController.text,
    );
    setState(() {
      quotationList = response['data'];
      isloading = false;
    });
  }

  Future<void> loadMore() async {
    if (isLoadingMore || noMoreData) return;

    isLoadingMore = true;
    page++;

    final response = await Getquotationlist.getQuotationList(page);

    int totalPage = response["totalPage"];
    List<dynamic> newData = response["data"];

    if (newData.isEmpty || page >= totalPage) {
      noMoreData = true;
    }

    // Convert safely
    final List<Map<String, dynamic>> parsedNew =
        List<Map<String, dynamic>>.from(newData);

    setState(() {
      quotationList.addAll(parsedNew);
    });

    isLoadingMore = false;
  }

  void delete(id) async {
    final resposne = await Deletequotationsbyid.DeleteQuotations(id);
    if (resposne == 'success') {
      getquotations();
      TostMessage.showToast(
        context,
        message: "Quotation deleted successfully",
        isSuccess: false,
      );
      getquotations();
    }
  }

  void onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    setState(() {
      searchController.text = value;
    });

    _debounce = Timer(const Duration(milliseconds: 400), () {
      getquotations();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FlowtingIconButton(
          isExpanded: _isExpanded,
          toggleExpand: _toggleExpand,
          title: 'Add Quotation',
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
            'Manage Quotation',
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
                // ======Header=========
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
                              'Search Quotation Number',
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

                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.of(context).push(
                      //       SlidePageRoute(
                      //         page: Filter(),
                      //         direction: SlideDirection.right,
                      //       ),
                      //     );
                      //   },
                      //   child: SvgPicture.asset(
                      //     'assets/images/icons/filter.svg',
                      //     height: 28,
                      //     width: 24,
                      //     color: Colors.white,
                      //   ),
                      // ),
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
                            onRefresh: () => getquotations(),
                            child: ListView.separated(
                              controller: _scrollController,
                              itemCount: quotationList.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 6),
                              itemBuilder: (context, index) {
                                if (quotationList.isEmpty)
                                  return SizedBox.shrink();

                                if (index == quotationList.length) {
                                  return isLoadingMore
                                      ? const Padding(
                                          padding: EdgeInsets.all(16),
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        )
                                      : const SizedBox.shrink();
                                }
                                return Quotationcard(
                                  quotation: quotationList[index],
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

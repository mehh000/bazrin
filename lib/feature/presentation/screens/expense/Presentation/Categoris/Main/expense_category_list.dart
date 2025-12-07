import 'package:bazrin/feature/data/API/Helper/Expense/delExpenseCategory.dart';
import 'package:bazrin/feature/data/API/Helper/Expense/getExpenseCategoryList.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/screens/expense/Components/expense_category_card.dart';

class ExpenseCategoryList extends StatefulWidget {
  const ExpenseCategoryList({super.key});

  @override
  State<ExpenseCategoryList> createState() => _ExpenseCategoryListState();
}

class _ExpenseCategoryListState extends State<ExpenseCategoryList> {
  bool _isExpanded = false;
  List<Map<String, dynamic>> expenseCategoryListData = [];

  final ScrollController _scrollController = ScrollController();
  int page = 0;
  bool isLoadingMore = false;
  bool noMoreData = false;
  bool isloading = false;

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
    getCategory();
  }

  Future<void> getCategory() async {
    page = 0;
    noMoreData = false;
    try {
      final response = await Getexpensecategorylist.getExpenseCategoryList(
        page,
      );

      // Safely cast and convert
      final List<Map<String, dynamic>> parsedList = (response['data'] as List)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();

      setState(() {
        expenseCategoryListData = parsedList;
      });

      // print('category data : $expenseCategoryListData');
    } catch (e) {
      // print('Error loading categories: $e');
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore || noMoreData) return;

    isLoadingMore = true;
    page++;

    final response = await Getexpensecategorylist.getExpenseCategoryList(page);

    int totalPage = response["totalPage"];
    List<dynamic> newData = response["data"];

    if (newData.isEmpty || page >= totalPage) {
      noMoreData = true;
    }

    // Convert safely
    final List<Map<String, dynamic>> parsedNew =
        List<Map<String, dynamic>>.from(newData);

    setState(() {
      expenseCategoryListData.addAll(parsedNew);
    });

    isLoadingMore = false;
  }

  void delete(id) async {
    await Delexpensecategory.DeleteExpenseCategory(id);
    getCategory();
  }

  void _toggleExpand() {
    if (_isExpanded) {
      Navigator.of(context).push(
        SlidePageRoute(
          page: AddExpenseCategory(),
          direction: SlideDirection.right,
        ),
      );
    } else {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FlowtingIconButton(
          isExpanded: _isExpanded,
          toggleExpand: _toggleExpand,
          title: 'Add Category',
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
            'Expense Category',
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
                      onRefresh: getCategory, // your refresh function
                      child: ListView.separated(
                        controller:
                            _scrollController, // if you plan to add infinite scroll
                        physics: const AlwaysScrollableScrollPhysics(),
                        separatorBuilder: (_, __) => const SizedBox(height: 5),
                        itemCount:
                            expenseCategoryListData.length +
                            1, // +1 for load more
                        itemBuilder: (context, index) {
                          // Load more footer
                          if (index == expenseCategoryListData.length) {
                            return isLoadingMore
                                ? const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : const SizedBox.shrink();
                          }

                          final cat = expenseCategoryListData[index];
                          return ExpenseCategoryCard(
                            cat: cat,
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

import 'package:bazrin/feature/data/API/Helper/Expense/deleteExpenseById.dart';
import 'package:bazrin/feature/data/API/Helper/Expense/getExpenseList.dart';
import 'package:bazrin/feature/presentation/common/Components/pagination.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/screens/Expense/Components/expense.dart';
import 'package:bazrin/feature/presentation/screens/Expense/Presentation/Expense/Filter/filter.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList({super.key});

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  bool _isExpanded = false;
  List<dynamic> expense_data_list = [];
  final ScrollController _scrollController = ScrollController();
  int page = 0;
  bool isLoadingMore = false;
  bool noMoreData = false;
  bool isloading = false;
  int totalPage = 0;

  String expenseCategoryId = '';
  String expenseProductId = '';
  String startMonth = '';
  String endMonth = '';

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
    getExpenseList();
  }

  Future<void> getExpenseList() async {
    page = 0;
    noMoreData = false;
    setState(() {
      isloading = true;
    });
    try {
      final response = await GetexpenseList.getExpenseList(
        page,
        expenseProductId,
        expenseCategoryId,
        startMonth,
        endMonth,
      );

      setState(() {
        expense_data_list = response['data'];
        totalPage = response['totalPage'];
        isloading = false;
      });
    } catch (e) {
      setState(() {
        isloading = false;
      });
      // print(e);
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore || noMoreData) return;

    isLoadingMore = true;
    page++;

    final response = await GetexpenseList.getExpenseList(page);

    int totalPage = response["totalPage"];
    List<dynamic> newData = response["data"];

    if (newData.isEmpty || page >= totalPage) {
      noMoreData = true;
    }

    // Convert safely
    final List<Map<String, dynamic>> parsedNew =
        List<Map<String, dynamic>>.from(newData);

    setState(() {
      expense_data_list.addAll(parsedNew);
    });

    isLoadingMore = false;
  }

  void _toggleExpand() {
    if (_isExpanded) {
      Navigator.of(context).push(
        SlidePageRoute(page: AddExpense(), direction: SlideDirection.right),
      );
    } else {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }
  }

  void deleteExpense(id) async {
    // print('id : $id');
    try {
      await Deleteexpensebyid.DeleteExpense(id);
      getExpenseList();
    } catch (e) {
      // print(e);
    }
  }

  void filterFuntion(filter) {
    setState(() {
      expenseCategoryId = filter['ExpenseCategory'];
      expenseProductId = filter['expenseProduct'];
      startMonth = filter['startMonth'];
      endMonth = filter['endingMonth'];
    });
    getExpenseList();
    // PrettyPrint.print(filter);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FlowtingIconButton(
          isExpanded: _isExpanded,
          toggleExpand: _toggleExpand,
          title: 'Add Expense',
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
            'Expense List',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {
                  FullScreenRightDialog.open(
                    context: context,
                    child: ExpenseFilter(
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
            ),
          ],
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
                      onRefresh: getExpenseList,
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller: _scrollController,
                        itemCount: expense_data_list.length + 1,
                        itemBuilder: (context, index) {
                          if (index == expense_data_list.length) {
                            if (noMoreData) {
                              return Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Text(
                                    "No more Expense",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              );
                            } else {
                              return SizedBox.shrink();
                            }
                          }
                          final ex = expense_data_list[index];
                          return Expense(
                            expenseData: ex,
                            delete: (e) {
                              deleteExpense(e);
                            },
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 6),
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

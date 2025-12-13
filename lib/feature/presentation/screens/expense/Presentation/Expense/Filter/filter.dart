import 'package:bazrin/feature/data/API/Helper/Expense/getExpenseCategoryList.dart';
import 'package:bazrin/feature/data/API/Helper/Expense/getExpenseProductsList.dart';
import 'package:bazrin/feature/presentation/common/Components/customdropdown.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/classes/prettyPrint.dart';
import 'package:intl/intl.dart';

class ExpenseFilter extends StatefulWidget {
  final Function filterSubmit;
  const ExpenseFilter({super.key, required this.filterSubmit});

  @override
  State<ExpenseFilter> createState() => _ExpenseFilterState();
}

class _ExpenseFilterState extends State<ExpenseFilter> {
  List<Map<String, dynamic>> expenseCategory = [];
  List<Map<String, dynamic>> expenseProduct = [];

  final ScrollController expenseCategorycroll = ScrollController();
  final ScrollController expenseProductScroll = ScrollController();

  TextEditingController expenseCategoryearchController =
      TextEditingController();
  TextEditingController expenseProductearchController = TextEditingController();

  int expenseCategoryPage = 0;
  int expenseProductpage = 0;

  bool isLoadingMoreForExpenseCategory = false;
  bool isLoadingMoreForexpenseProduct = false;

  bool noMoreDataForExpenseCategory = false;
  bool noMoreDataForexpenseProduct = false;

  bool isloading = false;
  Timer? _debounce;

  dynamic selectedExpenseCategory = {};
  dynamic selectedexpenseProduct = {};

  DateTime? staringDate;
  DateTime? endingDate;

  @override
  void initState() {
    super.initState();

    expenseCategorycroll.addListener(() {
      if (expenseCategorycroll.position.pixels ==
          expenseCategorycroll.position.maxScrollExtent) {
        loadMoreExpenseCategory();
      }
    });
    expenseProductScroll.addListener(() {
      if (expenseProductScroll.position.pixels ==
          expenseProductScroll.position.maxScrollExtent) {
        loadMoreexpenseProduct();
      }
    });

    getSupplie();
    getexpenseProduct();
  }

  void getSupplie() async {
    expenseCategoryPage = 0;
    noMoreDataForExpenseCategory = false;
    setState(() => isloading = true);

    final res = await Getexpensecategorylist.getExpenseCategoryList(
      expenseCategoryPage,
      expenseCategoryearchController.text,
    );

    final List<Map<String, dynamic>> parsedexpenseCategory =
        List<Map<String, dynamic>>.from(res['data'] ?? []);

    setState(() {
      if (expenseCategoryPage == 0) {
        expenseCategory = parsedexpenseCategory;
      } else {
        expenseCategory = [...expenseCategory, ...parsedexpenseCategory];
      }

      isloading = false;
    });
  }

  Future<void> getexpenseProduct() async {
    expenseProductpage = 0;
    isLoadingMoreForexpenseProduct = false;

    final response = await Getexpenseproductslist.getExpenseProductsList(
      expenseProductpage,
      expenseProductearchController.text,
    );
    final List<Map<String, dynamic>> parsedexpenseCategory =
        List<Map<String, dynamic>>.from(response['data'] ?? []);

    // PrettyPrint.print(response);
    setState(() {
      if (expenseProductpage == 0) {
        expenseProduct = parsedexpenseCategory;
      } else {
        expenseProduct = [...expenseProduct, ...parsedexpenseCategory];
      }
    });
  }

  Future<void> loadMoreExpenseCategory() async {
    if (isLoadingMoreForExpenseCategory || noMoreDataForExpenseCategory) return;

    isLoadingMoreForExpenseCategory = true;
    expenseCategoryPage++;

    final response = await Getexpensecategorylist.getExpenseCategoryList(
      expenseCategoryPage,
    );

    int totalPage = response["totalPage"];
    List<dynamic> newData = response["data"];

    if (newData.isEmpty || expenseCategoryPage >= totalPage) {
      noMoreDataForExpenseCategory = true;
    }

    // Convert safely
    final List<Map<String, dynamic>> parsedNew =
        List<Map<String, dynamic>>.from(newData);

    setState(() {
      expenseCategory = [...expenseCategory, ...parsedNew];
    });

    print('ExpenseCategory scroll triggered $parsedNew');

    isLoadingMoreForExpenseCategory = false;
  }

  Future<void> loadMoreexpenseProduct() async {
    if (isLoadingMoreForexpenseProduct || noMoreDataForexpenseProduct) return;

    isLoadingMoreForexpenseProduct = true;
    expenseProductpage++;

    final response = await Getexpenseproductslist.getExpenseProductsList(
      expenseProductpage,
    );

    int totalPage = response["totalPage"];
    List<dynamic> newData = response["data"];

    if (newData.isEmpty || expenseProductpage >= totalPage) {
      noMoreDataForExpenseCategory = true;
    }

    // Convert safely
    final List<Map<String, dynamic>> parsedNew =
        List<Map<String, dynamic>>.from(newData);

    setState(() {
      expenseProduct = [...expenseProduct, ...parsedNew];
    });

    print('expenseProduct scroll triggered $parsedNew');

    isLoadingMoreForexpenseProduct = false;
  }

  void submitFilter() {
    dynamic filterData = {
      "ExpenseCategory": selectedExpenseCategory['id'] ?? "",

      "expenseProduct": selectedexpenseProduct['id'] ?? "",
      "startMonth": staringDate == null
          ? ''
          : DateFormat(
              'yyyy/MM/dd',
            ).format(DateTime.parse(staringDate.toString())),
      "endingMonth": endingDate == null
          ? ''
          : DateFormat(
              'yyyy/MM/dd',
            ).format(DateTime.parse(endingDate.toString())),
    };
    widget.filterSubmit(filterData);
    Navigator.of(context).pop();
    // PrettyPrint.print(filterData);
  }

  void cleanFilterData() {}

  void onSearchExpenseCategoryChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    setState(() {
      expenseCategoryearchController.text = value;
    });

    _debounce = Timer(const Duration(milliseconds: 400), () {
      getSupplie();
    });
  }

  void onSearchexpenseProductChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    setState(() {
      expenseProductearchController.text = value;
    });

    _debounce = Timer(const Duration(milliseconds: 400), () {
      getexpenseProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      // padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        // color: Color(0xFFF5F5F7),
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Headercomponent(title: 'Filter'),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 13,
                  children: [
                    SizedBox(height: 20),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: DatePicker(
                            onDateSelected: (date) {
                              setState(() {
                                staringDate = date;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.Colorprimary,
                          ),
                          child: Center(
                            child: Image.asset('assets/images/arrowupdown.png'),
                          ),
                        ),
                        Expanded(
                          child: DatePicker(
                            onDateSelected: (date) {
                              setState(() {
                                endingDate = date;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Expense Category',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.colorBlack,
                      ),
                    ),
                    SearchDropdown(
                      items: isloading ? [] : expenseCategory,
                      hint: "search Expense Category",
                      onChanged: (e) {
                        selectedExpenseCategory = e;
                      },
                      scrollController: expenseCategorycroll,
                      searchOnchanged: (value) =>
                          onSearchExpenseCategoryChanged(value),
                    ),

                    Text(
                      'Expense Product',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.colorBlack,
                      ),
                    ),
                    SearchDropdown(
                      items: isloading ? [] : expenseProduct,
                      hint: "search Expense Product",
                      onChanged: (e) {
                        selectedexpenseProduct = e;
                      },
                      scrollController: expenseProductScroll,
                      searchOnchanged: (value) =>
                          onSearchexpenseProductChanged(value),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            width: double.infinity,
            child: Row(
              spacing: 20,
              children: [
                Expanded(
                  child: ButtonEv(
                    title: "Clear",
                    isBorder: true,
                    textColor: Colors.red,
                    borderColor: Colors.red,
                  ),
                ),

                Expanded(
                  child: ButtonEv(
                    title: "Filter",
                    colorData: AppColors.Colorprimary,
                    buttonFunction: submitFilter,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

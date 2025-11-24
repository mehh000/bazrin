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
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategory();
  }

  Future<void> getCategory() async {
    try {
      final response = await Getexpensecategorylist.getExpenseCategoryList();

      // Safely cast and convert
      final List<Map<String, dynamic>> parsedList = (response as List)
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

  void delete(id) async {
    await Delexpensecategory.DeleteExpenseCategory(id);
    getCategory();
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
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: 5,
                        children: expenseCategoryListData
                            .map(
                              (cat) => ExpenseCategoryCard(
                                cat: cat,
                                delete: (id) {
                                  delete(id);
                                },
                              ),
                            )
                            .toList(),
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

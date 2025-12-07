import 'package:bazrin/feature/data/API/Helper/Accounts/getaccountList.dart';
import 'package:bazrin/feature/data/API/Helper/Expense/addExpense.dart';
import 'package:bazrin/feature/data/API/Helper/Expense/getExpenseCategoryList.dart';
import 'package:bazrin/feature/data/API/Helper/Expense/getExpenseProductsList.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/classes/prettyPrint.dart';
import 'package:bazrin/feature/presentation/common/Components/customdropdown.dart';
import 'package:bazrin/feature/presentation/common/Components/search_dropdown.dart';
import 'package:bazrin/feature/presentation/screens/expense/Presentation/Expense/Add/Components/selected_product_card.dart';
// import 'package:quill_delta_to_html/quill_delta_to_html.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  List<Map<String, dynamic>> expenseCategoryListData = [];
  List<Map<String, dynamic>> accountList = [];
  List<Map<String, dynamic>> productsList = [];
  List<Map<String, dynamic>> addexpenseData = [];

  TextEditingController refController = TextEditingController();
  TextEditingController totalPayController = TextEditingController();
  TextEditingController payAmountController = TextEditingController();
  final TextEditingController _productSearchController =
      TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _paytypeSearchController =
      TextEditingController();

  final noteController = QuillController.basic();
  DateTime selectedDate = DateTime.now();
  dynamic selectedProductId = [];
  dynamic paymentData = {};
  dynamic catgeoryObject = {};
  double sum = 0;

  // infinit scroll for category
  final ScrollController cat_scrollController = ScrollController(); 
  int catpage = 0;
  bool noMoreDatacat = false;
  bool isLoadingMorecat = false;

  // infinit scroll for product
  final ScrollController pro_scrollController = ScrollController();
  int propage = 0;
  bool noMoreDatapro = false;
  bool isLoadingMorepro = false;

  @override
  void initState() {
    super.initState();
    cat_scrollController.addListener(() {
      if (cat_scrollController.position.pixels ==
          cat_scrollController.position.maxScrollExtent) {
        loadMoreForCat();
      }
    });
    pro_scrollController.addListener(() {
      if (pro_scrollController.position.pixels ==
          pro_scrollController.position.maxScrollExtent) {
        loadMoreForPro();
      }
    });
    getCategory();
    getacconts();
    getProducts();
  }

  Future<void> getCategory() async {
    catpage = 0;
    noMoreDatacat = false;
    try {
      final response = await Getexpensecategorylist.getExpenseCategoryList(
        catpage,
      );

      final List<Map<String, dynamic>> parsedList = (response['data'] as List)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();

      setState(() {
        expenseCategoryListData = parsedList;
      });

      // print('category data : $parsedList');
    } catch (e) {
      // print('Error loading categories: $e');
    }
  }

  Future<void> loadMoreForCat() async {
    if (isLoadingMorecat || noMoreDatacat) return;

    isLoadingMorecat = true;
    catpage = catpage + 1;

    final response = await Getexpensecategorylist.getExpenseCategoryList(
      catpage,
    );

    int totalPage = response["totalPage"];
    List newData = response["data"];

    if (catpage >= totalPage || newData.isEmpty) {
      noMoreDatacat = true;
    }

    setState(() {
      expenseCategoryListData.addAll(newData as Iterable<Map<String, dynamic>>);
    });

    isLoadingMorecat = false;
  }

  Future<void> loadMoreForPro() async {
    if (isLoadingMorepro || noMoreDatapro) return;

    isLoadingMorepro = true;
    propage++;

    final response = await Getexpenseproductslist.getExpenseProductsList(
      propage,
    );

    int totalPage = response["totalPage"];
    List<dynamic> newData = response["data"];

    if (newData.isEmpty || propage >= totalPage) {
      noMoreDatapro = true;
    }

    // Convert safely
    final List<Map<String, dynamic>> parsedNew =
        List<Map<String, dynamic>>.from(newData);

    setState(() {
      productsList = [
        ...productsList,
        ...parsedNew,
      ]; // create new list instance
    });

    isLoadingMorepro = false;
  }

  Future<void> getacconts() async {
    try {
      final response = await Getaccountlist.getAccountsList();

      // Safely cast and convert
      final List<Map<String, dynamic>> parsedList = (response['data'] as List)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();

      setState(() {
        accountList = parsedList;
      });

      // print('accounts data : $accountList');
    } catch (e) {
      // print('Error loading categories: $e');
    }
  }

  Future<void> getProducts() async {
    propage = 0;
    noMoreDatapro = false;

    try {
      final response = await Getexpenseproductslist.getExpenseProductsList(
        propage,
      );

      final List<Map<String, dynamic>> parsedList =
          List<Map<String, dynamic>>.from(response['data']);

      setState(() {
        productsList = parsedList;
      });
    } catch (e) {
      print("Error loading products: $e");
    }
  }

  void cheakAndAdd(Map<String, dynamic> pro) {
    final index = addexpenseData.indexWhere((item) => item['id'] == pro['id']);

    if (index != -1) {
      addexpenseData[index] = pro;
    } else {
      addexpenseData.add(pro);
    }

    // print('Updated List: $addexpenseData');
  }

  void addExpense() async {
    // final expeseDate =
    final invoiceNumber = refController.text;
    final totalpay = totalPayController.text;
    final payamount = payAmountController.text;
    String onlyDate = selectedDate!.toIso8601String().split('T').first;
    final delta = noteController.document.toDelta();
    final converter = QuillDeltaToHtmlConverter(delta.toJson());
    final html = converter.convert();

    if (invoiceNumber.isEmpty) {
      TostMessage.showToast(
        context,
        message: 'Invoice is Required', // join multiple entries with new line
        isSuccess: false, // assuming it's an error
      );
      return;
    } else if (catgeoryObject.isEmpty) {
      TostMessage.showToast(
        context,
        message: 'Category is Required', // join multiple entries with new line
        isSuccess: false, // assuming it's an error
      );
      return;
    } else if (paymentData.isEmpty) {
      TostMessage.showToast(
        context,
        message:
            'Payment Account is Required', // join multiple entries with new line
        isSuccess: false, // assuming it's an error
      );
      return;
    }

    dynamic addexpeseData = {
      'invoiceNumber': invoiceNumber,
      'totalPay': totalpay,
      'payamount': payamount,
      'date': onlyDate,
      'items': addexpenseData,
      'note': html,
      'category': catgeoryObject,
      'paymentData': paymentData,
    };

    // print('add expense data : $addexpeseData');
    try {
      final respose = await Addexpense.addExpense(addexpeseData);
      if (respose['success'] != null) {
        TostMessage.showToast(
          context,
          message: '${respose['success']['message']}',
          isSuccess: true,
        );
        Navigator.of(context).push(
          SlidePageRoute(page: ExpenseList(), direction: SlideDirection.left),
        );
      } else if (respose['error'] != null) {
        TostMessage.showToast(
          context,
          message:
              (respose['error']['validationErrors'] as Map<String, dynamic>)
                  .entries
                  .map((e) => ' ${e.value}')
                  .join('\n'), // join multiple entries with new line
          isSuccess: false, // assuming it's an error
        );
      }

      // print('add expense response f : $respose');
    } catch (e) {
      // print(e);
    }
  }

  void deleteProductFromSelect(id) {
    setState(() {
      selectedProductId.removeWhere((product) => product['id'] == id['id']);
      sum = sum - id['sum'];
    });
  }

  List<Map<String, dynamic>> addexpenseDataofSum = [];

  void addOrUpdateAndCalculateTotal(Map<String, dynamic> product) {
    // Check if product exists in the list
    final index = addexpenseDataofSum.indexWhere(
      (item) => item['productId'] == product['productId'],
    );

    if (index != -1) {
      // Replace existing product
      addexpenseDataofSum[index] = product;
    } else {
      // Add new product
      addexpenseDataofSum.add(product);
    }

    // Calculate the total sum of all products
    double totalSum = 0.0;
    for (var item in addexpenseDataofSum) {
      double itemTotal = double.tryParse(item['total']?.toString() ?? '0') ?? 0;
      totalSum += itemTotal;
    }

    // print("✅ Current total sum: $totalSum");
    setState(() {
      sum = totalSum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.Colorprimary,
        appBar: AppBar(
          backgroundColor: AppColors.Colorprimary,
          leading: Row(
            children: [
              SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    SlidePageRoute(
                      page: ExpenseList(),
                      direction: SlideDirection.left,
                    ),
                  );
                },
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ],
          ),
          title: Text(
            'Expense Add',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        body: Container(
          width: double.infinity,
          height: double.infinity,
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
              children: [
                Container(
                  width: double.infinity,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Column(
                    children: [
                      Headercomponent(title: "Add Expense"),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: Column(
                          spacing: 12,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DatePicker(
                              label: "Expense Date",
                              required: true,
                              onDateSelected: (date) {
                                setState(() {
                                  selectedDate = date;
                                });
                              },
                            ),
                            Row(
                              children: [
                                Text(
                                  'Expense Category',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: AppColors.colorBlack,
                                  ),
                                ),
                                Text(
                                  '*',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: double.infinity,

                              child: SearchDropdown(
                                items: expenseCategoryListData,
                                scrollController: cat_scrollController,
                                onChanged: (value) {
                                  catgeoryObject = value;
                                  print("Selected: ${value}");
                                },
                              ),
                            ),

                            InputComponent(
                              hintitle: "Number Reference",
                              islabel: true,
                              label: "Reference",
                              required: true,
                              spcae: 12,
                              controller: refController,
                            ),

                            SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              height: 50,

                              decoration: BoxDecoration(
                                color: const Color.fromARGB(
                                  255,
                                  247,
                                  247,
                                  247,
                                ).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.blueGrey.withOpacity(0.5),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: double.infinity,
                                    width: 50,
                                    color: Colors.black.withOpacity(0.1),
                                    child: Center(
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.black.withOpacity(0.4),
                                      ),
                                    ),
                                  ),

                                  // productsList
                                  Expanded(
                                    child: SearchDropdown(
                                      isBorder: false,
                                      hint: "Select Expense Prodcut",
                                      items: productsList,
                                      scrollController: pro_scrollController,
                                      onChanged: (e) {
                                        setState(() {
                                          selectedProductId.add(e);
                                        });
                                        // calculateTotalAmount();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //  seleted product card
                            selectedProductId != null
                                ? Column(
                                    spacing: 8,
                                    children: selectedProductId
                                        .map<Widget>(
                                          (product) => SelectedProductCard(
                                            deleteProductFromSelect:
                                                deleteProductFromSelect,
                                            product: product,
                                            latestData: (e) {
                                              cheakAndAdd(e);
                                            },
                                            latestsum: (e) {
                                              addOrUpdateAndCalculateTotal(e);
                                            },
                                          ),
                                        )
                                        .toList(),
                                  )
                                : SizedBox(),
                            RichTextEditor(
                              label: "Note",
                              noteQuillController: noteController,
                            ),
                            FileUpload(label: "Attachments"),
                            InputComponent(
                              hintitle: '$sum ',
                              islabel: true,
                              label: "Total Amount",
                              read: true,
                              spcae: 12,
                              controller: totalPayController,
                            ),

                            InputComponent(
                              hintitle: "0",
                              islabel: true,
                              label: "Pay Amount",
                              spcae: 12,
                              controller: payAmountController,
                            ),
                            Text(
                              'Payment Account',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: AppColors.colorBlack,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 50,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.blueGrey.withOpacity(0.5),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: double.infinity,
                                    width: 40,

                                    child: Center(
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.black.withOpacity(0.4),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: MySearchDropdown(
                                      items: accountList,
                                      isBorder: false,
                                      dropDownSearchController:
                                          _paytypeSearchController,
                                      hint: 'MFS- Ayesha Telecom',
                                      getterName: 'type',
                                      addButtonTitle: 'Add New Account',
                                      onChanged: (e) {
                                        setState(() {
                                          paymentData = e;
                                        });
                                        // print('selected $e');
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  spacing: 15,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 20),
                    Expanded(
                      child: ButtonEv(
                        title: 'Cancle',
                        textColor: AppColors.colorRed,
                        isBorder: true,
                        borderColor: AppColors.colorRed,
                      ),
                    ),
                    Expanded(
                      child: ButtonEv(
                        title: 'Add Expense',
                        colorData: AppColors.Colorprimary,
                        buttonFunction: addExpense,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:bazrin/feature/data/API/Helper/Accounts/getaccountList.dart';
import 'package:bazrin/feature/data/API/Helper/Product/getProductList.dart';
import 'package:bazrin/feature/data/API/Helper/Supplier/getSuppliers.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/classes/prettyPrint.dart';
import 'package:bazrin/feature/presentation/common/widgets/buttonEv.dart';
import 'package:bazrin/feature/presentation/common/widgets/search_dropdown.dart';
import 'package:bazrin/feature/presentation/common/widgets/simple_input.dart';
import 'package:bazrin/feature/presentation/screens/Purchase/Purchase/Add/widget/purchase_add_model.dart';
import 'package:bazrin/feature/presentation/screens/Purchase/widgets/selected_product_card.dart';
import 'package:bazrin/feature/presentation/screens/expense/Expense/Add/widgets/selected_product_card.dart';
import 'package:flutter/material.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

class AddPurchase extends StatefulWidget {
  const AddPurchase({super.key});

  @override
  State<AddPurchase> createState() => _AddPurchaseState();
}

class _AddPurchaseState extends State<AddPurchase> {
  final _controller = QuillController.basic();
  TextEditingController nameController = TextEditingController();
  TextEditingController invoiceConreoller = TextEditingController();
  TextEditingController _productSearchController = TextEditingController();
  TextEditingController totalPayController = TextEditingController();
  TextEditingController payAmountController = TextEditingController();
  final TextEditingController _paytypeSearchController =
      TextEditingController();
  DateTime selectedDate = DateTime.now();
  dynamic productList = [];
  dynamic paymentData = {};
  dynamic suppliers;
  String selectedSupplier = '';
  dynamic selectedProductId = [];
  List<Map<String, dynamic>> addproductData = [];
  double sum = 0;
  List<Map<String, dynamic>> accountList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductList();
    getacconts();
    getSupplie();
  }

  void submid() {
    String onlyDate = selectedDate!.toIso8601String().split('T').first;
    final delta = _controller.document.toDelta();
    final converter = QuillDeltaToHtmlConverter(delta.toJson());
    final html = converter.convert();

    dynamic addPurchaseData = {
      'supplierId': selectedSupplier,
      'invoiceNumber': invoiceConreoller.text,
      'note': html,
      'purchaseDate': onlyDate,
      'items': addproductData,
      'payments': [
        {'accountId': paymentData['id'], 'amount': payAmountController.text},
      ],
    };

    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.transparent,
        child: PurchaseAddModel(),
      ),
    );
  }

  void getProductList() async {
    final response = await Getproductlist.getProductList();
    final List<Map<String, dynamic>> parsedList = (response as List)
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
    setState(() {
      productList = parsedList;
    });
  }

  void getSupplie() async {
    final res = await Getsuppliers.getSuppliersList();
    final List<Map<String, dynamic>> supplierList = (res as List)
        .map((e) => Map<String, dynamic>.from(e))
        .toList();

    setState(() {
      suppliers = supplierList;
    });
  }

  void cheakAndAdd(Map<String, dynamic> pro) {
    final index = addproductData.indexWhere((item) => item['id'] == pro['id']);

    if (index != -1) {
      addproductData[index] = pro;
    } else {
      addproductData.add(pro);
    }

    // print('Updated List: $addexpenseData');
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

  Future<void> getacconts() async {
    try {
      final response = await Getaccountlist.getAccountsList();

      // Safely cast and convert
      final List<Map<String, dynamic>> parsedList = (response as List)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();

      setState(() {
        accountList = parsedList;
      });
    } catch (e) {}
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
                      page: PurchasesList(),
                      direction: SlideDirection.left,
                    ),
                  );
                },
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ],
          ),
          title: Text(
            'Add Purchase',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: AppColors.Colorprimary,
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
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Column(
                    children: [
                      Headercomponent(title: 'Add Purchase'),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Supplier Name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: AppColors.colorBlack,
                                  ),
                                ),
                                Visibility(
                                  visible: true,
                                  child: Text(
                                    '*',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            MySearchDropdown(
                              items: suppliers,
                              onChanged: (sup) {
                                setState(() {
                                  selectedSupplier = sup['id'];
                                });
                              },
                              dropDownSearchController: nameController,
                              hint: "Select Supplier",
                            ),

                            InputComponent(
                              hintitle: '112566436944',
                              label: "Invoice No",
                              isIcon: true,
                              islabel: true,
                              spcae: 10,
                              required: true,
                              controller: invoiceConreoller,
                            ),
                            DatePicker(label: 'Purchase Date', required: true),

                            SizedBox(height: 10),

                            Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Note',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: AppColors.colorBlack,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    // color: Colors.black.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.black.withOpacity(0.1),
                                      width: 2,
                                    ),
                                  ),
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      QuillSimpleToolbar(
                                        controller: _controller,
                                        config: QuillSimpleToolbarConfig(
                                          showBoldButton: true,
                                          showItalicButton: true,
                                          showUnderLineButton: true,
                                          showAlignmentButtons: true,
                                          showStrikeThrough: false,
                                          showFontFamily: false,
                                          showFontSize: false,
                                          showColorButton: false,
                                          showBackgroundColorButton: false,
                                          showListNumbers: false,
                                          showListBullets: false,
                                          showListCheck: false,
                                          showCodeBlock: false,
                                          showQuote: false,
                                          showLink: false,
                                          showClearFormat: false,
                                          showUndo: false,
                                          showRedo: false,
                                          showSearchButton: false,
                                          showHeaderStyle: false,
                                          showDividers: false,
                                          showInlineCode: false,
                                          multiRowsDisplay: false,
                                          color: Colors.black.withOpacity(0.1),
                                        ),
                                      ),
                                      Container(
                                        height: 200,
                                        padding: EdgeInsets.all(8),
                                        child: QuillEditor.basic(
                                          controller: _controller,
                                          config: QuillEditorConfig(
                                            placeholder:
                                                "Enter Product Description",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Column(
                              spacing: 15,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Attachments',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: AppColors.colorBlack,
                                  ),
                                ),
                                DottedBorder(
                                  options: RoundedRectDottedBorderOptions(
                                    dashPattern: [8, 8],
                                    strokeWidth: 1,
                                    radius: Radius.circular(8),
                                    color: AppColors.colorGray,
                                  ),

                                  child: Container(
                                    width: double.infinity,
                                    height: 130,
                                    color: Color(0xFF212B36).withOpacity(0.1),
                                    child: Center(
                                      child: Row(
                                        spacing: 5,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.upload,
                                            color: Color(
                                              0xFF212B36,
                                            ).withOpacity(0.3),
                                          ),
                                          Text(
                                            'upload a file',
                                            style: TextStyle(
                                              color: Colors.green,
                                            ),
                                          ),
                                          Text(
                                            'or a drug and drop',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
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
                                      child: Image.asset(
                                        'assets/images/sku.png',
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: MySearchDropdown(
                                      isClear: false,
                                      items: productList,
                                      isBorder: false,
                                      addButtonTitle: "Add New Product",
                                      dropDownSearchController:
                                          _productSearchController,
                                      hint:
                                          'Search By Product Name / SKU / Barcode',
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

                            SizedBox(height: 20),

                            selectedProductId != null
                                ? Column(
                                    spacing: 8,
                                    children: selectedProductId
                                        .map<Widget>(
                                          (product) =>
                                              SelectedPurchaseProductCard(
                                                deleteProductFromSelect:
                                                    deleteProductFromSelect,
                                                product: product,
                                                latestData: (e) {
                                                  cheakAndAdd(e);
                                                },
                                                latestsum: (e) {
                                                  addOrUpdateAndCalculateTotal(
                                                    e,
                                                  );
                                                },
                                              ),
                                        )
                                        .toList(),
                                  )
                                : SizedBox(),

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

                            //
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
                    ButtonEv(
                      title: 'Cancle',
                      textColor: AppColors.colorRed,
                      isBorder: true,
                      borderColor: AppColors.colorRed,
                    ),
                    ButtonEv(
                      title: 'Buy',
                      colorData: AppColors.Colorprimary,
                      buttonFunction: submid,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:bazrin/feature/data/API/Helper/Accounts/getaccountList.dart';
import 'package:bazrin/feature/data/API/Helper/Pos/getSaleReturnTypes.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/classes/prettyPrint.dart';
import 'package:bazrin/feature/presentation/common/widgets/search_dropdown.dart';
import 'package:flutter/widgets.dart';

class SaleReturn extends StatefulWidget {
  const SaleReturn({super.key});

  @override
  State<SaleReturn> createState() => _SaleReturnState();
}

class _SaleReturnState extends State<SaleReturn> {
  dynamic returnTypes;
  List<Map<String, dynamic>> accountList = [];
  dynamic paymentData = {};
  TextEditingController dropDownController = TextEditingController();
  TextEditingController _paytypeSearchController = TextEditingController();
  final _controller = QuillController.basic();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getreturnTypes();
    getacconts();
  }

  void getreturnTypes() async {
    final response = await Getsalereturntypes.getSaleReturnTypes();

    setState(() {
      returnTypes = List<Map<String, dynamic>>.from(response);
    });

    PrettyPrint.print(response);
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

      // print('accounts data : $accountList');
    } catch (e) {
      // print('Error loading categories: $e');
    }
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
                      page: ManageSales(),
                      direction: SlideDirection.left,
                    ),
                  );
                },
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ],
          ),
          title: Text(
            'Sale Return',
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
                            Headercomponent(title: 'Sale Return'),
                            Container(
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 15,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 12,
                                      children: [
                                        InputComponent(
                                          hintitle: '234532',
                                          label: "Invoice No",
                                          required: true,
                                          islabel: true,
                                        ),
                                        InputComponent(
                                          hintitle: 'Himal Hasan',
                                          label: "Customer Name",
                                          required: true,
                                          islabel: true,
                                        ),
                                        DatePicker(
                                          label: "Sale Return Date",
                                          required: true,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Return Type',
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
                                        SizedBox(
                                          width: double.infinity,
                                          height: 48,
                                          child: MySearchDropdown(
                                            items: returnTypes,
                                            onChanged: (e) {
                                              print(e);
                                            },
                                            dropDownSearchController:
                                                dropDownController,
                                          ),
                                        ),
                                        Text(
                                          'Note',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        // ======= Quile Text start here======
                                        Container(
                                          decoration: BoxDecoration(
                                            // color: Colors.black.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            border: Border.all(
                                              color: Colors.black.withOpacity(
                                                0.1,
                                              ),
                                              width: 2,
                                            ),
                                          ),

                                          child: Column(
                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              QuillSimpleToolbar(
                                                controller: _controller,
                                                config:
                                                    QuillSimpleToolbarConfig(
                                                      showBoldButton: true,
                                                      showItalicButton: true,
                                                      showUnderLineButton: true,
                                                      showAlignmentButtons:
                                                          true,
                                                      showStrikeThrough: false,
                                                      showFontFamily: false,
                                                      showFontSize: false,
                                                      showColorButton: false,
                                                      showBackgroundColorButton:
                                                          false,
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
                                                      color: Colors.black
                                                          .withOpacity(0.1),
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
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          spacing: 12,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputComponent(
                              hintitle: '0',
                              label: "Account Number",
                              islabel: true,
                              spcae: 12,
                              read: true,
                            ),
                            InputComponent(
                              hintitle: '0',
                              label: "Pay Amount",
                              islabel: true,
                              spcae: 12,
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
                            InputComponent(
                              hintitle: '0',
                              label: "Due Amount",
                              islabel: true,
                              spcae: 12,
                              read: true,
                            ),
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
                                    title: 'Add',
                                    colorData: AppColors.Colorprimary,
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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

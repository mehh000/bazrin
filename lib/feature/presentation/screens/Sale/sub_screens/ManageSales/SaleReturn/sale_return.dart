import 'package:bazrin/feature/data/API/Helper/Accounts/getaccountList.dart';
import 'package:bazrin/feature/data/API/Helper/Pos/Sale/addOrderSaleReturn.dart';
import 'package:bazrin/feature/data/API/Helper/Pos/Sale/getOrderByid.dart';
import 'package:bazrin/feature/data/API/Helper/Pos/Sale/getSaleReturnTypes.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/classes/prettyPrint.dart';
import 'package:bazrin/feature/presentation/common/widgets/search_dropdown.dart';
import 'package:bazrin/feature/presentation/screens/Sale/sub_screens/ManageSales/SaleReturn/Component/order_return_productCard.dart';
import 'package:flutter/widgets.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

class SaleReturn extends StatefulWidget {
  final String id;
  const SaleReturn({super.key, required this.id});

  @override
  State<SaleReturn> createState() => _SaleReturnState();
}

class _SaleReturnState extends State<SaleReturn> {
  dynamic returnTypes;
  List<Map<String, dynamic>> accountList = [];
  dynamic paymentData = {};
  TextEditingController dropDownController = TextEditingController();
  TextEditingController _paytypeSearchController = TextEditingController();
  TextEditingController invoiceController = TextEditingController();
  TextEditingController payingAmount = TextEditingController();
  TextEditingController customername = TextEditingController();
  TextEditingController returnQtyController = TextEditingController();
  TextEditingController invoiceAmountController = TextEditingController();
  TextEditingController dueamountController = TextEditingController();
  String sellerId = '';
  DateTime selectedDate = DateTime.now();
  String returnTypeId = '';
  final _controller = QuillController.basic();
  dynamic orderDetails;
  dynamic itemDetails = [];
  dynamic returnSubTotal = 0;

  // Loading Bool
  bool istypesLoaded = false;
  bool isaccountsLoaded = false;
  bool isorderDetailsLoaded = false;

  @override
  void initState() {
    super.initState();

    getreturnTypes();
    getacconts();
    getOrderDetails();

    // ---- FIXED LISTENER FOR returnQtyController ----
    returnQtyController.addListener(() {
      if (itemDetails.isEmpty) return;

      final qty = double.tryParse(returnQtyController.text) ?? 0;
      final unitPrice = (itemDetails[0]['unitPrice'] ?? 0).toDouble();

      setState(() {
        returnSubTotal = unitPrice * qty; // now rebuilds UI
        invoiceAmountController.text = returnSubTotal.toString();
        dueamountController.text = returnSubTotal.toString();
      });
    });

    // ---- FIXED LISTENER FOR payingAmount ----
    payingAmount.addListener(() {
      final pay = double.tryParse(payingAmount.text) ?? 0;
      final due = returnSubTotal - pay;

      dueamountController.text = due.toString();
    });
  }

  void getreturnTypes() async {
    setState(() => istypesLoaded = true);
    final response = await Getsalereturntypes.getSaleReturnTypes();

    setState(() {
      returnTypes = List<Map<String, dynamic>>.from(response);
      istypesLoaded = false;
    });

  }

  Future<void> getacconts() async {
    setState(() => isaccountsLoaded = true);
    try {
      final response = await Getaccountlist.getAccountsList();

      // Safely cast and convert
      final List<Map<String, dynamic>> parsedList = (response as List)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();

      setState(() {
        accountList = parsedList;
        isaccountsLoaded = false;
      });
    } catch (e) {
      setState(() => isaccountsLoaded = true);
      // print('Error loading categories: $e');
    }
  }

  void getOrderDetails() async {
    setState(() => isorderDetailsLoaded = true);
    final response = await Getordersbyid.getOrderById(widget.id);
    setState(() {
      orderDetails = response;
      customername.text = response['customerInfo']['name'];
      selectedDate = DateTime.parse(response['saleDate']);
      itemDetails = response['lineItems'];
      isorderDetailsLoaded = false;
      sellerId = response['id'];
      isorderDetailsLoaded = false;
    });

  }

  void submit() async {
    String onlyDate = selectedDate!.toIso8601String().split('T').first;
    final delta = _controller.document.toDelta();
    final converter = QuillDeltaToHtmlConverter(delta.toJson());
    final html = converter.convert();
    dynamic submitData = {
      "invoiceNumber": invoiceController.text,
      "saleId": sellerId,
      "returnTypeId": returnTypeId,
      "returnDate": onlyDate,
      "note": html,
      "items": [
        {
          "productId": itemDetails[0]['productId'],
          "attributes": itemDetails[0]['attributes'],
          "returnQuantity": returnQtyController.text,
          "returnPrice": itemDetails[0]['returnablePrice'],
        },
      ],
      "payments": [
        {"accountId": paymentData['id'], "amount": payingAmount.text},
      ],
    };

    if (invoiceController.text.isEmpty) {
      TostMessage.showToast(
        context,
        message: "Invoice Number is Needed",
        isSuccess: false,
      );
      return;
    }
    if (returnTypeId.isEmpty) {
      TostMessage.showToast(
        context,
        message: "Return Type is Needed",
        isSuccess: false,
      );
      return;
    }
    if (returnQtyController.text.isEmpty) {
      TostMessage.showToast(
        context,
        message: "Return Qty is Needed",
        isSuccess: false,
      );
      return;
    }
    if (paymentData.isEmpty) {
      TostMessage.showToast(
        context,
        message: "Payment Account is Needed",
        isSuccess: false,
      );
      return;
    }

    final qty = double.tryParse(returnQtyController.text) ?? 0;
    final saleQty = (itemDetails[0]['quantity'] ?? 0).toDouble();

    if (qty > saleQty) {
      TostMessage.showToast(
        context,
        message: "Return qty cannot be greater than sale qty",
        isSuccess: false,
      );
      return;
    }

    final response = await AddorderSaleReturn.addOrderSaleReturn(submitData);
    if (response == "success") {
      Navigator.of(context).push(
        SlidePageRoute(page: ManageSales(), direction: SlideDirection.left),
      );
      TostMessage.showToast(
        context,
        message: "Order Return Added Successfully",
        isSuccess: true,
      );
    } else {
      TostMessage.showToast(
        context,
        message: response['error']['validationErrors']['saleId'],
        isSuccess: false,
      );
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
                  child:
                      (isaccountsLoaded &&
                          isorderDetailsLoaded &&
                          istypesLoaded)
                      ? Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Column(
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
                                                controller: invoiceController,
                                              ),
                                              InputComponent(
                                                hintitle: 'Himal Hasan',
                                                label: "Customer Name",
                                                required: true,
                                                islabel: true,
                                                controller: customername,
                                              ),
                                              DatePicker(
                                                label: "Sale Return Date",
                                                required: true,
                                                initialDate: selectedDate,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Return Type',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                      color:
                                                          AppColors.colorBlack,
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
                                                  hint: "Select Return Type",
                                                  items: returnTypes,
                                                  onChanged: (e) {
                                                    setState(() {
                                                      returnTypeId = e['id'];
                                                    });
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
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
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
                                                        showUnderLineButton:
                                                            true,
                                                        showAlignmentButtons:
                                                            true,
                                                        showStrikeThrough:
                                                            false,
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
                                                      padding: EdgeInsets.all(
                                                        8,
                                                      ),
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
                            itemDetails != null
                                ? OrderReturnProductcard(
                                    qtyController: returnQtyController,
                                    itemDetails: itemDetails[0],
                                    returnSubTotal: returnSubTotal,
                                  )
                                : SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: CircularProgressIndicator(),
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
                                    label: "Invoice Amount",
                                    islabel: true,
                                    spcae: 12,
                                    read: true,
                                    controller: invoiceAmountController,
                                  ),
                                  InputComponent(
                                    hintitle: '0',
                                    label: "Pay Amount",
                                    islabel: true,
                                    spcae: 12,
                                    controller: payingAmount,
                                  ),

                                  Row(
                                    children: [
                                      Text(
                                        'Payment Account',
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
                                              color: Colors.black.withOpacity(
                                                0.4,
                                              ),
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
                                    controller: dueamountController,
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
                                          buttonFunction: submit,
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

import 'dart:math';

import 'package:bazrin/feature/data/API/Helper/Supplier/AddsuppliersPayments.dart';
import 'package:bazrin/feature/data/API/Helper/Supplier/getSupplierByid.dart';
import 'package:bazrin/feature/data/API/Helper/Supplier/getSupplierPaymentbyId.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/Components/CustomIndicator.dart';
import 'package:bazrin/feature/presentation/common/Components/tost_message.dart';
import 'package:flutter/material.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

class PurchaseDuePay extends StatefulWidget {
  final dynamic data;
  const PurchaseDuePay({super.key, required this.data});

  @override
  State<PurchaseDuePay> createState() => _PurchaseDuePayState();
}

class _PurchaseDuePayState extends State<PurchaseDuePay> {
  dynamic supplierData = [];
  TextEditingController totalreceiveableController = TextEditingController();
  TextEditingController payingamountController = TextEditingController();
  final _controller = QuillController.basic();
  DateTime selectedDate = DateTime.now();
  bool isloading = true;
  String paymentId = '';
  int? mockInvoice;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    totalreceiveableController.text =
        widget.data['purchaseTotalRemaining']?.toString() ?? ''.toString();
    getSupPayDetails();
  }

  void submitData() async {
    String onlyDate = selectedDate!.toIso8601String().split('T').first;
    final delta = _controller.document.toDelta();
    final converter = QuillDeltaToHtmlConverter(delta.toJson());
    final html = converter.convert();

    if (paymentId.isEmpty) {
      TostMessage.showToast(
        context,
        message: "Select a payment account",
        isSuccess: false,
      );
      return;
    }

    if (payingamountController.text.isEmpty) {
      TostMessage.showToast(
        context,
        message: "Paying amount must be greater than 0",
        isSuccess: false,
      );
      return;
    }
    var invoice = Random().nextInt(999);
    dynamic fromData = {
      "invoiceNumber": invoice,
      "date": onlyDate,
      "note": html,
      "accountId": paymentId,
      "supplierId": supplierData['id'],
      "type": "PURCHASE_DUE_PAYMENT",
      "amount": payingamountController.text,
    };

    final response = await Addsupplierspayments.AddSupplierPayments(fromData);
    if (response == 'success') {
      Navigator.of(context).push(
        SlidePageRoute(page: SupplierList(), direction: SlideDirection.right),
      );
      TostMessage.showToast(
        context,
        message: "Payment added successfully",
        isSuccess: true,
      );
    }

    print('submited data : $fromData');
    print('res : $response');
  }

  Future<void> getSupPayDetails() async {
    final response = await Getsupplierbyid.getSupplierById(widget.data['id']);
    setState(() {
      supplierData = response ?? [];
      isloading = false;
    });

    print('supplier pay details $supplierData');
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
                      page: SupplierList(),
                      direction: SlideDirection.left,
                    ),
                  );
                },
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ],
          ),
          title: Text(
            'Purchase Due Pay',
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
                      Headercomponent(title: "Purchase Due Pay"),
                      isloading
                          ? Customindicator()
                          : Container(
                              width: double.infinity,
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
                                spacing: 10,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Name: ${supplierData['name'] ?? ''}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'Mobile number: ${supplierData['phone']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'Email: ${supplierData['email']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'Address: ${supplierData['address'] ?? ''}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
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
                                            color: Colors.black.withOpacity(
                                              0.1,
                                            ),
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
                                  ), // ======= Quile Text End here======
                                  Flaginputcomponent(
                                    hintitle: "0",
                                    islabel: true,
                                    label: "Total Receivable",
                                    spcae: 12,
                                    imagePath: "assets/images/icons/give.svg",
                                    controller: totalreceiveableController,
                                    read: true,
                                  ),
                                  Flaginputcomponent(
                                    hintitle: "0",
                                    islabel: true,
                                    label: "Paying Amount",
                                    spcae: 12,
                                    imagePath: "assets/images/icons/take.svg",
                                    controller: payingamountController,
                                  ),
                                  Flaginputcomponent(
                                    hintitle: "10/10/2025",
                                    islabel: true,
                                    label: "Paying Date",
                                    spcae: 12,
                                    imagePath: "assets/images/icons/date.svg",
                                    type: 'date',
                                    onDateSelected: (date) {
                                      setState(() {
                                        selectedDate = date;
                                      });
                                    },
                                  ),
                                  Flaginputcomponent(
                                    hintitle: "Search here ",
                                    islabel: true,
                                    label: "Paying With",
                                    spcae: 12,
                                    imagePath:
                                        "assets/images/icons/takesmall.svg",
                                    type: 'dropdown',
                                    payid: (id) {
                                      setState(() {
                                        paymentId = id;
                                      });
                                    },
                                  ),
                                  SizedBox(height: 30),
                                  Row(
                                    spacing: 20,

                                    children: [
                                      Expanded(
                                        child: ButtonEv(
                                          title: "Cancle",
                                          textColor: AppColors.colorRed,
                                          isBorder: true,
                                          borderColor: AppColors.colorRed,
                                        ),
                                      ),
                                      Expanded(
                                        child: ButtonEv(
                                          title: "Update",
                                          textColor: AppColors.Colorwhite,
                                          colorData: AppColors.Colorprimary,
                                          buttonFunction: submitData,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

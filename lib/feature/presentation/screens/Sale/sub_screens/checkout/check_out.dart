import 'package:bazrin/feature/data/API/Helper/Accounts/getaccountList.dart';
import 'package:bazrin/feature/data/API/Helper/Pos/Sale/addPosSell.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/classes/prettyPrint.dart';
import 'package:bazrin/feature/presentation/common/widgets/search_dropdown.dart';
import 'package:bazrin/feature/presentation/common/widgets/simple_input.dart';
import 'package:bazrin/feature/presentation/screens/Sale/sub_screens/checkout/widgets/checkOutactionButton.dart';
import 'package:bazrin/feature/presentation/screens/Sale/sub_screens/payemnt/paayment.dart';
import 'package:flutter/material.dart';

class CheckOut extends StatefulWidget {
  final dynamic cheakoutData;
  const CheckOut({super.key, required this.cheakoutData});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  List<Map<String, dynamic>> accountList = [];
  bool isaccountsLoaded = false;
  dynamic paymentData = {};
  String selectedPaymentType = 'Regular';
  TextEditingController todaysDateController = TextEditingController();
  TextEditingController totalinstallmentMonthsController =
      TextEditingController();
  TextEditingController interestRateController = TextEditingController();
  TextEditingController payableAmountPMController = TextEditingController();
  TextEditingController _paytypeSearchController = TextEditingController();
  TextEditingController receiveAmountController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getacconts();

    final now = DateTime.now();
    todaysDateController.text = "${now.day}/${now.month}/${now.year}";
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

  void generateBill() async {
    final lineItems = widget.cheakoutData['items']
        .map(
          (e) => {
            "productId": e['id'],
            "quantity": e['posQty'],
            "variant": [],
            "discount": null,
            "model": null,
          },
        )
        .toList();

    final cheakOutDetails = {
      "customerId": widget.cheakoutData['customerId'], // must be ObjectId
      "quotationId": null, // FIXED
      "lineItems": lineItems,
      "payments": [
        {
          "accountId": paymentData['id'], // must be ObjectId
          "amount": int.tryParse(receiveAmountController.text) ?? 0,
        },
      ],
      "discount": {
        "type": widget.cheakoutData['discountType'] == "Amount"
            ? "FIXED"
            : "PERCENT",

        "value": widget.cheakoutData['discount'],
      },
      "deliveryCost":
          double.tryParse(widget.cheakoutData['deliveryCharge']) ?? 0,
      "vatPercent": widget.cheakoutData['vat'],
    };

    final response = await Addpossell.addPosSell(cheakOutDetails);
    if (response == "success") {
      Navigator.of(
        context,
      ).push(SlidePageRoute(page: Pos(), direction: SlideDirection.right));
      TostMessage.showToast(
        context,
        message: "Order has been successfully created.",
        isSuccess: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Checkoutactionbutton(generateBill: generateBill),
        appBar: AppBar(
          backgroundColor: AppColors.Colorprimary,
          leading: Row(
            children: [
              SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.keyboard_arrow_left_outlined,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          title: Text(
            'Checkout',
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
                    spacing: 5,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: Column(
                          children: [
                            Headercomponent(title: "Payment Method"),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 12,
                                children: [
                                  StatusDropdown(
                                    label: 'Payment Type',
                                    hint: 'Regular',
                                    data: ['Regular', 'Installment'],
                                    selectedStatus: (type) {
                                      setState(() {
                                        selectedPaymentType = type;
                                      });
                                    },
                                  ),
                                  Visibility(
                                    visible:
                                        selectedPaymentType == "Installment",
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 12,
                                      children: [
                                        Text(
                                          'Required Document',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),

                                        Container(
                                          width: double.infinity,
                                          height: 50,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.attach_file_outlined,
                                                color: Colors.grey,
                                              ),
                                              Text(
                                                'Customer National ID',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Container(
                                          width: double.infinity,
                                          height: 50,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.attach_file_outlined,
                                                color: Colors.grey,
                                              ),
                                              Text(
                                                'Customer Birth ID',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        InputComponent(
                                          islabel: true,
                                          label: "Installment Details",
                                          hintitle: "Total Installment Months*",
                                          spcae: 8,
                                          controller:
                                              totalinstallmentMonthsController,
                                        ),
                                        InputComponent(
                                          hintitle: "Interest Rate %*",
                                          label: "Interest Rate %*",
                                          spcae: 8,
                                          islabel: true,
                                          controller: interestRateController,
                                        ),

                                        InputComponent(
                                          read: true,
                                          hintitle: "Date",
                                          controller: todaysDateController,
                                        ),
                                        InputComponent(
                                          read: true,
                                          hintitle: "Payable Amount Per Month",
                                          controller: payableAmountPMController,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    'Payment Method',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  MySearchDropdown(
                                    items: accountList,

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
                                  Text(
                                    'Receive Amount',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      spacing: 5,
                                      children: [
                                        Expanded(
                                          child: SimpleInput(
                                            isBorder: false,
                                            hintText: '0.00',
                                            controller: receiveAmountController,
                                          ),
                                        ),
                                        Container(
                                          color: Colors.grey[400],
                                          height: 45,
                                          width: 90,
                                          child: Center(
                                            child: Text(
                                              'Change',
                                              style: TextStyle(
                                                color: AppColors.colorTextGray,
                                              ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

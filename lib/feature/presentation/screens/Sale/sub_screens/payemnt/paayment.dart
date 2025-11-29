import 'dart:ffi';

import 'package:bazrin/feature/data/API/Helper/Customer/getCustomers.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/classes/prettyPrint.dart';
import 'package:bazrin/feature/presentation/common/widgets/iconEvButton.dart';
import 'package:bazrin/feature/presentation/common/widgets/search_dropdown.dart';
import 'package:bazrin/feature/presentation/screens/Sale/sub_screens/checkout/check_out.dart';
import 'package:bazrin/feature/presentation/screens/Sale/sub_screens/payemnt/widgets/item_card.dart';
import 'package:bazrin/feature/presentation/screens/Sale/sub_screens/payemnt/widgets/last_action_buttons.dart';
import 'package:bazrin/feature/presentation/screens/customers/Customer/Add/add_customer.dart';
import 'package:flutter/material.dart';

class Paayment extends StatefulWidget {
  final dynamic selectedItems;
  const Paayment({super.key, required this.selectedItems});

  @override
  State<Paayment> createState() => _PaaymentState();
}

class _PaaymentState extends State<Paayment> {
  dynamic selectedItems = [];
  dynamic grandTotal = 00;
  dynamic customerList = [];
  dynamic selectedCustomer = {};
  String discountType = '';
  double discount = 0;
  bool iscustomerLoaded = false;
  double originalTotal = 0;

  // Inout Controllers
  TextEditingController dropDownController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController deliveryChangeController = TextEditingController();
  TextEditingController vatController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCustomerList();
    setState(() {
      selectedItems = widget.selectedItems;
    });
    getSubTotal();
    discountController.addListener(() {
      if (discountType.isEmpty) {
        TostMessage.showToast(
          context,
          message: "Select a discount type",
          isSuccess: false,
        );
        return;
      }

      final discount = double.tryParse(discountController.text) ?? 0;

      setState(() {
        if (discountType == "Amount") {
          grandTotal = originalTotal - discount;
        } else if (discountType == "Percent") {
          grandTotal = originalTotal - (originalTotal * (discount / 100));
        }
      });
    });
    deliveryChangeController.addListener(() {
      final deliveryC = double.tryParse(deliveryChangeController.text) ?? 0;
      final discount = double.tryParse(discountController.text) ?? 0;
      if (discountType.isEmpty) {
        TostMessage.showToast(
          context,
          message: "Select a discount type",
          isSuccess: false,
        );
        return;
      }

      setState(() {
        if (discountType == "Amount") {
          grandTotal = originalTotal - discount;
        } else if (discountType == "Percent") {
          grandTotal = originalTotal - (originalTotal * (discount / 100));
        }
        grandTotal = grandTotal + deliveryC;
      });

      // setState(() {
      //   grandTotal = originalTotal + deliveryC;
      // });
    });

    vatController.addListener(() {
      final deliveryC = double.tryParse(deliveryChangeController.text) ?? 0;
      final discount = double.tryParse(discountController.text) ?? 0;
      final vat = double.tryParse(vatController.text) ?? 0;

      if (discountType.isEmpty) {
        TostMessage.showToast(
          context,
          message: "Select a discount type",
          isSuccess: false,
        );
        return;
      }

      setState(() {
        if (discountType == "Amount") {
          grandTotal = originalTotal - discount;
        } else if (discountType == "Percent") {
          grandTotal = originalTotal - (originalTotal * (discount / 100));
        }
        grandTotal = grandTotal + deliveryC;
        grandTotal = grandTotal + (grandTotal * (vat / 100));
      });
    });
  }

  void incrementAddedItemToCart(item) {
    final id = item['id'];

    final index = selectedItems.indexWhere((e) => e['id'] == id);

    if (index != -1) {
      selectedItems[index] = item;
    }
    setState(() {});
    getSubTotal();
  }

  void cleanAll() async {
    setState(() {
      selectedItems = [];
    });
    getSubTotal();
  }

  void getSubTotal() {
    double newTotal = 0;
    for (var item in selectedItems) {
      final qty = (item['posQty'] is List)
          ? item['posQty'][0]
          : item['posQty'] ?? 0;

      final price = (item['salePriceRange'] is List)
          ? item['salePriceRange'][0]
          : item['salePriceRange'] ?? 0;

      final subtotal = qty * price;

      // item['subTotal'] = subtotal;
      newTotal += subtotal;
    }

    setState(() {
      grandTotal = newTotal;
      originalTotal = newTotal;
    });

    print("Grand Total: $grandTotal");
  }

  void getCustomerList() async {
    setState(() => iscustomerLoaded = true);
    final response = await Getcustomers.getCustomersList();

    final List<Map<String, dynamic>> parsedList =
        List<Map<String, dynamic>>.from(response);

    setState(() {
      customerList = parsedList;
      iscustomerLoaded = false;
    });
  }

  void addToCheakOut() {
    dynamic cheakoutData = {
      "customerId": selectedCustomer['id'],
      "items": selectedItems,
      "discountType": discountType,
      "discount": discountController.text,
      "deliveryCharge": deliveryChangeController.text,
      "vat": vatController.text,
    };
    PrettyPrint.print(cheakoutData);

    Navigator.of(
      context,
    ).push(SlidePageRoute(page: CheckOut(cheakoutData : cheakoutData), direction: SlideDirection.right));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.containerColor,
        bottomNavigationBar: LastActionButtons(
          selectedItems: selectedItems,
          cleanAll: cleanAll,
          addToCheakOut: addToCheakOut,
        ),
        body: Column(
          children: [
            Container(
              height: 80,
              color: AppColors.Colorprimary,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        SlidePageRoute(
                          page: const Pos(),
                          direction: SlideDirection.right,
                        ),
                      );
                    },
                    child: Icon(Icons.keyboard_arrow_left, color: Colors.white),
                  ),

                  // Search bar
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: MySearchDropdown(
                        hint: "Select Customer",
                        items: iscustomerLoaded ? [] : customerList,
                        onChanged: (e) {
                          setState(() {
                            selectedCustomer = e;
                          });
                        },
                        dropDownSearchController: dropDownController,
                      ),
                    ),
                  ),
                  Iconevbutton(
                    title: '',
                    colorData: Colors.white,
                    iconName: Icons.person_add_alt_1,
                    iconColor: AppColors.Colorprimary,
                    iconSize: 22,
                    height: 40,
                    buttonFunction: () {
                      Navigator.of(context).push(
                        SlidePageRoute(
                          page: const AddCustomer(),
                          direction: SlideDirection.right,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // ✅ Scrollable content below header
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  width: double.infinity,
                  child: Column(
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
                            Headercomponent(title: "Item List"),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                              child: Column(
                                children: selectedItems
                                    .map<Widget>(
                                      (item) => PosSellItem(
                                        item: item,
                                        incrementAddedItemToCart: (e) {
                                          incrementAddedItemToCart(e);
                                        },
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),

                      //
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          spacing: 12,
                          children: [
                            StatusDropdown(
                              label: "Discount Type",
                              hint: "Discount Type",
                              data: ['Amount', "Percent"],
                              selectedStatus: (e) {
                                setState(() {
                                  discountType = e;
                                });
                              },
                            ),
                            InputComponent(
                              spcae: 5,
                              hintitle: 'Enter Discount',
                              label: "Discount",
                              islabel: true,
                              controller: discountController,
                            ),
                            InputComponent(
                              spcae: 5,
                              hintitle: 'Enter Delivery Charge',
                              label: "Delivery Charge",
                              islabel: true,
                              controller: deliveryChangeController,
                            ),
                            InputComponent(
                              spcae: 5,
                              hintitle: 'Percent',
                              label: "Vat%",
                              islabel: true,
                              controller: vatController,
                            ),

                            Divider(height: 1, thickness: 2),
                            Rowlinedatashow(
                              fontSize: 14,
                              left: 'Customer Name',
                              right: "${selectedCustomer['name'] ?? ''}",
                            ),
                            Divider(height: 1, thickness: 2),
                            Rowlinedatashow(
                              fontSize: 14,
                              left: 'Total:',
                              right: "$grandTotal",
                            ),
                            Divider(height: 1, thickness: 2),
                            Rowlinedatashow(
                              fontSize: 18,
                              left: 'Grand Total:',
                              right: "${grandTotal}",
                              fontw: FontWeight.bold,
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

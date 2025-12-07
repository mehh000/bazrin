import 'package:bazrin/feature/data/API/Helper/Purchase/getPurchaseByid.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/classes/prettyPrint.dart';
import 'package:bazrin/feature/presentation/screens/products/Presentation/Product/Main/products_screen.dart';
import 'package:bazrin/feature/presentation/screens/products/Components/invoice_container.dart';
import 'package:bazrin/feature/presentation/screens/Purchase/Components/purchase_details_container.dart';
import 'package:flutter/material.dart';

class PurchaseView extends StatefulWidget {
  final String id;
  const PurchaseView({super.key, required this.id});

  @override
  State<PurchaseView> createState() => _PurchaseViewState();
}

class _PurchaseViewState extends State<PurchaseView> {
  int selectedIndex = 1;
  dynamic purchaseDetails;
  bool isLoaded = true;
  dynamic profileData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      profileData = LocalStorage.box.get('myprofile');
    });
    getPurchaseDetails();
  }

  void getPurchaseDetails() async {
    final response = await GetPurchasebyid.getPurchaseById(widget.id);
    setState(() {
      purchaseDetails = response;
      isLoaded = false;
    });
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
            'Purchase',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: AppColors.Colorprimary,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          // padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    // Bottom border line
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.colorGray.withOpacity(0.2),
                            width: 2,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 1,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = 1;
                              });
                            },
                            child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: selectedIndex == 1
                                        ? AppColors.Colorprimary
                                        : AppColors.colorGray.withOpacity(0),
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Purchase details',
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 2,
                                    fontWeight: FontWeight.w500,
                                    color: selectedIndex == 1
                                        ? AppColors.colorBlack
                                        : AppColors.colorGray.withOpacity(0.8),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = 2;
                              });
                            },
                            child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: selectedIndex == 2
                                        ? AppColors.Colorprimary
                                        : AppColors.colorGray.withOpacity(0),
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Invoice',
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 2,
                                    fontWeight: FontWeight.w500,
                                    color: selectedIndex == 2
                                        ? AppColors.colorBlack
                                        : AppColors.colorGray.withOpacity(0.8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                isLoaded
                    ? SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(),
                      )
                    : selectedIndex == 1
                    ? PurchaseDetailsContainer(
                        purchaseDetails: purchaseDetails,
                        profileDetails: profileData,
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        child: InvoiceContainer(purchaseDetails: purchaseDetails, profileData : profileData),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

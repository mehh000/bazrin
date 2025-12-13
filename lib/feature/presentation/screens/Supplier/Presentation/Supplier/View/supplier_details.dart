// ignore_for_file: dead_code

import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class SupplierDetails extends StatelessWidget {
  final dynamic supplierData;
  const SupplierDetails({super.key, required this.supplierData});

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
            'Suppliers Details',
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
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppColors.Colorprimary,

                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Suppliers Full Details',
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 2,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.colorBlack,
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

                // ======== details start here ===========
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Column(
                    spacing: 5,
                    children: [
                      Rowlinedatashow(
                        left: "Name",
                        right: supplierData['name'] ?? '',
                      ),
                      Rowlinedatashow(
                        left: "Phone",
                        right: supplierData['phone'] ?? '',
                      ),
                      Rowlinedatashow(
                        left: "Email",
                        right: supplierData['email'] ?? '',
                      ),

                      SizedBox(height: 15),

                      DottedBorderComponent(
                        child: SizedBox(width: double.infinity),
                        topBorder: true,
                        fullBorder: false,
                      ),
                      SizedBox(height: 15),

                      Rowlinedatashow(
                        left: "Purchase Total",
                        right:
                            supplierData['purchaseTotalAmount'].toString() ??
                            '',
                      ),
                      Rowlinedatashow(
                        left: "Purchase Paid",
                        right:
                            supplierData['purchaseTotalPaid'].toString() ?? "",
                      ),
                      Rowlinedatashow(
                        left: "Purchase Due",
                        right:
                            supplierData['purchaseTotalRemaining'].toString() ??
                            '',
                      ),
                      Rowlinedatashow(
                        left: "Purchase Dismissed",
                        right:
                            supplierData['purchaseTotalDismissed'].toString() ??
                            '',
                      ),
                      Rowlinedatashow(
                        left: "Purchase Return",
                        right:
                            supplierData['purchaseReturnTotalAmount']
                                .toString() ??
                            '',
                      ),
                      Rowlinedatashow(
                        left: "Purchase Return Paid",
                        right:
                            supplierData['purchaseReturnTotalPaid']
                                .toString() ??
                            '',
                      ),
                      Rowlinedatashow(
                        left: "Purchase Return Due",
                        right:
                            supplierData['purchaseReturnTotalRemaining']
                                .toString() ??
                            '',
                      ),
                      Rowlinedatashow(
                        left: "Purchase Return Dismissed",
                        right:
                            supplierData['purchaseReturnTotalDismissed']
                                .toString() ??
                            '',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

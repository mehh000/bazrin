import 'package:bazrin/feature/data/API/Helper/Purchase/getPurchaseByid.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/classes/prettyPrint.dart';
import 'package:bazrin/feature/presentation/screens/Sale/Presentation/Sales_Return/Components/Sale_return_invoice_container.dart';
import 'package:bazrin/feature/presentation/screens/products/Components/invoice_container.dart';
import 'package:bazrin/feature/presentation/screens/Purchase/Components/purchase_details_container.dart';

class SaleReturnView extends StatefulWidget {
  final dynamic sale;
  const SaleReturnView({super.key, required this.sale});

  @override
  State<SaleReturnView> createState() => _SaleReturnViewState();
}

class _SaleReturnViewState extends State<SaleReturnView> {
  int selectedIndex = 1;
  dynamic saleReurnData;
  bool isLoaded = true;
  dynamic profileData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      profileData = LocalStorage.box.get('myprofile');
      saleReurnData = widget.sale;
    });
  }

  @override
  Widget build(BuildContext context) {
    PrettyPrint.print(saleReurnData);
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
            'View',
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
                                selectedIndex = 2;
                              });
                            },
                            child: Container(
                              width: 150,
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
                                  'Invoice',
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: SaleReturnInvoiceContainer(
                    purchaseDetails: saleReurnData,
                    profileData: profileData,
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

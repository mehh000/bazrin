import 'package:bazrin/feature/data/API/Helper/Pos/getOrderByid.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/classes/prettyPrint.dart';
import 'package:bazrin/feature/presentation/screens/Sale/sub_screens/ManageSales/View/Components/order_package_level.dart';
import 'package:bazrin/feature/presentation/screens/Sale/sub_screens/ManageSales/View/Components/order_pos_invoice.dart';

class ManagesellView extends StatefulWidget {
  final String id;
  const ManagesellView({super.key, required this.id});

  @override
  State<ManagesellView> createState() => _ManagesellViewState();
}

class _ManagesellViewState extends State<ManagesellView> {
  int selectedIndex = 1;
  dynamic orderDetails;
  bool isLoaded = true;
  dynamic profileData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      profileData = LocalStorage.box.get('myprofile');
    });
    // PrettyPrint.print(profileData);
    getOrderDetails();
  }

  void getOrderDetails() async {
    final response = await Getordersbyid.getOrderById(widget.id);
    setState(() {
      orderDetails = response;
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
                                  'Pos Invoice',
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
                                  'packaging Level',
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
                //
                SizedBox(height: 10),
                selectedIndex == 1
                    ? OrderPosInvoice(
                        profile: profileData,
                        invoice: orderDetails,
                      )
                    : OrderPackageLevel(
                        profile: profileData,
                        packageData: orderDetails,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

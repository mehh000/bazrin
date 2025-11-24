
import 'package:bazrin/feature/data/API/Helper/Quotation/getQuotationByid.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/screens/Quotation/Main/Components/quotation_invoice.dart';


class QuotationView extends StatefulWidget {
  final String QuotationDetails;
  const QuotationView({super.key, required this.QuotationDetails});

  @override
  State<QuotationView> createState() => _QuotationViewState();
}

class _QuotationViewState extends State<QuotationView> {
  dynamic invoiceData;
  bool isloaded = false;
  dynamic profileData;
  @override
  void initState() {
    super.initState();
    setState(() {
      profileData = LocalStorage.box.get('myprofile');
      isloaded = true;
    });
    getQuotationByid();
  }



  Future getQuotationByid() async {
    final response = await Getquotationbyid.getQuotationyId(
      widget.QuotationDetails,
    );
    setState(() {
      invoiceData = response;
      isloaded = false;
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
                      page: Quotation(),
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
                                  'Quotation',
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 16,
                  ),
                  child: isloaded
                      ? SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            color: AppColors.Colorprimary,
                          ),
                        )
                      : QuotationInvoice(
                          profileData: profileData,
                          quotationDetails: invoiceData,
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

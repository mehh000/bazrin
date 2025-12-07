import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class CustomerDetails extends StatefulWidget {
  final dynamic detials;
  const CustomerDetails({super.key, required this.detials});

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
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
                      page: CustomarList(),
                      direction: SlideDirection.left,
                    ),
                  );
                },
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ],
          ),
          title: Text(
            'Customer Full Details',
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
                                  'Customer Full Details',
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
                        right:
                            "${widget.detials['name'] != null ? widget.detials['name'] : ''} ",
                      ),
                      Rowlinedatashow(
                        left: "Phone",
                        right: "${widget.detials['phone'] ?? ''} ",
                      ),
                      Rowlinedatashow(
                        left: "Email",
                        right: "${widget.detials['email'] ?? ''} ",
                      ),
                      Rowlinedatashow(
                        left: "Address",
                        right: "${widget.detials['address'] ?? ''}",
                      ),

                      SizedBox(height: 15),

                      DottedBorderComponent(
                        child: SizedBox(width: double.infinity),
                        topBorder: true,
                        fullBorder: false,
                      ),
                      SizedBox(height: 15),

                      Rowlinedatashow(
                        left: "Total Sale",
                        right:
                            '${widget.detials['saleTotalAmount'].toString()}',
                      ),
                      Rowlinedatashow(
                        left: "Sale Paid",
                        right: '${widget.detials['saleTotalPaid'].toString()}',
                      ),
                      Rowlinedatashow(
                        left: "Sale Due",
                        right:
                            '${widget.detials['saleTotalRemaining'].toString()}',
                      ),
                      Rowlinedatashow(
                        left: "Sale Dismissed",
                        right:
                            '${widget.detials['saleTotalDismissed'].toString()}',
                      ),
                      Rowlinedatashow(
                        left: "Total Sale Return",
                        right:
                            '${widget.detials['saleReturnTotalAmount'].toString()}',
                      ),
                      Rowlinedatashow(
                        left: "Sale Return Paid",
                        right:
                            '${widget.detials['saleReturnTotalPaid'].toString()}',
                      ),
                      Rowlinedatashow(
                        left: "Sale Return Due",
                        right:
                            '${widget.detials['saleReturnTotalRemaining'].toString()}',
                      ),
                      Rowlinedatashow(
                        left: "Sale Return Dismissed",
                        right:
                            '${widget.detials['saleReturnTotalDismissed'].toString()}',
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

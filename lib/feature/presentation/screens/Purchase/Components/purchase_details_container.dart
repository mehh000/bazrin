import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/screens/Purchase/Components/purchase_details_item_card.dart';

class PurchaseDetailsContainer extends StatelessWidget {
  final dynamic purchaseDetails;
  final dynamic profileDetails;
  const PurchaseDetailsContainer({
    super.key,
    required this.purchaseDetails,
    required this.profileDetails,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        spacing: 5,
        children: [
          dataRow("Invoice No:", "${purchaseDetails['invoiceNumber'] ?? ''}"),
          dataRow("Date:", "${purchaseDetails['purchaseDate']}"),
          dataRow("Business:", "${profileDetails['setting']['name'] ?? ''}"),
          dataRow(
            "Address:",
            "${profileDetails['setting']['location']['address'] ?? ''}",
          ),
          dataRow("Mobile", "${profileDetails['contact']['phone'] ?? ''}"),
          // Own Store details end here
          SizedBox(height: 10),
          DottedBorder(
            options: CustomPathDottedBorderOptions(
              color: AppColors.colorTextGray,
              padding: EdgeInsets.only(top: 15),
              strokeWidth: 1,
              dashPattern: [8, 8],
              customPath: (size) => Path()
                ..moveTo(0, 0)
                ..relativeLineTo(size.width, 0),
            ),
            child: Column(
              spacing: 10,
              children: [
                dataRow(
                  'Supplier:',
                  "${purchaseDetails['supplier']['name'] ?? ''}",
                ),
                dataRow(
                  "Address:",
                  "${purchaseDetails['supplier']['address'] ?? ''}",
                ),
                dataRow(
                  "Mobile",
                  "${purchaseDetails['supplier']['phone'] ?? ''}",
                ),
              ],
            ),
          ),

          SizedBox(height: 35),

          Container(
            width: double.infinity,

            decoration: BoxDecoration(
              border: Border.all(width: 1, color: const Color(0xFFD6DDD0)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: purchaseDetails['items'].length,

                  itemBuilder: (context, index) {
                    final purchaseD = purchaseDetails['items'][index];
                    return PurchaseDetailsItemCard(purchaseD: purchaseD);
                  },
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1, color: const Color(0xFFD6DDD0)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Amount',
                            style: TextStyle(
                              color: AppColors.colorGray,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          Text(
                            '৳ ${purchaseDetails['totalAmount'].toString()}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Paid',
                            style: TextStyle(
                              color: AppColors.colorGray,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          Text(
                            '৳ ${purchaseDetails['totalPaid'].toString()}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Due',
                            style: TextStyle(
                              color: AppColors.colorGray,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          Text(
                            '৳ ${purchaseDetails['totalRemaining'].toString()} ',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
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

          SizedBox(height: 15),

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
                Headercomponent(title: "Due Bill Payment"),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 15,
                    children: [
                      InputComponent(
                        hintitle: ' Search Payment Method',
                        spcae: 10,
                        preicon: true,
                        islabel: true,
                        label: "Payment Method",
                      ),

                      InputComponent(
                        hintitle: 'Enter Received Amount ',
                        spcae: 10,

                        islabel: true,
                        label: "Received Amount",
                      ),

                      SizedBox(
                        child: ButtonEv(
                          title: "Payment Bill",
                          colorData: AppColors.Colorprimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ), //
        ],
      ),
    );
  }
}

Widget dataRow(String title, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start, // better for multi-line text
    children: [
      Text(
        title,
        style: TextStyle(
          color: AppColors.colorBlack,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),

      // ✅ Wrap the right-side text in Expanded so it can wrap properly
      Expanded(
        child: Text(
          value,
          textAlign: TextAlign.end, // align text to the right
          style: TextStyle(color: AppColors.colorBlack, fontSize: 13),
          softWrap: true,
          overflow: TextOverflow.visible,
          maxLines: 3,
        ),
      ),
    ],
  );
}

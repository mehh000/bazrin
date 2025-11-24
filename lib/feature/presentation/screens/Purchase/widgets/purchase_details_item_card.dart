import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class PurchaseDetailsItemCard extends StatefulWidget {
  final dynamic purchaseD;
  const PurchaseDetailsItemCard({super.key, required this.purchaseD});

  @override
  State<PurchaseDetailsItemCard> createState() =>
      _PurchaseDetailsItemCardState();
}

class _PurchaseDetailsItemCardState extends State<PurchaseDetailsItemCard> {
  @override
  Widget build(BuildContext context) {
    dynamic purchase = widget.purchaseD;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text(
            '${purchase['name'].length > 30 ? '${purchase['name'].substring(0, 40)}...' : purchase['name'] ?? ''}',
            // '2.4G 8MP Cameras Wifi Video Surveillance IP Outdoor Security Protection Monitor 4.0X Zoom Home Wireless Track Alarm Waterproof',
            textAlign: TextAlign.start, // align text to the right
            style: TextStyle(color: AppColors.colorBlack, fontSize: 13),
            softWrap: true,
            overflow: TextOverflow.visible,
            maxLines: 3,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'QUANTITY',
                    style: TextStyle(
                      color: AppColors.colorGray,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  Text(
                    '৳ ${purchase['quantity'].toString()}',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'UNIT PRICE',
                    style: TextStyle(
                      color: AppColors.colorGray,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  Text(
                    '৳ ${purchase['unitPrice'].toString()}',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sub total',
                    style: TextStyle(
                      color: AppColors.colorGray,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  Text(
                    '৳ ${purchase['totalPrice'].toString()}',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

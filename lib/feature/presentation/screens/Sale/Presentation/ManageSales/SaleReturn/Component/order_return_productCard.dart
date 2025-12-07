import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/Components/simple_input.dart';
import 'package:flutter/widgets.dart';

class OrderReturnProductcard extends StatefulWidget {
  final TextEditingController qtyController;
  final dynamic returnSubTotal;
  final dynamic itemDetails;
  const OrderReturnProductcard({
    super.key,
    required this.qtyController,
    required this.itemDetails,
    required this.returnSubTotal,
  });

  @override
  State<OrderReturnProductcard> createState() => _OrderReturnProductcardState();
}

class _OrderReturnProductcardState extends State<OrderReturnProductcard> {
  @override
  Widget build(BuildContext context) {
    dynamic item = widget.itemDetails;
    return item != null
        ? Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 1,
                color: Colors.blueGrey.withOpacity(0.5),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    spacing: 15,
                    children: [
                      Text(
                        "${item['name'] ?? ''}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: AppColors.colorBlack,
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sale Price',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: AppColors.colorTextGray,
                                ),
                              ),

                              Text(
                                '৳${item['unitPrice']}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: AppColors.colorBlack,
                                ),
                              ),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sale Qty',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: AppColors.colorTextGray,
                                ),
                              ),

                              Text(
                                '${item['quantity']} Pcs',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: AppColors.colorBlack,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Return Price',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: AppColors.colorTextGray,
                                ),
                              ),

                              Text(
                                '৳${item['returnablePrice']}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: AppColors.colorBlack,
                                ),
                              ),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Return Qty',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: AppColors.colorTextGray,
                                    ),
                                  ),
                                  Visibility(
                                    visible: true,
                                    child: Text(
                                      '*',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 32,
                                width: 70,
                                child: SimpleInput(
                                  controller: widget.qtyController,
                                  hintText: "0",
                                ),
                              ),
                            ],
                          ),

                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Text(
                          //       'Stock Qty',
                          //       style: TextStyle(
                          //         fontWeight: FontWeight.w500,
                          //         fontSize: 12,
                          //         color: AppColors.colorTextGray,
                          //       ),
                          //     ),

                          //     Text(
                          //       '1 Pcs',
                          //       style: TextStyle(
                          //         fontWeight: FontWeight.w500,
                          //         fontSize: 12,
                          //         color: AppColors.colorBlack,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          SizedBox(),
                        ],
                      ),
                    ],
                  ),
                ),

                DottedBorder(
                  options: CustomPathDottedBorderOptions(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    color: AppColors.colorTextGray,
                    strokeWidth: 1,
                    dashPattern: [8, 8],
                    customPath: (size) => Path()
                      ..moveTo(0, 0)
                      ..relativeLineTo(size.width, 0),
                  ),
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'Return SubTotal:   ৳${widget.returnSubTotal.toString()}',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : SizedBox();
  }
}

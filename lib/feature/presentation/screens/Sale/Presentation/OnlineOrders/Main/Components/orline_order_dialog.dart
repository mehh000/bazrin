// ignore_for_file: unnecessary_string_interpolations

import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/classes/prettyPrint.dart';
import 'package:bazrin/feature/presentation/common/Components/deleteDialog.dart';

class OrlineOrderDialog extends StatefulWidget {
  final dynamic dialogData;
  final Function delete;
  const OrlineOrderDialog({
    super.key,
    required this.dialogData,
    required this.delete,
  });

  @override
  State<OrlineOrderDialog> createState() => _OrlineOrderDialogState();
}

class _OrlineOrderDialogState extends State<OrlineOrderDialog> {
  void onDelete() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Deletedialog(
          title: "Order",
          deleteFuntion: () => widget.delete(widget.dialogData['id']),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Headercomponent(title: "Order No: ${widget.dialogData['orderId']}"),
          Container(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: 15,
              vertical: 20,
            ),
            child: Column(
              spacing: 10,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Customer Name:',
                      style: TextStyle(
                        color: AppColors.colorGray,
                        fontSize: 13,
                      ),
                    ),

                    Text(
                      '${widget.dialogData['customer']['name'].length > 26 ? '${widget.dialogData['customer']['name'].substring(0, 26)}...' : widget.dialogData['customer']['name'] ?? ''}',
                      style: TextStyle(
                        color: AppColors.colorBlack,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date :',
                      style: TextStyle(
                        color: AppColors.colorGray,
                        fontSize: 13,
                      ),
                    ),

                    Text(
                      "${DateTime.parse(widget.dialogData['createdAt']).toLocal().year}-${DateTime.parse(widget.dialogData['createdAt']).toLocal().month.toString().padLeft(2, '0')}-${DateTime.parse(widget.dialogData['createdAt']).toLocal().day.toString().padLeft(2, '0')}",
                      style: TextStyle(
                        color: AppColors.colorBlack,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Amount:',
                      style: TextStyle(
                        color: AppColors.colorGray,
                        fontSize: 13,
                      ),
                    ),

                    Text(
                      '${widget.dialogData['totalAmount'].toString()}',
                      style: TextStyle(
                        color: AppColors.colorBlack,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Paid:',
                      style: TextStyle(
                        color: AppColors.colorGray,
                        fontSize: 13,
                      ),
                    ),

                    Text(
                      '${widget.dialogData['totalPaid'].toString()}',
                      style: TextStyle(
                        color: AppColors.colorBlack,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Remaining',
                      style: TextStyle(
                        color: AppColors.colorGray,
                        fontSize: 13,
                      ),
                    ),

                    Text(
                      '${widget.dialogData['totalRemaining'].toString()}',
                      style: TextStyle(
                        color: AppColors.colorBlack,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Payment Status:',
                      style: TextStyle(
                        color: AppColors.colorGray,
                        fontSize: 13,
                      ),
                    ),

                    Text(
                      '${widget.dialogData['paymentStatus'] == 'PAID'
                          ? 'PAID'
                          : widget.dialogData['paymentStatus'] == 'PARTIALLY_PAID'
                          ? 'PARTIALLY PAID'
                          : 'UNPAID'}',
                      style: TextStyle(
                        color: widget.dialogData['paymentStatus'] == 'PAID'
                            ? Colors.green[700]
                            : widget.dialogData['paymentStatus'] ==
                                  'PARTIALLY_PAID'
                            ? Color(0xFFE88F00)
                            : AppColors.colorRed,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),

                //====== buttom icons ======
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigator.of(context).push(
                          // SlidePageRoute(
                          //   page: PurchaseView(id: widget.dialogData['id']),
                          //   direction: SlideDirection.right,
                          // ),
                          // );
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.remove_red_eye,
                              size: 20,
                              color: AppColors.Colorprimary,
                            ),

                            Text(
                              'View',
                              style: TextStyle(
                                color: AppColors.Colorprimary,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            SlidePageRoute(
                              page: PurchaseReturn(),
                              direction: SlideDirection.right,
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.keyboard_return_sharp,
                              size: 20,
                              color: AppColors.Colorprimary,
                            ),

                            Text(
                              'Sale return',
                              style: TextStyle(
                                color: AppColors.Colorprimary,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          onDelete();
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.delete_forever_outlined,
                              size: 20,
                              color: AppColors.colorRed,
                            ),

                            Text(
                              'Delete',
                              style: TextStyle(
                                color: AppColors.colorRed,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

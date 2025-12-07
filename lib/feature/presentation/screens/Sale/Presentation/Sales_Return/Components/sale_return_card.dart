import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/Components/deleteDialog.dart';
import 'package:bazrin/feature/presentation/screens/Sale/Presentation/OnlineOrders/Main/Components/orline_order_dialog.dart';
import 'package:bazrin/feature/presentation/screens/Sale/Presentation/Sales_Return/Components/sale_return_dialog.dart';

class SaleReturnCard extends StatefulWidget {
  final dynamic sale;
  final Function delfuntion;
  const SaleReturnCard({
    super.key,
    required this.sale,
    required this.delfuntion,
  });

  @override
  State<SaleReturnCard> createState() => _SaleReturnCardState();
}

class _SaleReturnCardState extends State<SaleReturnCard> {
  String productTitile = "Security Protection";

  final GlobalKey _menuKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    dynamic sale = widget.sale;
    return GestureDetector(
      onTap: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => Dialog(
          backgroundColor: Colors.transparent,
          child: SaleReturnDialog(
            dialogData: sale,
            delete: (id) {
              widget.delfuntion(id);
            },
          ),
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: const Color(0xFFD6DDD0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          spacing: 15,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Date & Time: ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF616161),
                            ),
                          ),
                          TextSpan(
                            text:
                                "${widget.sale['returnDate']}", // "${DateTime.parse(widget.sale['returnDate']).toLocal().year}-${DateTime.parse(widget.sale['returnDate']).toLocal().month.toString().padLeft(2, '0')}-${DateTime.parse(widget.sale['returnDate']).toLocal().day.toString().padLeft(2, '0')}",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Invoice Number: ',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF616161),
                        ),
                      ),
                      TextSpan(
                        text: '${widget.sale['invoiceNumber']}',
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Customer Name: ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF616161),
                        ),
                      ),
                      TextSpan(
                        text:
                            '', // '${widget.sale['customer']['name'] ?? 'Not found'}',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Amount',
                      style: TextStyle(color: Color(0xFF616161)),
                    ),
                    Text(
                      '৳ ${widget.sale['totalAmount'] ?? '0'}',
                      style: TextStyle(
                        color: widget.sale['totalPaid'] == 0.0
                            ? Colors.red
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Paid Amount',
                      style: TextStyle(color: Color(0xFF616161)),
                    ),
                    Text('${widget.sale['totalPaid'] ?? ''}'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Remaining',
                      style: TextStyle(color: Color(0xFF616161)),
                    ),
                    Text('${widget.sale['totalRemaining'] ?? ''}'),
                  ],
                ),
              ],
            ),

            //inner
          ],
        ),
      ),
    );
  }
}

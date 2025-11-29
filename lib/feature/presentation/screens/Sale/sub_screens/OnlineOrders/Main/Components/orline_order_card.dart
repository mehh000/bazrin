import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/classes/prettyPrint.dart';
import 'package:bazrin/feature/presentation/common/widgets/deleteDialog.dart';
import 'package:bazrin/feature/presentation/screens/Sale/sub_screens/ManageSales/SaleReturn/sale_return.dart';
import 'package:bazrin/feature/presentation/screens/Sale/sub_screens/ManageSales/View/manageSell_view.dart';
import 'package:bazrin/feature/presentation/screens/Sale/sub_screens/OnlineOrders/Main/Components/orline_order_dialog.dart';
import 'package:bazrin/feature/presentation/screens/supplier/Supplier/Add/supplier_advance_pay.dart';
import 'package:bazrin/feature/presentation/screens/supplier/Supplier/Edit/edit_supplier.dart';

class OrlineOrderCard extends StatefulWidget {
  final dynamic sale;
  final Function delfuntion;
  const OrlineOrderCard({
    super.key,
    required this.sale,
    required this.delfuntion,
  });

  @override
  State<OrlineOrderCard> createState() => _OrlineOrderCardState();
}

class _OrlineOrderCardState extends State<OrlineOrderCard> {
  String productTitile = "Security Protection";

  final GlobalKey _menuKey = GlobalKey();
  void onDelete() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Deletedialog(
          title: "Order",
          deleteFuntion: () => widget.delfuntion(widget.sale['id']),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    dynamic sale = widget.sale;
    return GestureDetector(
      onTap: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => Dialog(
          backgroundColor: Colors.transparent,
          child: OrlineOrderDialog(dialogData: sale, delete: (id) {}),
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
                                "${DateTime.parse(widget.sale['createdAt']).toLocal().year}-${DateTime.parse(widget.sale['createdAt']).toLocal().month.toString().padLeft(2, '0')}-${DateTime.parse(widget.sale['createdAt']).toLocal().day.toString().padLeft(2, '0')}",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Payment Status: ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF616161),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Unpaid', // '${widget.sale['paymentStatus'] ?? ''}',
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Order Number: ',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF616161),
                        ),
                      ),
                      TextSpan(
                        text: '${widget.sale['orderId'].toString()}',
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
                            '${widget.sale['customer']['name'] ?? 'Not found'}',
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
                    Text('Paid', style: TextStyle(color: Color(0xFF616161))),
                    Text(
                      '৳ ${widget.sale['totalPaid'] ?? '0'}',
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
                      'Order Status',
                      style: TextStyle(color: Color(0xFF616161)),
                    ),
                    Text('${widget.sale['orderStatus'] ?? ''}'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shipping Status',
                      style: TextStyle(color: Color(0xFF616161)),
                    ),
                    Text('${widget.sale['shippingStatus'] ?? ''}'),
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

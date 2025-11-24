import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/widgets/deleteDialog.dart';
import 'package:bazrin/feature/presentation/screens/Sale/sub_screens/ManageSales/SaleReturn/sale_return.dart';
import 'package:bazrin/feature/presentation/screens/Sale/sub_screens/ManageSales/View/manageSell_view.dart';
import 'package:bazrin/feature/presentation/screens/supplier/Supplier/Add/supplier_advance_pay.dart';
import 'package:bazrin/feature/presentation/screens/supplier/Supplier/Edit/edit_supplier.dart';

class ManageSellCard extends StatefulWidget {
  final dynamic sale;
  final Function delfuntion;
  const ManageSellCard({
    super.key,
    required this.sale,
    required this.delfuntion,
  });

  @override
  State<ManageSellCard> createState() => _ManageSellCardState();
}

class _ManageSellCardState extends State<ManageSellCard> {
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
    return GestureDetector(
      onTap: () {},
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
                                "${DateTime.parse(widget.sale['saleDate']).toLocal().year}-${DateTime.parse(widget.sale['saleDate']).toLocal().month.toString().padLeft(2, '0')}-${DateTime.parse(widget.sale['saleDate']).toLocal().day.toString().padLeft(2, '0')} ${DateTime.parse(widget.sale['saleDate']).toLocal().hour.toString().padLeft(2, '0')}:${DateTime.parse(widget.sale['saleDate']).toLocal().minute.toString().padLeft(2, '0')}",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Paid',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ],
                ),

                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Sale Number: ',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF616161),
                        ),
                      ),
                      TextSpan(
                        text: '${widget.sale['saleId'].toString()}',
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
                        // text: widget.sup['phone'] ?? 'not available ',
                        text:
                            '${widget.sale['customer']['name'] ?? 'Not found'}',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  key: _menuKey,
                  onTapDown: (TapDownDetails details) async {
                    final position = details.globalPosition;
                    final RenderBox overlay =
                        Overlay.of(context).context.findRenderObject()
                            as RenderBox;

                    final selected = await showMenu<String>(
                      context: context,
                      color: Colors.white,
                      position: RelativeRect.fromLTRB(
                        position.dx - 100, // 👈 move left by ~20px
                        position.dy,
                        overlay.size.width - position.dx,
                        overlay.size.height - position.dy,
                      ),
                      items: [
                        PopupMenuItem<String>(
                          value: 'view',
                          child: Row(
                            children: [
                              const SizedBox(width: 8),
                              const Text('View'),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'sale_return',
                          child: Row(
                            children: [
                              const SizedBox(width: 8),
                              const Text('Sale Return'),
                            ],
                          ),
                        ),

                        PopupMenuItem<String>(
                          value: 'delete',
                          child: Row(
                            children: [
                              const SizedBox(width: 8),
                              const Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );

                    if (selected != null) {
                      // handle action here
                      if (selected == 'view') {
                        Navigator.of(context).push(
                          SlidePageRoute(
                            page: ManagesellView(id: widget.sale['id']),
                            direction: SlideDirection.right,
                          ),
                        );
                      } else if (selected == 'delete') {
                        onDelete();
                      } else if (selected == 'sale_return') {
                        Navigator.of(context).push(
                          SlidePageRoute(
                            page: SaleReturn(),
                            direction: SlideDirection.right,
                          ),
                        );
                      }
                    }
                  },
                  child: Image.asset(
                    'assets/images/3dot.png',
                    height: 16,
                    width: 16,
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
                      'Paid Amount',
                      style: TextStyle(color: Color(0xFF616161)),
                    ),
                    Text('৳ ${widget.sale['totalPaid'] ?? '0'}'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Due Amount ',
                      style: TextStyle(color: Color(0xFF616161)),
                    ),
                    Text('৳ ${widget.sale['totalRemaining'] ?? '0'}'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Amount ',
                      style: TextStyle(color: Color(0xFF616161)),
                    ),
                    Text('৳ ${widget.sale['totalAmount'] ?? '0'}'),
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

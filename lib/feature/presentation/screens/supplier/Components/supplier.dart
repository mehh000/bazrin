import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/widgets/deleteDialog.dart';
import 'package:bazrin/feature/presentation/screens/products/subScreen/EditCategory/edit_cetagory.dart';
import 'package:bazrin/feature/presentation/screens/supplier/Supplier/Add/supplier_advance_pay.dart';
import 'package:bazrin/feature/presentation/screens/supplier/Supplier/Add/supplier_purchase_due_dismiss.dart';
import 'package:bazrin/feature/presentation/screens/supplier/Supplier/Add/supplier_return_due_dismiss.dart';
import 'package:bazrin/feature/presentation/screens/supplier/Supplier/Add/supplier_return_due_receive.dart';
import 'package:bazrin/feature/presentation/screens/supplier/Supplier/Edit/edit_supplier.dart';
import 'package:bazrin/feature/presentation/screens/supplier/sub_screens/Ledger/ledger.dart';
import 'package:flutter/material.dart';

class Supplier extends StatefulWidget {
  final dynamic sup;
  final Function delfuntion;
  const Supplier({super.key, required this.sup, required this.delfuntion});

  @override
  State<Supplier> createState() => _SupplierState();
}

class _SupplierState extends State<Supplier> {
  String productTitile = "Security Protection";

  final GlobalKey _menuKey = GlobalKey();
  void onDelete() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Deletedialog(
          title: "Supplier",
          deleteFuntion: () => widget.delfuntion(widget.sup['id']),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          SlidePageRoute(
            page: SupplierDetails(supplierData: widget.sup),
            direction: SlideDirection.right,
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: const Color(0xFFD6DDD0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Name:',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF616161),
                            ),
                          ),
                          TextSpan(
                            text:
                                '${widget.sup['name'].length > 40 ? '${widget.sup['name'].substring(0, 38)}...' : widget.sup['name']}',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ),

                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Phone Number: ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF616161),
                            ),
                          ),
                          TextSpan(
                            text: widget.sup['phone'] ?? 'not available ',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 50,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Purchase paid',
                          style: TextStyle(color: Color(0xFF616161)),
                        ),
                        Text('৳ ${widget.sup['purchaseTotalPaid']}'),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Purchase due',
                          style: TextStyle(color: Color(0xFF616161)),
                        ),
                        Text('৳ ${widget.sup['purchaseTotalRemaining']}'),
                      ],
                    ),
                  ],
                ),

                //inner
              ],
            ),
            GestureDetector(
              key: _menuKey,
              onTapDown: (TapDownDetails details) async {
                final position = details.globalPosition;
                final RenderBox overlay =
                    Overlay.of(context).context.findRenderObject() as RenderBox;

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
                      value: 'edit',
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          const Text('Edit'),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'Purchase_Due_Pay',
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          const Text('Purchase Due Pay'),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'return_due_reveive',
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          const Text('Return Due Receive'),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'advance',
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          const Text('Advance'),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'purchase_due_dismiss',
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          const Text('Purchase Due Dismiss'),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'return_due_dismiss',
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          const Text('Return Due Dismiss'),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'ledger',
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          const Text('Ledger'),
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
                  if (selected == 'edit') {
                    Navigator.of(context).push(
                      SlidePageRoute(
                        page: EditSupplier(data: widget.sup),
                        direction: SlideDirection.right,
                      ),
                    );
                  } else if (selected == 'delete') {
                    onDelete();
                  } else if (selected == 'ledger') {
                    Navigator.of(context).push(
                      SlidePageRoute(
                        page: LedgerFromSupplier(data: widget.sup),
                        direction: SlideDirection.right,
                      ),
                    );
                  } else if (selected == 'Purchase_Due_Pay') {
                    Navigator.of(context).push(
                      SlidePageRoute(
                        page: PurchaseDuePay(data: widget.sup),
                        direction: SlideDirection.right,
                      ),
                    );
                  } else if (selected == 'return_due_reveive') {
                    Navigator.of(context).push(
                      SlidePageRoute(
                        page: SupplierReturnDueReceive(data: widget.sup),
                        direction: SlideDirection.right,
                      ),
                    );
                  } else if (selected == 'advance') {
                    Navigator.of(context).push(
                      SlidePageRoute(
                        page: SupplierAdvancePay(data: widget.sup),
                        direction: SlideDirection.right,
                      ),
                    );
                  } else if (selected == 'purchase_due_dismiss') {
                    Navigator.of(context).push(
                      SlidePageRoute(
                        page: SupplierPurchaseDueDismiss(data: widget.sup),
                        direction: SlideDirection.right,
                      ),
                    );
                  } else if (selected == 'return_due_dismiss') {
                    Navigator.of(context).push(
                      SlidePageRoute(
                        page: SupplierReturnDueDismiss(data: widget.sup),
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
      ),
    );
  }
}

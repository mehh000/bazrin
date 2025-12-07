import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/screens/products/Presentation/CategoryList/edit_cetagory.dart';
import 'package:flutter/material.dart';

class SupplierLedgercard extends StatefulWidget {
  final dynamic led;
  const SupplierLedgercard({super.key, required this.led});

  @override
  State<SupplierLedgercard> createState() => _SupplierLedgercardState();
}

class _SupplierLedgercardState extends State<SupplierLedgercard> {
  String productTitile = "Security Protection";

  final GlobalKey _menuKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(
        //   SlidePageRoute(page: HomeScreen(), direction: SlideDirection.right),
        // );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: const Color(0xFFD6DDD0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Supplier Name: ',
                    style: TextStyle(fontSize: 14, color: Color(0xFF616161)),
                  ),
                  TextSpan(
                    text:
                        '${widget.led['supplierName'].length > 40 ? '${widget.led['supplierName'].substring(0, 40)}...' : widget.led['supplierName']}',

                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              spacing: 20,

              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Invoice Number:',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF616161),
                            ),
                          ),
                          TextSpan(
                            text:
                                '${widget.led['invoiceNumber'] != null ? widget.led['invoiceNumber'] : 'Not found'}',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Payment Date:',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF616161),
                            ),
                          ),
                          TextSpan(
                            text:
                                '${DateTime.parse(widget.led['timestamp']).toIso8601String().split('T').first}',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Balance',
                      style: TextStyle(fontSize: 14, color: Color(0xFF616161)),
                    ),
                    Text(
                      '${widget.led['balance']}',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

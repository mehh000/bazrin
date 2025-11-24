import 'package:bazrin/feature/presentation/screens/supplier/Components/advanceDialog.dart';
import 'package:flutter/material.dart';

class SupplierPurchaseDueCard extends StatefulWidget {
  final dynamic pur;
  const SupplierPurchaseDueCard({super.key, required this.pur});

  @override
  State<SupplierPurchaseDueCard> createState() =>
      _SupplierPurchaseDueCardState();
}

class _SupplierPurchaseDueCardState extends State<SupplierPurchaseDueCard> {
  String productTitile = "Security Protection";

  final GlobalKey _menuKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            Dialog(backgroundColor: Colors.transparent, child: Advancedialog()),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 5,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Supplier Name: ',
                    style: TextStyle(fontSize: 14, color: Color(0xFF616161)),
                  ),
                  TextSpan(
                    text: widget.pur['supplier']['name'].length > 32
                        ? '${widget.pur['supplier']['name'].substring(0, 32)}...'
                        : widget.pur['supplier']['name'],
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
                            text: widget.pur['invoiceNumber'],
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
                            text: widget.pur['date'],
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ),

                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Account Name:',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF616161),
                            ),
                          ),
                          TextSpan(
                            text: widget.pur['account']['accountNumber'],
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
                      'Due Paid',
                      style: TextStyle(fontSize: 14, color: Color(0xFF616161)),
                    ),
                    Text(
                      '৳ ${widget.pur['amount']}',
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

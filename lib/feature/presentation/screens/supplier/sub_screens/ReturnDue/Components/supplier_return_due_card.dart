import 'package:bazrin/feature/presentation/screens/supplier/Components/advanceDialog.dart';
import 'package:flutter/material.dart';

class SupplierReturnDuePaidCard extends StatefulWidget {
  final dynamic ret;
  const SupplierReturnDuePaidCard({super.key, required this.ret});

  @override
  State<SupplierReturnDuePaidCard> createState() =>
      _SupplierReturnDuePaidCardState();
}

class _SupplierReturnDuePaidCardState extends State<SupplierReturnDuePaidCard> {
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
                    text: widget.ret['supplier']['name'].length > 32
                        ? '${widget.ret['supplier']['name'].substring(0, 32)}...'
                        : widget.ret['supplier']['name'],
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
                            text: widget.ret['invoiceNumber'],
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
                            text: widget.ret['date'],
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
                            text: widget.ret['account']['accountNumber'],
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
                      'Dismissed Amount',
                      style: TextStyle(fontSize: 14, color: Color(0xFF616161)),
                    ),
                    Text(
                      '৳ ${widget.ret['amount']}',
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

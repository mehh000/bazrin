import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:flutter/material.dart';

class CustomerLedgercard extends StatefulWidget {
  final dynamic led;
  const CustomerLedgercard({super.key, required this.led});

  @override
  State<CustomerLedgercard> createState() => _CustomerLedgercardState();
}

class _CustomerLedgercardState extends State<CustomerLedgercard> {
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
          mainAxisSize: MainAxisSize.max,
          spacing: 20,
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
                            text: 'Customer Name: ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF616161),
                            ),
                          ),
                          TextSpan(
                            text: '${widget.led['customerName'] ?? ''}',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Date : ',
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
                        text: '${widget.led['invoiceNumber'] ?? ''}',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Reference: :',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF616161),
                        ),
                      ),
                      TextSpan(
                        text: '${widget.led['referenceType'] ?? ''}',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 5,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Type', style: TextStyle(color: Color(0xFF616161))),
                    Text('${widget.led['type'] ?? ''}'),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dabit', style: TextStyle(color: Color(0xFF616161))),
                    Text('${widget.led['debit'] ?? ''}'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Creadit', style: TextStyle(color: Color(0xFF616161))),
                    Text('${widget.led['credit'] ?? ''}'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Balance', style: TextStyle(color: Color(0xFF616161))),
                    Text('${widget.led['balance'] ?? ''}'),
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

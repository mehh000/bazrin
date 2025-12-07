// ignore_for_file: unnecessary_string_interpolations

import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/screens/Purchase/Components/purchaseDialog.dart';
import 'package:flutter/material.dart';

class Purchase extends StatelessWidget {
  final Function delete;
  final dynamic purchase;
  const Purchase({super.key, required this.purchase, required this.delete});

  void purchaseDialog() {
    Dialog();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => Dialog(
          backgroundColor: Colors.transparent,
          child: Purchasedialog(dialogData: purchase, delete: delete),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        margin: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: const Color(0xFFD6DDD0)),
        ),
        child: Stack(
          children: [
            Column(
              spacing: 20,
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
                                text: 'Supplier : ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF616161),
                                ),
                              ),
                              TextSpan(
                                text:
                                    '${purchase['supplier']['name'].length > 26 ? '${purchase['supplier']['name'].substring(0, 26)}...' : purchase['supplier']['name']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${purchase['purchaseDate'] ?? ''}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF616161),
                          ),
                        ),
                      ],
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Invoice No# ',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF616161),
                            ),
                          ),
                          TextSpan(
                            text: '${purchase['invoiceNumber'] ?? ''}',
                            style: TextStyle(fontSize: 13, color: Colors.black),
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
                          'Total',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF616161),
                          ),
                        ),
                        Text(
                          '৳ ${purchase['totalAmount'].toString()}',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Paid',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF616161),
                          ),
                        ),
                        Text(
                          '৳ ${purchase['totalPaid'].toString()}',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Due',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF616161),
                          ),
                        ),
                        Text(
                          '৳ ${purchase['totalRemaining'].toString()}',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 30,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: purchase['paymentStatus'] == 'PAID'
                      ? Colors.green
                      : purchase['paymentStatus'] == 'PARTIALLY_PAID'
                      ? Color(0xFFE88F00)
                      : AppColors.colorRed,

                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${purchase['paymentStatus'] == 'PAID'
                      ? 'PAID'
                      : purchase['paymentStatus'] == 'PARTIALLY_PAID'
                      ? 'PARTIALLY PAID'
                      : 'UNPAID'}',
                  style: TextStyle(fontSize: 11, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

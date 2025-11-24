import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:flutter/material.dart';

class PreviousPaymentCard extends StatelessWidget {
  final dynamic pre;
  const PreviousPaymentCard({super.key, required this.pre});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: Colors.blueGrey.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Date: ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF616161),
                            ),
                          ),
                          TextSpan(
                            text:
                                '${DateTime.parse(pre['paidDate']).toIso8601String().split('T').first}',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ),

                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Payment Type: ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF616161),
                            ),
                          ),
                          TextSpan(
                            text: '${pre['account']['type']}',
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
                        text: 'Payment Account: ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF616161),
                        ),
                      ),
                      TextSpan(
                        text: '${pre['account']['institutionName']}',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          DottedBorder(
            options: CustomPathDottedBorderOptions(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: AppColors.colorTextGray,
              strokeWidth: 1,
              dashPattern: [8, 8],
              customPath: (size) => Path()
                ..moveTo(0, 0)
                ..relativeLineTo(size.width, 0),
            ),
            child: SizedBox(
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: Text('Paid Amount:   ${pre['amount']}')),
                  VerticalDivider(
                    color: Colors.red, // divider color
                    width: 30, // space occupied by divider
                    thickness: 2, // actual line thickness
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete_forever_outlined, color: Colors.red),
                      Text('Delete', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

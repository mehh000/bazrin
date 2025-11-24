import 'package:bazrin/feature/data/API/Helper/Expense/deleteExpenseById.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/widgets/deleteDialog.dart';
import 'package:bazrin/feature/presentation/screens/products/subScreen/EditCategory/edit_cetagory.dart';
import 'package:flutter/material.dart';

class Expense extends StatefulWidget {
  final dynamic expenseData;
  final Function? delete;

  const Expense({super.key, required this.expenseData, this.delete});

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  final GlobalKey _menuKey = GlobalKey();
  void onDelete() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Deletedialog(
          title: "Expense",
          deleteFuntion: () => widget.delete!(widget.expenseData['id']),
        ),
      ),
    );
  }

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
                            text: 'Date : ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF616161),
                            ),
                          ),
                          TextSpan(
                            text: widget.expenseData['date'],
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
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
                            text: widget.expenseData['invoiceNumber'],
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ),

                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Category: ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF616161),
                            ),
                          ),
                          TextSpan(
                            text: widget.expenseData['category']['name'],
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
                          'Total paid',
                          style: TextStyle(color: Color(0xFF616161)),
                        ),
                        Text('৳ ${widget.expenseData['totalPaid']}'),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total due',
                          style: TextStyle(color: Color(0xFF616161)),
                        ),
                        Text('৳ ${widget.expenseData['totalRemaining']}'),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total amount',
                          style: TextStyle(color: Color(0xFF616161)),
                        ),
                        Text('৳ ${widget.expenseData['totalAmount']}'),
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
                      value: 'view',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 8),
                          const Text('View'),
                        ],
                      ),
                    ),

                    PopupMenuItem<String>(
                      value: 'edit',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 8),
                          const Text('Edit'),
                        ],
                      ),
                    ),

                    PopupMenuItem<String>(
                      value: 'delete',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 8),
                          const Text('Delete'),
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
                        page: EditExpense(id: widget.expenseData['id']),
                        direction: SlideDirection.right,
                      ),
                    );
                  } else if (selected == 'delete') {
                    onDelete();
                  } else if (selected == 'view') {
                    Navigator.of(context).push(
                      SlidePageRoute(
                        page: ExpenseView(expenseDetails: widget.expenseData),
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

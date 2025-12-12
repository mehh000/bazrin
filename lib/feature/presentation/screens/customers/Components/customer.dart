// ignore_for_file: use_build_context_synchronously

import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/Components/deleteDialog.dart';
import 'package:bazrin/feature/presentation/screens/customers/Presentation/Customer/Add/add_return_due_dismiss.dart';
import 'package:bazrin/feature/presentation/screens/customers/Presentation/Customer/Add/add_return_due_pay.dart';
import 'package:bazrin/feature/presentation/screens/customers/Presentation/Customer/Add/add_sale_due_dismiss.dart';
import 'package:bazrin/feature/presentation/screens/customers/Presentation/Customer/Add/add_sale_due_pay.dart';

class Customer extends StatefulWidget {
  final Function delfuntion;
  final dynamic cus;
  const Customer({super.key, required this.cus, required this.delfuntion});

  @override
  State<Customer> createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  String productTitile = "Security Protection";
  dynamic cus;
  @override
  void initState() {
    super.initState();
    setState(() {
      cus = widget.cus;
    });
  }

  void onDelete() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Deletedialog(
          title: "Customer",
          deleteFuntion: () => widget.delfuntion(widget.cus['id']),
        ),
      ),
    );
  }

  final GlobalKey _menuKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          SlidePageRoute(
            page: CustomerDetails(detials: cus),
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
            // product info section
            Column(
              mainAxisSize: MainAxisSize.max,
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Name: ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF616161),
                            ),
                          ),
                          TextSpan(
                            text: '${cus['name'] != null ? cus['name'] : ''}',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Phone Number:',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF616161),
                            ),
                          ),
                          TextSpan(
                            text: ' ${cus['phone'] ?? ''}',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    // RichText(
                    //   text: TextSpan(
                    //     children: [
                    //       TextSpan(
                    //         text: 'Email:',
                    //         style: TextStyle(
                    //           fontSize: 14,
                    //           color: Color(0xFF616161),
                    //         ),
                    //       ),
                    //       TextSpan(
                    //         text: ' ${cus['email'] ?? ''}',
                    //         style: TextStyle(fontSize: 14, color: Colors.black),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),

                Row(
                  spacing: 50,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Sale',
                          style: TextStyle(color: Color(0xFF616161)),
                        ),
                        Text('৳ ${cus['saleTotalAmount'].toString()}'),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Due',
                          style: TextStyle(color: Color(0xFF616161)),
                        ),
                        Text('৳ ${cus['saleTotalRemaining'].toString()}'),
                      ],
                    ),
                  ],
                ),

                //inner
              ],
            ),

            // 3-dot menu
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
                      value: 'sale_due_pay',
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          const Text('Sale Due Pay'),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'return_due_pay',
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          const Text('Return Due Pay'),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'sale_due_dismiss',
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          const Text('Sale Due Dismiss'),
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
                      value: 'ledger_page',
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          const Text('ledger'),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'delete',
                      child: Row(
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
                        page: CustomerUpdate(cus: cus),
                        direction: SlideDirection.right,
                      ),
                    );
                  } else if (selected == 'delete') {
                    onDelete();
                  } else if (selected == 'sale_due_pay') {
                    Navigator.of(context).push(
                      SlidePageRoute(
                        page: CustomerSaleDuePay(data: cus),
                        direction: SlideDirection.right,
                      ),
                    );
                  } else if (selected == 'return_due_pay') {
                    Navigator.of(context).push(
                      SlidePageRoute(
                        page: AddReturnDuePay(data: cus),
                        direction: SlideDirection.right,
                      ),
                    );
                  } else if (selected == 'sale_due_dismiss') {
                    Navigator.of(context).push(
                      SlidePageRoute(
                        page: AddSaleDueDismiss(data: cus),
                        direction: SlideDirection.right,
                      ),
                    );
                  } else if (selected == 'return_due_dismiss') {
                    Navigator.of(context).push(
                      SlidePageRoute(
                        page: AddReturnDueDismiss(data: cus),
                        direction: SlideDirection.right,
                      ),
                    );
                  } else if (selected == 'ledger_page') {
                    Navigator.of(context).push(
                      SlidePageRoute(
                        page: LedgerCustomer(id: cus),
                        direction: SlideDirection.right,
                      ),
                    );
                  } else {
                    Navigator.of(context).pop();
                  }
                }
              },
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Image.asset(
                  'assets/images/3dot.png',
                  height: 16,
                  width: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

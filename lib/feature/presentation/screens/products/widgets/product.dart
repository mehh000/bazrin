import 'package:bazrin/feature/presentation/common/classes/SlidePageRoute.dart';
import 'package:bazrin/feature/presentation/common/classes/colors.dart';
import 'package:bazrin/feature/presentation/common/widgets/deleteDialog.dart';
import 'package:bazrin/feature/presentation/screens/products/subScreen/ViewProduct/view_product.dart';
import 'package:flutter/material.dart';

class Product extends StatefulWidget {
  final dynamic pro;
  final Function delete;
  const Product({super.key, required this.pro, required this.delete});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  final GlobalKey _menuKey = GlobalKey();

  void onDelete() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Deletedialog(
            title: "Product",
            deleteFuntion: () {
              widget.delete(widget.pro['id']);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          SlidePageRoute(page: ViewProduct(), direction: SlideDirection.right),
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
              spacing: 7,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.pro['name'].length > 46
                      ? '${widget.pro['name'].substring(0, 40)}...'
                      : widget.pro['name'] ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                //inner
                Row(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.network(
                      'https://bazrin.com/${widget.pro['coverImage']['md']}',
                      height: 45,
                    ),
                    // Image.asset(
                    //   'assets/images/watch.png',
                    //   height: 45,
                    //   width: 45,
                    // ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Stock Qty: ',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF616161),
                            ),
                          ),
                          TextSpan(
                            text: ' ${widget.pro['totalStock'].toString()}',
                            style: TextStyle(fontSize: 10, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Sale Price(Tk.): ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF616161),
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' ${widget.pro['salePriceRange'][0].toString()}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Pur. Price(Tk.):  ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF616161),
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' ${widget.pro['purchasePriceRange'][0].toString()}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                          Icon(
                            Icons.edit,
                            color: AppColors.Colorprimary,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          const Text('Edit'),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                            color: AppColors.Colorprimary,
                            size: 18,
                          ),
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
                    debugPrint('Edit clicked');
                  } else if (selected == 'delete') {
                    onDelete();
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

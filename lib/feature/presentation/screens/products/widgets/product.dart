import 'package:bazrin/feature/presentation/common/classes/colors.dart';
import 'package:flutter/material.dart';



class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  String productTitile =
      "Men's Canvas Shoes Spring 2024 New Arrivals Watch new addition";

  final GlobalKey _menuKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
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
                productTitile.length > 46
                    ? '${productTitile.substring(0, 46)}...'
                    : productTitile,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
              //inner
              Row(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset('assets/images/watch.png',
                      height: 40, width: 40),
                   RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Stock Qty: ',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF616161),
                          ),
                        ),
                        TextSpan(
                          text: ' 45',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Sale Price(Tk.): ',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF616161),
                              ),
                            ),
                            TextSpan(
                              text: ' 45',
                              style: TextStyle(
                                fontSize: 10,
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
                                fontSize: 10,
                                color: Color(0xFF616161),
                              ),
                            ),
                            TextSpan(
                              text: ' 45',
                              style: TextStyle(
                                fontSize: 10,
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
                        Icon(Icons.edit, color: AppColors.Colorprimary , size: 18),
                        const SizedBox(width: 8),
                        const Text('Edit'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: AppColors.Colorprimary, size: 18),
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
                  debugPrint('Delete clicked');
                }
              }
            },
            child: Image.asset('assets/images/3dot.png', height: 16, width: 16),
          ),
        ],
      ),
    );
  }
}

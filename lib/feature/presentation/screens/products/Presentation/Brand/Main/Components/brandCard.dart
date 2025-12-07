import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/Components/deleteDialog.dart';
import 'package:bazrin/feature/presentation/screens/products/Presentation/Brand/Edit/edit_brand.dart';
import 'package:bazrin/feature/presentation/screens/products/Presentation/CategoryList/edit_cetagory.dart';
import 'package:bazrin/feature/presentation/screens/products/Presentation/Product/View/view_product.dart';
import 'package:flutter/material.dart';

class Brandcard extends StatefulWidget {
  final dynamic brand;
  final Function delete;
  const Brandcard({super.key, required this.brand, required this.delete});

  @override
  State<Brandcard> createState() => _BrandcardState();
}

class _BrandcardState extends State<Brandcard> {
  String productTitile = "Security Protection";

  void onDelete() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Deletedialog(
            title: "Brand",
            deleteFuntion: () {
              widget.delete(widget.brand['id']);
            },
          ),
        );
      },
    );
  }

  final GlobalKey _menuKey = GlobalKey();
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
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.brand['name'].length > 46
                      ? '${widget.brand['name'].substring(0, 40)}...'
                      : widget.brand['name'],
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
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Sub Category:    ',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF616161),
                            ),
                          ),
                          TextSpan(
                            text: ' 0',
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
                                text: 'Status:   ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF616161),
                                ),
                              ),
                              TextSpan(
                                text: ' ${widget.brand['status'] ?? ''}',
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
                    Navigator.of(context).push(
                      SlidePageRoute(
                        page: EditBrand(id: widget.brand['id']),
                        direction: SlideDirection.right,
                      ),
                    );
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

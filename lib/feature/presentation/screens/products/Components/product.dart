import 'package:bazrin/feature/presentation/common/classes/SlidePageRoute.dart';
import 'package:bazrin/feature/presentation/common/classes/colors.dart';
import 'package:bazrin/feature/presentation/common/Components/deleteDialog.dart';
import 'package:bazrin/feature/presentation/screens/products/Presentation/Product/View/view_product.dart';
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
    // Extract data with safe defaults
    final name = widget.pro['name']?.toString() ?? '';
    final coverImage = widget.pro['coverImage'];
    final totalStock = widget.pro['totalStock']?.toString() ?? '0';

    // Safely get array values
    final salePriceRange = (widget.pro['salePriceRange'] as List?) ?? [];
    final purchasePriceRange =
        (widget.pro['purchasePriceRange'] as List?) ?? [];

    // Get first element safely or use default
    final salePrice = salePriceRange.isNotEmpty
        ? salePriceRange[0].toString()
        : '0';
    final purchasePrice = purchasePriceRange.isNotEmpty
        ? purchasePriceRange[0].toString()
        : '0';

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
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                spacing: 7,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name.length > 46 ? '${name.substring(0, 40)}...' : name,
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
                      // Safely load image or show placeholder
                      coverImage != null && coverImage['md'] != null
                          ? Image.network(
                              'https://bazrin.com/${coverImage['md']}',
                              height: 45,
                              width: 45,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 45,
                                  width: 45,
                                  color: Colors.grey[200],
                                  child: Icon(
                                    Icons.image,
                                    color: Colors.grey[400],
                                  ),
                                );
                              },
                            )
                          : Container(
                              height: 45,
                              width: 45,
                              color: Colors.grey[200],
                              child: Icon(Icons.image, color: Colors.grey[400]),
                            ),
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
                              text: ' $totalStock',
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
                                  text: ' $salePrice',
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
                                  text: ' $purchasePrice',
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
                    position.dx - 100,
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
                  if (selected == 'edit') {
                    debugPrint('Edit clicked');
                  } else if (selected == 'delete') {
                    onDelete();
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
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

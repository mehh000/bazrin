import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:flutter/material.dart';

class SubCategory extends StatefulWidget {
  const SubCategory({super.key});

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  String productTitile = "Security Protection";

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Text(
                '৳ 2044',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              Row(
                spacing: 5,
                children: [
                  Text(
                    'Status',
                    style: TextStyle(fontSize: 13, color: Color(0xFF616161)),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.colorRed,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Unpaid',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
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

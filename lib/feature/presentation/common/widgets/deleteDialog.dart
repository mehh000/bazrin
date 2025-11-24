import 'package:bazrin/feature/presentation/common/classes/colors.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:flutter/material.dart';

class Deletedialog extends StatefulWidget {
  final String title;
  final VoidCallback? deleteFuntion;
  const Deletedialog({super.key, this.title = "Object", this.deleteFuntion});

  @override
  State<Deletedialog> createState() => _DeletedialogState();
}

class _DeletedialogState extends State<Deletedialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.red.withOpacity(0.2),
            child: Icon(Icons.error_outline, size: 25, color: Colors.red),
          ),
          Text(
            'Delete this ${widget.title}?',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
          ),
          Text(
            'Are you sure you want to delete this ${widget.title}? This action cannot be undone.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.colorBlack,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonEv(
                title: 'Cancel',
                textColor: AppColors.colorRed,
                isBorder: true,
                borderColor: AppColors.colorRed,
                buttonFunction: () {
                  Navigator.of(context).pop();
                },
              ),
              ButtonEv(
                title: 'Delete',
                colorData: AppColors.colorRed,
                textColor: AppColors.Colorwhite,
                buttonFunction: () {
                  if (widget.deleteFuntion != null) {
                    widget.deleteFuntion!();
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

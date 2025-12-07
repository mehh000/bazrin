import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:flutter/material.dart';

class FileUpload extends StatefulWidget {
  final String label;
  const FileUpload({super.key, this.label = ''});

  @override
  State<FileUpload> createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUpload> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: AppColors.colorBlack,
          ),
        ),

        DottedBorder(
          options: RoundedRectDottedBorderOptions(
            dashPattern: [10, 5],
            strokeWidth: 2,
            radius: Radius.circular(16),
            color: AppColors.colorGray,
          ),

          child: Container(
            width: double.infinity,
            height: 130,
            color: Color(0xFF212B36).withOpacity(0.1),
            child: Center(
              child: Row(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.upload_file,
                    color: Color(0xFF212B36).withOpacity(0.3),
                  ),
                  Text(
                    'upload a file',
                    style: TextStyle(color: AppColors.Colorprimary),
                  ),
                  Text(
                    'or a drug and drop',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:flutter/material.dart';

class SingleImageUploader extends StatefulWidget {
  const SingleImageUploader({super.key});

  @override
  State<SingleImageUploader> createState() => _SingleImageUploaderState();
}

class _SingleImageUploaderState extends State<SingleImageUploader> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  String? _imagePath;

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _imagePath = pickedFile.path; // 📂 here is your file path
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        dashPattern: [10, 5],
        strokeWidth: 2,
        radius: Radius.circular(16),
        color: AppColors.colorGray,
      ),

      child: GestureDetector(
        onTap: () {
          _pickImage(ImageSource.gallery);
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(2),
          height: 130,
          color: Color(0xFF212B36).withOpacity(0.1),
          child: _imageFile != null
              ? Image.file(_imageFile!, fit: BoxFit.contain)
              : Center(
                  child: Row(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo,
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
    );
  }
}

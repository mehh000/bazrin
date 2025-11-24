import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class MultiImageUploader extends StatefulWidget {
  const MultiImageUploader({super.key});

  @override
  State<MultiImageUploader> createState() => _MultiImageUploaderState();
}

class _MultiImageUploaderState extends State<MultiImageUploader> {
  final ImagePicker _picker = ImagePicker();
  final List<File> _selectedImages = [];

  Future<void> _pickImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(pickedFiles.map((file) => File(file.path)));
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        dashPattern: [10, 5],
        strokeWidth: 2,
        radius: const Radius.circular(16),
        color: AppColors.colorGray,
      ),
      child: GestureDetector(
        onTap: _pickImages,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          color: const Color(0xFF212B36).withOpacity(0.1),
          child: _selectedImages.isNotEmpty
              ? Wrap(
                  spacing: 10, // horizontal gap
                  runSpacing: 10, // vertical gap
                  children: List.generate(
                    _selectedImages.length,
                    (index) => Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            _selectedImages[index],
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: -5,
                          right: -5,
                          child: IconButton(
                            onPressed: () => _removeImage(index),
                            icon: CircleAvatar(
                              backgroundColor: AppColors.colorRed.withOpacity(
                                0.3,
                              ),
                              radius: 16,
                              child: Icon(
                                Icons.cancel,
                                size: 18,
                                color: AppColors.colorRed.withOpacity(0.8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox(
                  width: double.infinity,
                  height: 110,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 5,
                      children: [
                        Icon(
                          Icons.add_a_photo,
                          color: const Color(0xFF212B36).withOpacity(0.3),
                        ),
                        Text(
                          'Upload a file ',
                          style: TextStyle(color: AppColors.Colorprimary),
                        ),
                        Text(
                          'or drag and drop',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

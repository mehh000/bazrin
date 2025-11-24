import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/widgets/multi_image_uploader.dart';
import 'package:bazrin/feature/presentation/common/widgets/single_Image_Uploader.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final _controller = QuillController.basic();
  TextEditingController nameController = TextEditingController();

  void submit() {
    dynamic productSubmitData = {
            'name' : nameController.text,
    };

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.Colorprimary,
        appBar: AppBar(
          backgroundColor: AppColors.Colorprimary,
          leading: Row(
            children: [
              SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    SlidePageRoute(
                      page: ProductsScreen(),
                      direction: SlideDirection.left,
                    ),
                  );
                },
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ],
          ),
          title: Text(
            'Product Add',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F7),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              spacing: 20,
              children: [
                //===== Basic Info
                Container(
                  width: double.infinity,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Column(
                    children: [
                      Headercomponent(title: "Basic Information"),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),

                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InputComponent(hintitle: 'Product Name'),
                                  Text(
                                    'Maximum character 0/70',
                                    style: TextStyle(
                                      color: AppColors.colorTextGray,
                                      fontSize: 10,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: InputComponent(
                                    isIcon: true,
                                    hintitle: "Categoris",
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.Colorprimary,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),

                                    child: Icon(Icons.add, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: InputComponent(
                                    isIcon: true,
                                    hintitle: "Search Brand",
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.Colorprimary,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),

                                    child: Icon(Icons.add, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Expanded(child: SearchDropdownList()),
                                IconButton(
                                  onPressed: () {},
                                  icon: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.Colorprimary,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),

                                    child: Icon(Icons.add, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: InputComponent(
                                    isIcon: true,
                                    hintitle: "Search Unit",
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.Colorprimary,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),

                                    child: Icon(Icons.add, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ), //
                //=====Product Specification=======
                Container(
                  width: double.infinity,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Headercomponent(title: "Product Specification"),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // left side inputs
                            Expanded(
                              // this expands horizontally, not vertically
                              child: Column(
                                mainAxisSize:
                                    MainAxisSize.min, // prevents height errors
                                children: [
                                  InputComponent(
                                    isIcon: true,
                                    hintitle: "Specification Name",
                                  ),
                                  const SizedBox(height: 10),
                                  InputComponent(
                                    isIcon: true,
                                    hintitle: "Specification Value",
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            // add button
                            IconButton(
                              onPressed: () {},
                              icon: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: const Icon(
                                  Icons.remove_circle_outline,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 15,
                        ),
                        child: Container(
                          width: 150,
                          padding: EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.Colorprimary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                Icon(Icons.add, color: Colors.white),
                                Text(
                                  'Add Row',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ), //
                //===== Product Variation ========
                Container(
                  width: double.infinity,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Column(
                    children: [
                      Headercomponent(title: "Product Variation"),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Single Variation',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: AppColors.colorBlack,
                              ),
                            ),
                            SizedBox(height: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              spacing: 15,
                              children: [
                                InputComponent(hintitle: 'Sale Price'),
                                InputComponent(hintitle: 'Min Sale Price'),
                                InputComponent(hintitle: 'Purchase Price'),
                                InputComponent(hintitle: 'Wholesale Price'),
                                InputComponent(
                                  hintitle: 'Wholesale Minimum Price',
                                ),
                                InputComponent(hintitle: 'Stock'),
                                InputComponent(hintitle: 'Alert Quantity'),
                                InputComponent(hintitle: 'SKU'),
                                InputComponent(hintitle: 'Barcode'),
                              ],
                            ),

                            Container(
                              padding: EdgeInsets.symmetric(vertical: 25),
                              width: double.infinity,
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                spacing: 15,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 15,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.Colorprimary,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Row(
                                        spacing: 5,
                                        children: [
                                          Icon(
                                            Icons.add_circle_outline,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            'Add Varient',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 15,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: BoxBorder.all(
                                        width: 2,
                                        color: AppColors.Colorprimary,
                                      ),
                                    ),
                                    child: Center(
                                      child: Row(
                                        spacing: 5,
                                        children: [
                                          Icon(
                                            Icons.arrow_back,
                                            color: AppColors.Colorprimary,
                                          ),
                                          Text(
                                            'Single Varient',
                                            style: TextStyle(
                                              color: AppColors.Colorprimary,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'Variation 0',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: AppColors.colorBlack,
                              ),
                            ),
                            SizedBox(height: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              spacing: 15,
                              children: [
                                InputComponent(hintitle: 'Add Variant'),
                                InputComponent(hintitle: 'Add Option'),

                                DottedBorder(
                                  options: RectDottedBorderOptions(
                                    dashPattern: [10, 5],
                                    color: Colors.red,
                                    strokeWidth: 2,
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(),
                                    child: Row(
                                      spacing: 10,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.remove_circle_outline,
                                          color: Colors.red,
                                        ),
                                        Center(
                                          child: Text(
                                            'Delete Variant',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ), //
                // ======= Upload Product Image =======
                Container(
                  width: double.infinity,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Column(
                    children: [
                      Headercomponent(title: "Upload Product Image"),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 15,
                              children: [
                                Text(
                                  'Upload Product Cover Image',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: AppColors.colorBlack,
                                  ),
                                ),
                                SingleImageUploader(),
                              ],
                            ),

                            SizedBox(height: 25),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 15,
                              children: [
                                Text(
                                  'Upload Product Image',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: AppColors.colorBlack,
                                  ),
                                ),
                                MultiImageUploader(),
                              ],
                            ),

                            SizedBox(height: 25),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 15,
                              children: [
                                Text(
                                  'Upload Product Video',
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add_a_photo,
                                            color: Color(
                                              0xFF212B36,
                                            ).withOpacity(0.3),
                                          ),
                                          Text(
                                            'upload a file',
                                            style: TextStyle(
                                              color: Colors.green,
                                            ),
                                          ),
                                          Text(
                                            'or a drug and drop',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ), //
                // ======= Product Detail =======
                Container(
                  width: double.infinity,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Column(
                    children: [
                      Headercomponent(title: "Product Detail"),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Product Descriptions',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: AppColors.colorBlack,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                // color: Colors.black.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.black.withOpacity(0.1),
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  QuillSimpleToolbar(
                                    controller: _controller,
                                    config: QuillSimpleToolbarConfig(
                                      showBoldButton: true,
                                      showItalicButton: true,
                                      showUnderLineButton: true,
                                      showAlignmentButtons: true,
                                      showStrikeThrough: false,
                                      showFontFamily: false,
                                      showFontSize: false,
                                      showColorButton: false,
                                      showBackgroundColorButton: false,
                                      showListNumbers: false,
                                      showListBullets: false,
                                      showListCheck: false,
                                      showCodeBlock: false,
                                      showQuote: false,
                                      showLink: false,
                                      showClearFormat: false,
                                      showUndo: false,
                                      showRedo: false,
                                      showSearchButton: false,
                                      showHeaderStyle: false,
                                      showDividers: false,
                                      showInlineCode: false,
                                      multiRowsDisplay: false,
                                      color: Colors.black.withOpacity(0.1),
                                    ),
                                  ),
                                  Container(
                                    height: 200,
                                    padding: EdgeInsets.all(8),
                                    child: QuillEditor.basic(
                                      controller: _controller,
                                      config: QuillEditorConfig(
                                        placeholder:
                                            "Enter Product Description",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment
                                  .centerRight, // aligns child to the right
                              child: Text(
                                'Maximum character 0/70',
                                style: TextStyle(
                                  color: AppColors.colorTextGray,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Product Short Descriptions',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: AppColors.colorBlack,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                // color: Colors.black.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.black.withOpacity(0.1),
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  QuillSimpleToolbar(
                                    controller: _controller,
                                    config: QuillSimpleToolbarConfig(
                                      showBoldButton: true,
                                      showItalicButton: true,
                                      showUnderLineButton: true,
                                      showAlignmentButtons: true,
                                      showStrikeThrough: false,
                                      showFontFamily: false,
                                      showFontSize: false,
                                      showColorButton: false,
                                      showBackgroundColorButton: false,
                                      showListNumbers: false,
                                      showListBullets: false,
                                      showListCheck: false,
                                      showCodeBlock: false,
                                      showQuote: false,
                                      showLink: false,
                                      showClearFormat: false,
                                      showUndo: false,
                                      showRedo: false,
                                      showSearchButton: false,
                                      showHeaderStyle: false,
                                      showDividers: false,
                                      showInlineCode: false,
                                      multiRowsDisplay: false,
                                      color: Colors.black.withOpacity(0.1),
                                    ),
                                  ),
                                  Container(
                                    height: 140,
                                    padding: EdgeInsets.all(8),
                                    child: QuillEditor.basic(
                                      controller: _controller,
                                      config: QuillEditorConfig(
                                        placeholder:
                                            "Enter Product Description",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 15,
                              children: [
                                Text(
                                  ' Product Commission',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: AppColors.colorBlack,
                                  ),
                                ),
                                InputComponent(
                                  isIcon: true,
                                  hintitle: "Percent",
                                ),
                                InputComponent(isIcon: true, hintitle: "Value"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ), //

                Container(
                  width: double.infinity,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Column(
                    children: [
                      Headercomponent(title: "Product Variation"),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 15,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 15,
                              children: [
                                Text(
                                  'Product Weight',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: AppColors.colorBlack,
                                  ),
                                ),
                                InputComponent(hintitle: 'Kg ', isIcon: true),
                                InputComponent(hintitle: 'Weight Grams'),
                              ],
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 15,
                              children: [
                                Text(
                                  'Product Size',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: AppColors.colorBlack,
                                  ),
                                ),
                                InputComponent(hintitle: 'Input Height '),
                                InputComponent(hintitle: 'Input Height'),
                                InputComponent(hintitle: 'Input Height'),
                              ],
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 15,
                              children: [
                                Text(
                                  'Product Warrantys',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: AppColors.colorBlack,
                                  ),
                                ),
                                InputComponent(
                                  hintitle: 'Select A Type ',
                                  isIcon: true,
                                ),
                              ],
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 15,
                              children: [
                                Text(
                                  'Warranty',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: AppColors.colorBlack,
                                  ),
                                ),
                                Row(
                                  spacing: 10,
                                  children: [
                                    Expanded(
                                      child: InputComponent(hintitle: 'Years '),
                                    ),
                                    Text(
                                      'YY',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  spacing: 10,
                                  children: [
                                    Expanded(
                                      child: InputComponent(hintitle: 'Months'),
                                    ),
                                    Text(
                                      'MM',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  spacing: 10,
                                  children: [
                                    Expanded(
                                      child: InputComponent(hintitle: 'Days'),
                                    ),
                                    Text(
                                      'DD',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Container(
                              padding: EdgeInsets.symmetric(vertical: 25),
                              width: double.infinity,
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                spacing: 15,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 15,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: BoxBorder.all(
                                        width: 2,
                                        color: AppColors.colorRed,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Clear Warranty',
                                        style: TextStyle(
                                          color: AppColors.colorRed,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ), //

                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 15,
                    children: [
                      ButtonEv(
                        title: 'Cancel',
                        textColor: AppColors.colorRed,
                        isBorder: true,
                        borderColor: AppColors.colorRed,
                      ),
                      ButtonEv(
                        title: 'Draft',
                        colorData: AppColors.Colorprimary,
                      ),
                      ButtonEv(
                        title: 'Publish',
                        colorData: AppColors.Colorprimary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

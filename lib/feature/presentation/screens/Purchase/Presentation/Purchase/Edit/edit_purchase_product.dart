import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/Components/simple_input.dart';

class EditPurchaseProduct extends StatefulWidget {
  const EditPurchaseProduct({super.key});

  @override
  State<EditPurchaseProduct> createState() => _EditPurchaseProductState();
}

class _EditPurchaseProductState extends State<EditPurchaseProduct> {
  final _controller = QuillController.basic();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.Colorprimary,
          leading: Row(
            children: [
              SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    SlidePageRoute(
                      page: HomeScreen(),
                      direction: SlideDirection.left,
                    ),
                  );
                },
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ],
          ),
          title: Text(
            'Edit Purchase Product',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: AppColors.Colorprimary,
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
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Column(
                    children: [
                      Headercomponent(title: 'Edit Purchase Product'),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: Column(
                          spacing: 10,
                          children: [
                            InputComponent(
                              hintitle: 'Search Supplier Name',
                              label: "Supplier Name",
                              islabel: true,
                              spcae: 10,
                              required: true,
                              isIcon: true,
                            ),
                            InputComponent(
                              hintitle: '112566436944',
                              label: "Invoice No",
                              isIcon: true,
                              islabel: true,
                              spcae: 10,
                              required: true,
                            ),
                            DatePicker(),

                            // InputComponent(
                            //   hintitle: '2025-09-28',
                            //   label: "Purchase Date",
                            //   islabel: true,
                            //   spcae: 10,
                            //   required: true,
                            //   iconName: Icons.calendar_month_outlined,
                            //   isIcon: true,
                            // ),
                            InputComponent(
                              hintitle: 'Select Return Type',
                              label: "Return Type",
                              islabel: true,
                              spcae: 10,
                              isIcon: true,
                              required: true,
                            ),
                            SizedBox(height: 10),

                            Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Note',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: AppColors.colorBlack,
                                  ),
                                ),
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
                              ],
                            ),
                            SizedBox(height: 10),
                            Column(
                              spacing: 15,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Attachments',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: AppColors.colorBlack,
                                  ),
                                ),
                                DottedBorder(
                                  options: RoundedRectDottedBorderOptions(
                                    dashPattern: [8, 8],
                                    strokeWidth: 1,
                                    radius: Radius.circular(8),
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
                ),
                SizedBox(height: 35),

                Container(
                  width: double.infinity,
                  height: 50,

                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                      255,
                      247,
                      247,
                      247,
                    ).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 1,
                      color: Colors.blueGrey.withOpacity(0.5),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: double.infinity,
                        width: 50,
                        color: Colors.black.withOpacity(0.1),
                        child: Center(
                          child: Image.asset('assets/images/sku.png'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 35),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 1,
                      color: Colors.blueGrey.withOpacity(0.5),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: Column(
                          spacing: 15,
                          children: [
                            Text(
                              '2.4G 8MP Cameras Wifi Video Surveillance IP Outdoor Security Protection Monitor 4.0X Zoom Home Wireless Track Alarm Waterproof',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: AppColors.colorBlack,
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Purchase Qty',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: AppColors.colorTextGray,
                                      ),
                                    ),

                                    Text(
                                      '1 Pcs',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: AppColors.colorBlack,
                                      ),
                                    ),
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Return Qty',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: AppColors.colorTextGray,
                                      ),
                                    ),

                                    Text(
                                      '1 Pcs',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: AppColors.colorBlack,
                                      ),
                                    ),
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Stock Qty',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: AppColors.colorTextGray,
                                      ),
                                    ),

                                    Text(
                                      '1 Pcs',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: AppColors.colorBlack,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Quantity',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: AppColors.colorTextGray,
                                      ),
                                    ),

                                    SizedBox(
                                      height: 38,
                                      width: 70,
                                      child: SimpleInput(),
                                    ),
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Unit Price',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: AppColors.colorTextGray,
                                      ),
                                    ),

                                    SizedBox(
                                      height: 38,
                                      width: 70,
                                      child: SimpleInput(),
                                    ),
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Sale Price',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: AppColors.colorTextGray,
                                      ),
                                    ),

                                    SizedBox(
                                      height: 38,
                                      width: 70,
                                      child: SimpleInput(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      DottedBorder(
                        options: CustomPathDottedBorderOptions(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          color: AppColors.colorTextGray,
                          strokeWidth: 1,
                          dashPattern: [8, 8],
                          customPath: (size) => Path()
                            ..moveTo(0, 0)
                            ..relativeLineTo(size.width, 0),
                        ),
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text('Total Purchase Price:   ৳1500'),
                              ),
                              VerticalDivider(
                                color: Colors.red, // divider color
                                width: 30, // space occupied by divider
                                thickness: 2, // actual line thickness
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.delete_forever_outlined,
                                    color: Colors.red,
                                  ),
                                  Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ), // container last one ends here

                SizedBox(height: 12),
                InputComponent(
                  hintitle: "120",
                  islabel: true,
                  label: "Total Amount",
                  spcae: 10,
                ),

                SizedBox(height: 12),
                InputComponent(
                  hintitle: '0',
                  islabel: true,
                  spcae: 12,
                  label: 'Total Paid',
                ),

                SizedBox(height: 12),
                InputComponent(
                  hintitle: 'Search Payment Account',
                  islabel: true,
                  spcae: 12,
                  label: 'Payment Account',
                  preicon: true,
                ),

                SizedBox(height: 12),
                InputComponent(
                  hintitle: '0',
                  islabel: true,
                  spcae: 12,
                  label: 'Total Paid',
                ),

                SizedBox(height: 20),
                Row(
                  spacing: 15,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ButtonEv(
                      title: 'Cancle',
                      textColor: AppColors.colorRed,
                      isBorder: true,
                      borderColor: AppColors.colorRed,
                    ),
                    ButtonEv(
                      title: 'Update',
                      colorData: AppColors.Colorprimary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

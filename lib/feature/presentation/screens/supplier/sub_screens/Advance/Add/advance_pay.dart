import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:flutter/material.dart';

class AdvancePay extends StatefulWidget {
  const AdvancePay({super.key});

  @override
  State<AdvancePay> createState() => _AdvancePayState();
}

class _AdvancePayState extends State<AdvancePay> {
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
            'Advance Pay',
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
                      Headercomponent(title: "Advance Pay"),
                      Container(
                        width: double.infinity,
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
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name: Nasir Khan',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Mobile number',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Address',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Note',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            // ======= Quile Text start here======
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
                            ), // ======= Quile Text End here======
                            Flaginputcomponent(
                              hintitle: "0",
                              islabel: true,
                              label: "Total Receivable",
                              spcae: 12,
                              imagePath: "assets/images/icons/give.svg",
                            ),
                            Flaginputcomponent(
                              hintitle: "0",
                              islabel: true,
                              label: "Paying Amount",
                              spcae: 12,
                              imagePath: "assets/images/icons/take.svg",
                            ),
                            Flaginputcomponent(
                              hintitle: "10/10/2025",
                              islabel: true,
                              label: "Paying Date",
                              spcae: 12,
                              imagePath: "assets/images/icons/date.svg",
                            ),
                            Flaginputcomponent(
                              hintitle: "Search here ",
                              islabel: true,
                              label: "Paying With",
                              spcae: 12,
                              imagePath: "assets/images/icons/takesmall.svg",
                            ),
                            SizedBox(height: 30),
                            Row(
                              spacing: 20,

                              children: [
                                Expanded(
                                  child: ButtonEv(
                                    title: "Cancle",
                                    textColor: AppColors.colorRed,
                                    isBorder: true,
                                    borderColor: AppColors.colorRed,
                                  ),
                                ),
                                Expanded(
                                  child: ButtonEv(
                                    title: "Update",
                                    textColor: AppColors.Colorwhite,
                                    colorData: AppColors.Colorprimary,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

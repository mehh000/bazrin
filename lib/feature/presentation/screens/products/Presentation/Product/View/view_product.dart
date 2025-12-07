import 'package:bazrin/feature/presentation/common/classes/SlidePageRoute.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/Components/buttonEv.dart';
import 'package:bazrin/feature/presentation/screens/products/Presentation/Product/Main/products_screen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ViewProduct extends StatefulWidget {
  const ViewProduct({super.key});

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
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
            'Product View',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: AppColors.Colorprimary,
        body: Expanded(
          child: Container(
            height: double.infinity,
            width: double.infinity,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 380,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/showes.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 11),
                  Text(
                    'Product Name:',
                    style: TextStyle(
                      color: AppColors.colorBlack,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 11),
                  DottedBorder(
                    options: CustomPathDottedBorderOptions(
                      color: AppColors.colorTextGray,
                      strokeWidth: 1,
                      dashPattern: [8, 8],
                      customPath: (size) => Path()
                        ..moveTo(0, 0)
                        ..relativeLineTo(size.width, 0)
                        ..moveTo(0, size.height)
                        ..relativeLineTo(size.width, 0),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(),
                      child: Column(
                        spacing: 17,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Men's Canvas Shoes Spring 2024New Fashion Summer Breathable Versatile Lace Up Skateboarding Shoes Men Foot Flat Shoes 24178",
                            style: TextStyle(
                              color: AppColors.colorTextGray,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Product Details',
                            style: TextStyle(
                              color: AppColors.colorBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      spacing: 5,
                      children: [
                        RowComponent('Stock Qty', "12"),
                        RowComponent('Sale Price(Tk.)', "12"),
                        RowComponent('Sale Price(Tk.) ', "12"),
                        RowComponent('Whole. Price(Tk.) ', "12"),
                        RowComponent('Brand ', "Nike Air Jordan"),
                        RowComponent('Category ', "12"),
                        RowComponent('Status ', "12"),
                      ],
                    ),
                  ),

                  Row(
                    spacing: 15,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          child: ButtonEv(
                            title: 'Delete',
                            textColor: Colors.red,
                            isBorder: true,
                            borderColor: Colors.red,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          child: ButtonEv(
                            title: 'Close',
                            isBorder: true,
                            borderColor: AppColors.Colorprimary,
                            textColor: AppColors.Colorprimary,
                            // textColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
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

Widget RowComponent(title, value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        '$title',
        style: TextStyle(color: AppColors.colorTextGray, fontSize: 14),
      ),

      Text(
        '$value',
        style: TextStyle(color: AppColors.colorBlack, fontSize: 14),
      ),
    ],
  );
}

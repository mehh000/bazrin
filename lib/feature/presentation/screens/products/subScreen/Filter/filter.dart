import 'package:bazrin/feature/presentation/common/classes/SlidePageRoute.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/screens/products/Product/Main/products_screen.dart';
import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
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
            'Filter',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        body: Expanded(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F7),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  spacing: 15,
                  children: [
                    dropdown('Supplier', 'Supplier'),
                    dropdown('Categories', 'Categories'),
                    dropdown('Categories', 'Categories'),
                  ],
                ),

                Container(
                  width: double.infinity,
                  child: Row(
                    spacing: 20,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: BoxBorder.all(color: Colors.red, width: 1),
                          ),
                          child: Center(
                            child: Text(
                              'Clear',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.Colorprimary,
                            borderRadius: BorderRadius.circular(8),
                            border: BoxBorder.all(
                              color: AppColors.Colorprimary,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Filter',
                              style: TextStyle(color: Colors.white),
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
        ),
      ),
    );
  }
}

Widget dropdown(title, label) {
  return Container(
    width: double.infinity,
    child:
        // === supplyer==
        Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                '$label',
                style: TextStyle(fontSize: 14, color: AppColors.colorBlack),
              ),
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 17, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: BoxBorder.all(width: 1, color: Color(0xFFD6DDD0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select $title',
                    style: TextStyle(color: AppColors.colorGray, fontSize: 14),
                  ),
                  Icon(Icons.arrow_drop_down, color: AppColors.colorGray),
                ],
              ),
            ),
          ],
        ),
  );
}

import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:flutter/material.dart';

class FilterAdvance extends StatefulWidget {
  const FilterAdvance({super.key});

  @override
  State<FilterAdvance> createState() => _FilterAdvanceState();
}

class _FilterAdvanceState extends State<FilterAdvance> {
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
            'Brand List',
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                spacing: 20,
                children: [
                  InputComponent(
                    hintitle: "Invoice Number",
                    islabel: true,
                    label: "Search Invoice Number",
                    spcae: 15,
                    isIcon: true,
                  ),
                  InputComponent(
                    hintitle: "Search Account",
                    islabel: true,
                    label: "Account",
                    spcae: 15,
                    isIcon: true,
                  ),
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
    );
  }
}

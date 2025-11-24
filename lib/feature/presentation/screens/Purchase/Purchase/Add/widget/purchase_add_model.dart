// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:flutter/material.dart';

class PurchaseAddModel extends StatefulWidget {
  const PurchaseAddModel({super.key});

  @override
  State<PurchaseAddModel> createState() => _PurchaseAddModelState();
}

class _PurchaseAddModelState extends State<PurchaseAddModel> {
  TextEditingController first_Serial_controller = TextEditingController();
  TextEditingController second_serial_controller = TextEditingController();

  String? serial_error;
  int loopendat = 1;


  List<TextEditingController> modelControllers = [];

  @override
  void initState() {
    super.initState();
    modelControllers.add(TextEditingController()); 
  }

  void generateSerial() {
    String firstRange = first_Serial_controller.text.trim();
    String secondRange = second_serial_controller.text.trim();

    final firstMatch = RegExp(r'(\d+)$').firstMatch(firstRange);
    final secondMatch = RegExp(r'(\d+)$').firstMatch(secondRange);

    if (firstMatch == null || secondMatch == null) {
      setState(() {
        serial_error = "Both serials must end with numbers";
      });
      return;
    }


    int firstNum = int.parse(firstMatch.group(1)!);
    int secondNum = int.parse(secondMatch.group(1)!);


    String prefix1 = firstRange
        .replaceAll(RegExp(r'(\d+)$'), "")
        .replaceAll(RegExp(r'[-_]+$'), "");

    String prefix2 = secondRange
        .replaceAll(RegExp(r'(\d+)$'), "")
        .replaceAll(RegExp(r'[-_]+$'), "");

    if (prefix1 != prefix2) {
      setState(() {
        serial_error = "Prefix before numbers does NOT match";
      });
      return;
    }

    
    int start = firstNum;
    int end = secondNum;

    int qty = (end - start).abs() + 1;

    
    setState(() {
      loopendat = qty;
      modelControllers = List.generate(qty, (index) => TextEditingController());
    });
  }


  void onConfirm() {
    List<String> allModels = modelControllers
        .map((c) => c.text.trim())
        .toList();

    print("Collected Models:");
    print(allModels);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 600,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.only(left: 20, top: 10, bottom: 12),
            child: Text(
              'Add Model',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: AppColors.colorBlack,
              ),
            ),
          ),
          Divider(),

          // Serial Range Section
          Container(
            padding: EdgeInsets.all(12),
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Serial Range',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.colorBlack,
                  ),
                ),
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: InputComponent(
                        hintitle: "Ex-xxxx1",
                        controller: first_Serial_controller,
                      ),
                    ),
                    Expanded(
                      child: InputComponent(
                        hintitle: "Ex-xxxx1",
                        controller: second_serial_controller,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: ButtonEv(
                    title: "Generate",
                    colorData: AppColors.Colorprimary,
                    buttonFunction: generateSerial,
                  ),
                ),
                serial_error != null
                    ? Text(
                        serial_error!,
                        style: TextStyle(color: Colors.red, fontSize: 11),
                      )
                    : SizedBox(),
              ],
            ),
          ),

          // Model List Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: AppColors.colorGray),
            ),
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 13,
                  children: [
                    Text(
                      'SL',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColors.colorBlack,
                      ),
                    ),
                    Text(
                      'Model',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColors.colorBlack,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Action',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppColors.colorBlack,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 200,
                  child: ListView.separated(
                    itemCount: loopendat,
                    separatorBuilder: (_, __) => SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      return Row(
                        spacing: 12,
                        children: [
                          Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.colorBlack,
                            ),
                          ),

                          // 👇 Each field has its controller
                          Expanded(
                            child: InputComponent(
                              hintitle: "Ex-xxxx1",
                              controller: modelControllers[index],
                            ),
                          ),

                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  // delete row
                                  if (loopendat > 1) {
                                    setState(() {
                                      loopendat--;
                                      modelControllers.removeAt(index);
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.cancel_outlined,
                                  color: Colors.red,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  // add row
                                  setState(() {
                                    loopendat++;
                                    modelControllers.add(
                                      TextEditingController(),
                                    );
                                  });
                                },
                                icon: Icon(
                                  Icons.add_circle_outline_rounded,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 12),

          // Bottom Buttons
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Row(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonEv(
                  title: 'Close',
                  isBorder: true,
                  borderColor: AppColors.colorBlack,
                  textColor: AppColors.colorBlack,
                  buttonFunction: () {
                    Navigator.pop(context);
                  },
                ),
                ButtonEv(
                  title: 'Confirm',
                  colorData: AppColors.Colorprimary,
                  buttonFunction: onConfirm,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

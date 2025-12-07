import 'package:bazrin/feature/data/API/Helper/Customer/addCustomer.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';

import 'package:flutter/widgets.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({super.key});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();
  dynamic phoneNumber;

  @override
  void initState() {
    super.initState();
  }

  void submitEdit() async {
    dynamic supplierUpdated = {
      "name": usernameController.text,
      "email": emailController.text,
      "phone": phoneNumber,
      "address": addressController.text,
    };

    try {
      final response = await Addcustomer.addCustomer(supplierUpdated);
      if (response == 'success') {
        Navigator.of(context).push(
          SlidePageRoute(page: CustomarList(), direction: SlideDirection.right),
        );
        TostMessage.showToast(
          context,
          message: "Customer Created Successfully",
          isSuccess: true,
        );
      }
      // print('res : $response');
      // print('submited data : $supplierUpdated');
    } catch (e) {
      print(e);
    }
    // print('supplier : $supplierUpdated');
  }

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
                      page: CustomarList(),
                      direction: SlideDirection.left,
                    ),
                  );
                },
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ],
          ),
          title: Text(
            'Add Customer',
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
                      Headercomponent(title: "Add Customer"),
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
                          spacing: 15,
                          children: [
                            InputComponent(
                              hintitle: "Write Customer Name",
                              islabel: true,
                              label: "Customer Name",
                              spcae: 12,
                              controller: usernameController,
                            ),

                            InputComponent(
                              hintitle: "Write Customer Email",
                              islabel: true,
                              label: "Customer Email",
                              spcae: 12,
                              controller: emailController,
                            ),

                            PhoneInputWidget(
                              label: "Write Customer Phone Number",
                              insialNumber: phoneNumber,
                              phonecontrollerl: phonecontroller,
                              data: (e) {
                                setState(() {
                                  phoneNumber = e;
                                });
                              },
                            ),
                            InputComponent(
                              hintitle: "Write Customer Address",
                              islabel: true,
                              label: "Customer Address",
                              spcae: 12,
                              controller: addressController,
                            ),
                            SizedBox(height: 20),

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
                                    title: "Add",
                                    textColor: AppColors.Colorwhite,
                                    colorData: AppColors.Colorprimary,
                                    buttonFunction: submitEdit,
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

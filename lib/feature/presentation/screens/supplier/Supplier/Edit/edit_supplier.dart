import 'package:bazrin/feature/data/API/Helper/Supplier/getSupplierByid.dart';
import 'package:bazrin/feature/data/API/Helper/Supplier/updateSupplierbyid.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/widgets/tost_message.dart';
import 'package:flutter/widgets.dart';

class EditSupplier extends StatefulWidget {
  final dynamic data;
  const EditSupplier({super.key, required this.data});

  @override
  State<EditSupplier> createState() => _EditSupplierState();
}

class _EditSupplierState extends State<EditSupplier> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();
  dynamic phoneNumber;

  @override
  void initState() {
    super.initState();
    getSupplier();
    setState(() {
      phoneNumber = widget.data['phone'];
    });
  }

  void submitEdit() async {
    String supplierId = widget.data['id'];
    dynamic supplierUpdated = {
      "name": usernameController.text,
      "email": emailController.text,
      "phone": phoneNumber,
      "address": addressController.text,
    };

    try {
      final response = await Updatesupplierbyid.UpdateSupplierByid(
        supplierUpdated,
        supplierId,
      );
      if (response == 'success') {
        Navigator.of(context).push(
          SlidePageRoute(page: SupplierList(), direction: SlideDirection.right),
        );
        TostMessage.showToast(
          context,
          message: "Customer Updated Successfully",
          isSuccess: true,
        );
      }
      print('res : $response');
    } catch (e) {
      print(e);
    }
    print('supplier : $supplierUpdated');
  }

  void getSupplier() async {
    String supplierId = widget.data['id'];
    try {
      final response = await Getsupplierbyid.getSupplierById(supplierId);
      setState(() {
        usernameController.text = response['name'];
        emailController.text = response['email'];
        addressController.text = response['address'];
      });
    } catch (e) {
      print(e);
    }
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
                      page: SupplierList(),
                      direction: SlideDirection.left,
                    ),
                  );
                },
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ],
          ),
          title: Text(
            'Edit Supplier',
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
                      Headercomponent(title: "Update Supplier"),
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
                              hintitle: "Write Supplier Name",
                              islabel: true,
                              label: "Supplier Name",
                              spcae: 12,
                              controller: usernameController,
                            ),

                            InputComponent(
                              hintitle: "Write Supplier Email",
                              islabel: true,
                              label: "Supplier Email",
                              spcae: 12,
                              controller: emailController,
                            ),

                            PhoneInputWidget(
                              label: "Write Supplier Phone Number",
                              insialNumber: phoneNumber,
                              phonecontrollerl: phonecontroller,
                              data: (e) {
                                setState(() {
                                  phoneNumber = e;
                                });
                              },
                            ),
                            InputComponent(
                              hintitle: "Write Supplier Address",
                              islabel: true,
                              label: "Supplier Address",
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
                                    title: "Update",
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

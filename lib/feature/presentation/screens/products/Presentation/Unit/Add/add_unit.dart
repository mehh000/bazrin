import 'package:bazrin/feature/data/API/Helper/Expense/addExpenseProduct.dart';
import 'package:bazrin/feature/data/API/Helper/Product/Brand/addBrand.dart';
import 'package:bazrin/feature/data/API/Helper/Product/Unit/addUnit.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class AddUnit extends StatefulWidget {
  const AddUnit({super.key});

  @override
  State<AddUnit> createState() => _AddUnitState();
}

class _AddUnitState extends State<AddUnit> {
  TextEditingController nameController = TextEditingController();
  String status = '';

  void add() async {
    if (nameController.text.isEmpty) {
      TostMessage.showToast(
        context,
        message: 'Unit Name Is Required',
        isSuccess: false,
      );
      return;
    } else if (status.isEmpty) {
      TostMessage.showToast(
        context,
        message: 'Unit Status Is Required',
        isSuccess: false,
      );
      return;
    }
    dynamic data = {"name": nameController.text, "status": status};
    try {
      final response = await Addunit.AddUnit(data);
      if (response == 'success') {
        Navigator.of(context).push(
          SlidePageRoute(page: UnitList(), direction: SlideDirection.left),
        );
        TostMessage.showToast(
          context,
          message: 'Unit Added successfully',
          isSuccess: true,
        );
      } else {
        TostMessage.showToast(
          context,
          message: (response as Map).values.first.toString(),
          isSuccess: false,
        );
      }
      // print('p : $response');
    } catch (e) {
      // print(e);
    }
    // print('ex pro : $data');
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
                      page: ExpenseProductList(),
                      direction: SlideDirection.left,
                    ),
                  );
                },
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ],
          ),
          title: Text(
            'Add Unit',
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
                    Headercomponent(title: "Add Unit"),
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
                        spacing: 12,
                        children: [
                          InputComponent(
                            hintitle: 'Unit Name',
                            islabel: true,
                            label: "Unit Name",
                            spcae: 12,
                            required: true,
                            controller: nameController,
                          ),

                          StatusDropdown(
                            required: true,
                            label: "Unit Status",
                            selectedStatus: (e) {
                              setState(() {
                                status = e;
                              });
                            },
                          ),

                          SizedBox(height: 30),

                          Row(
                            spacing: 15,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: ButtonEv(
                                  title: 'Cancle',
                                  textColor: AppColors.colorRed,
                                  isBorder: true,
                                  borderColor: AppColors.colorRed,
                                ),
                              ),
                              Expanded(
                                child: ButtonEv(
                                  title: 'Add Unit',
                                  colorData: AppColors.Colorprimary,
                                  buttonFunction: add,
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
    );
  }
}

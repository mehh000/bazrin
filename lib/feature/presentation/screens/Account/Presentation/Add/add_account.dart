import 'package:bazrin/feature/data/API/Helper/Accounts/addAccount.dart';
import 'package:bazrin/feature/data/API/Helper/Expense/addExpenseCaregory.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({super.key});

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  TextEditingController nameController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountnumberController = TextEditingController();
  String accountType = '';
  String status = '';

  void add() async {
    if (nameController.text.isEmpty) {
      TostMessage.showToast(
        context,
        message: 'Account Name Is Required',
        isSuccess: false,
      );
      return;
    } else if (status.isEmpty) {
      TostMessage.showToast(
        context,
        message: 'Account Status Is Required',
        isSuccess: false,
      );
      return;
    } else if (accountnumberController.text.isEmpty) {
      TostMessage.showToast(
        context,
        message: 'Account Number Is Required',
        isSuccess: false,
      );
      return;
    } else if (bankNameController.text.isEmpty) {
      TostMessage.showToast(
        context,
        message: 'Bank/Provider Is Required',
        isSuccess: false,
      );
      return;
    } else if (accountType.isEmpty) {
      TostMessage.showToast(
        context,
        message: 'Account Type Is Required',
        isSuccess: false,
      );
      return;
    }
    dynamic data = {
      "type": accountType,
      "institutionName": bankNameController.text,
      "accountNumber": accountnumberController.text,
      "accountName": nameController.text,
      "status": status,
    };
    try {
      final response = await Addaccount.AddAccount(data);
      if (response == 'success') {
        Navigator.of(context).push(
          SlidePageRoute(
            page: ExpenseCategoryList(),
            direction: SlideDirection.left,
          ),
        );
        TostMessage.showToast(
          context,
          message: 'Expense Product Added successfully',
          isSuccess: true,
        );
      } else {
        TostMessage.showToast(
          context,
          message: (response as Map).values.first.toString(),
          isSuccess: false,
        );
      }
      // print("cat Res : $response");
    } catch (e) {
      // print('cat error $e');
    }
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
                      page: ExpenseList(),
                      direction: SlideDirection.left,
                    ),
                  );
                },
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ],
          ),
          title: Text(
            'Add Account',
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
                    Headercomponent(title: 'Add Account'),
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
                          StatusDropdown(
                            required: true,
                            data: ['CARD', 'BANK', 'Mfs'],
                            label: "Account Type",
                            selectedStatus: (e) {
                              setState(() {
                                accountType = e;
                              });
                            },
                          ),
                          InputComponent(
                            hintitle: 'Account Name',
                            islabel: true,
                            label: "Account Name",
                            spcae: 12,
                            required: true,
                            controller: nameController,
                          ),
                          InputComponent(
                            hintitle: 'Bank/Provider Name',
                            islabel: true,
                            label: "Bank/Provider Name",
                            spcae: 12,
                            required: true,
                            controller: bankNameController,
                          ),
                          InputComponent(
                            hintitle: 'Account Number',
                            islabel: true,
                            label: "Account Number",
                            spcae: 12,
                            required: true,
                            controller: accountnumberController,
                          ),
                          StatusDropdown(
                            required: true,
                            label: "Select Account Status",
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
                                  title: 'Add',
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

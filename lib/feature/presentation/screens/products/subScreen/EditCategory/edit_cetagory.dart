import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/widgets/buttonEv.dart';
import 'package:bazrin/feature/presentation/common/widgets/iconEvButton.dart';
import 'package:bazrin/feature/presentation/screens/products/subScreen/CategoryList/cetagory_list.dart';
import 'package:bazrin/feature/presentation/screens/products/widgets/sub_category.dart';

class EditCetagory extends StatefulWidget {
  const EditCetagory({super.key});

  @override
  State<EditCetagory> createState() => _EditCetagoryState();
}

class _EditCetagoryState extends State<EditCetagory> {
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
                      page: CetagoryList(),
                      direction: SlideDirection.left,
                    ),
                  );
                },
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ],
          ),
          title: Text(
            'Edit Category',
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20,
              children: [
                // edit component start here

                //=== Update Category ==
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
                      Headercomponent(title: "Update Category"),
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
                              hintitle: 'Select Category',
                              spcae: 10,
                              isIcon: true,
                              islabel: true,
                              label: "Parent Category",
                            ),

                            InputComponent(
                              hintitle: 'Sports',
                              spcae: 10,

                              islabel: true,
                              label: "Category Name ",
                            ),

                            InputComponent(
                              hintitle: 'Active ',
                              spcae: 10,
                              isIcon: true,
                              islabel: true,
                              label: "Category Status",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ), //
                //=== Sub Category ==
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
                      Headercomponent(title: "Sub Category"),
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
                          crossAxisAlignment: CrossAxisAlignment.end,
                          spacing: 15,
                          children: [
                            InputComponent(
                              hintitle: ' Category Name',
                              spcae: 10,
                              isIcon: true,
                              islabel: true,
                              label: "Category Name",
                            ),

                            InputComponent(
                              hintitle: 'Active ',
                              spcae: 10,
                              isIcon: true,
                              islabel: true,
                              label: "Category Status",
                            ),

                            SizedBox(
                              width: 100,
                              child: Iconevbutton(
                                title: "Add",
                                colorData: AppColors.Colorprimary,
                                iconName: Icons.check_circle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ), //

                Text(
                  'Sub Category List',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),

                //  ====  Sub cate Card List =====
                SubCategory(),
                SubCategory(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 15,
                  children: [
                    ButtonEv(
                      title: 'Cancel',
                      isBorder: true,
                      borderColor: AppColors.colorRed,
                      textColor: AppColors.colorRed,
                    ),
                    ButtonEv(
                      title: 'Update Category',
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

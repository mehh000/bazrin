import 'package:bazrin/feature/data/API/Helper/Pos/deletePosSalebyId.dart';
import 'package:bazrin/feature/data/API/Helper/Pos/getPosSale.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/classes/prettyPrint.dart';
import 'package:bazrin/feature/presentation/screens/Sale/sub_screens/ManageSales/Main/Components/manage_sell_card.dart';
import 'package:flutter/widgets.dart';

class ManageSales extends StatefulWidget {
  const ManageSales({super.key});

  @override
  State<ManageSales> createState() => _ManageSalesState();
}

class _ManageSalesState extends State<ManageSales> {
  dynamic sales;
  bool isloading = false;
  @override
  void initState() {
    super.initState();
    getSales();
  }

  Future<void> getSales() async {
    setState(() {
      isloading = true;
    });

    final response = await Getpossale.getPosSale();
    setState(() {
      sales = response;
      isloading = false;
    });
  }

  void delete(id) async {
    final resposne = await Deletepossalebyid.deletePosSalebyId(id);
    if (resposne == 'success') {
      TostMessage.showToast(
        context,
        message: "Order Delete Successfully done",
        isSuccess: true,
      );
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
            'Manage Sales',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: AppColors.Colorprimary,
        body: Column(
          children: [
            // ======Header=========
            Container(
              color: AppColors.Colorprimary,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Row(
                spacing: 30,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hint: Text(
                          'Search',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.Colorprimary,
                          ),
                        ),
                        suffixIcon: Icon(
                          Icons.search,
                          size: 25,
                          color: AppColors.Colorprimary,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 13,
                          horizontal: 11,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 14, // match your design
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        SlidePageRoute(
                          page: Filter(),
                          direction: SlideDirection.right,
                        ),
                      );
                    },
                    child: SvgPicture.asset(
                      'assets/images/icons/filter.svg',
                      height: 28,
                      width: 24,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            Expanded(
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
                child: isloading
                    ? Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () => getSales(),
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 6),
                          itemCount: sales.length ?? 0,
                          itemBuilder: (context, index) {
                            return ManageSellCard(
                              sale: sales[index],
                              delfuntion: (id) {
                                delete(id);
                              },
                            );
                          },
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

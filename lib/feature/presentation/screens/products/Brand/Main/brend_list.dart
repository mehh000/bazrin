import 'package:bazrin/feature/data/API/Helper/Product/Brand/deleteBrandbyId.dart';
import 'package:bazrin/feature/data/API/Helper/Product/Brand/getBrandList.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/classes/prettyPrint.dart';
import 'package:bazrin/feature/presentation/screens/products/Brand/Add/add_brand.dart';
import 'package:bazrin/feature/presentation/screens/products/Brand/Main/widget/brandCard.dart';

class BrendList extends StatefulWidget {
  const BrendList({super.key});

  @override
  State<BrendList> createState() => _BrendListState();
}

class _BrendListState extends State<BrendList> {
  dynamic brands;
  bool islaoding = false;
  bool _isExpanded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBrands();
  }

  void _toggleExpand() {
    if (_isExpanded) {
      Navigator.of(
        context,
      ).push(SlidePageRoute(page: AddBrand(), direction: SlideDirection.right));
    } else {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }
  }

  Future<void> getBrands() async {
    setState(() {
      islaoding = true;
    });
    final response = await Getbrandlist.getBrandList();
    setState(() {
      brands = response;
      islaoding = false;
    });
  }

  void delete(id) async {
    final response = await Deletebrandbyid.deleteBrandbyId(id);
    if (response == 'success') {
      TostMessage.showToast(
        context,
        message: 'Brtand Deleted Successfully',
        isSuccess: true,
      );
      getBrands();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FlowtingIconButton(
          isExpanded: _isExpanded,
          toggleExpand: _toggleExpand,
          title: 'Add Brand',
        ),
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
        body: Stack(
          children: [
            Column(
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
                    child: islaoding
                        ? Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: getBrands,
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 8),
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: brands.length,
                              itemBuilder: (context, index) {
                                return Brandcard(
                                  brand: brands[index],
                                  delete: (id) {
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

            if (_isExpanded)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => setState(() => _isExpanded = false),
                  child: Container(color: Colors.transparent),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

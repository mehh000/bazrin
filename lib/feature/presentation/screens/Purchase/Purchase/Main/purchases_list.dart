import 'package:bazrin/feature/data/API/Helper/Purchase/deletePurchaseById.dart';
import 'package:bazrin/feature/data/API/Helper/Purchase/getPurchase.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/screens/Purchase/widgets/purchase.dart';

class PurchasesList extends StatefulWidget {
  const PurchasesList({super.key});

  @override
  State<PurchasesList> createState() => _PurchasesListState();
}

class _PurchasesListState extends State<PurchasesList> {
  dynamic purchaseList = [];
  bool _isExpanded = false;
  bool isLoaded = true;
  @override
  void initState() {
    super.initState();
    getPurchases();
  }

  void _toggleExpand() {
    if (_isExpanded) {
      Navigator.of(context).push(
        SlidePageRoute(page: AddPurchase(), direction: SlideDirection.right),
      );
    } else {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }
  }

  Future<void> getPurchases() async {
    final response = await Getpurchase.getPurchaseList();
    setState(() {
      purchaseList = response;
      isLoaded = true;
    });
  }

  void delete(id) async {
    final response = await Deletepurchasebyid.DeletePurchase(id);
    if (response == 'success') {
      getPurchases();
      TostMessage.showToast(
        context,
        message: "Customer deleted successfully",
        isSuccess: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FlowtingIconButton(
          isExpanded: _isExpanded,
          toggleExpand: _toggleExpand,
          title: 'Add Purchase',
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
            'Purchase List',
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
                    child: RefreshIndicator(
                      onRefresh: () => getPurchases(),
                      child: ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: purchaseList.length,

                        itemBuilder: (context, index) {
                          final purchase = purchaseList[index];
                          return Purchase(purchase: purchase, delete: delete);
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

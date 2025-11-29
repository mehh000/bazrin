import 'package:bazrin/feature/data/API/Helper/Quotation/deleteQuotationById.dart';
import 'package:bazrin/feature/data/API/Helper/Quotation/getQuotationList.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/classes/prettyPrint.dart';
import 'package:bazrin/feature/presentation/screens/Quotation/Main/Components/QuotationCard.dart';
import 'package:flutter/widgets.dart';

class Quotation extends StatefulWidget {
  const Quotation({super.key});

  @override
  State<Quotation> createState() => _QuotationState();
}

class _QuotationState extends State<Quotation> {
  dynamic quotationList;
  bool isloading = false;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    getquotations();
  }

  void _toggleExpand() {
    if (_isExpanded) {
      Navigator.of(context).push(
        SlidePageRoute(page: AddQuation(), direction: SlideDirection.right),
      );
    } else {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }
  }

  Future<void> getquotations() async {
    setState(() {
      isloading = true;
    });
    final response = await Getquotationlist.getQuotationList();
    setState(() {
      quotationList = response;
      isloading = false;
    });
  }

  void delete(id) async {
    final resposne = await Deletequotationsbyid.DeleteQuotations(id);
    if (resposne == 'success') {
      getquotations();
      TostMessage.showToast(
        context,
        message: "Quotation deleted successfully",
        isSuccess: false,
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
          title: 'Add Quotation',
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
            'Manage Quotation',
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
                    child: isloading
                        ? Center(
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () => getquotations(),
                            child: ListView.separated(
                              itemCount: quotationList.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 6),
                              itemBuilder: (context, index) {
                                return Quotationcard(
                                  quotation: quotationList[index],
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

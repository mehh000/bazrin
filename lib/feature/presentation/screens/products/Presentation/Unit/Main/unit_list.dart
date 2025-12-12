import 'package:bazrin/feature/data/API/Helper/Product/Unit/deleteUnitbyId.dart';
import 'package:bazrin/feature/data/API/Helper/Product/Unit/getUnitList.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/screens/products/Presentation/Unit/Add/add_unit.dart';
import 'package:bazrin/feature/presentation/screens/products/Presentation/Unit/Main/widget/unitCard.dart';

class UnitList extends StatefulWidget {
  const UnitList({super.key});

  @override
  State<UnitList> createState() => _UnitListState();
}

class _UnitListState extends State<UnitList> {
  bool _isExpanded = false;
  bool islaoding = false;
  dynamic unitData;

  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;
  TextEditingController searchController = TextEditingController();
  int page = 0;
  bool isLoadingMore = false;
  bool noMoreData = false;
  bool isloading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });

    getUnits();
  }

  void _toggleExpand() {
    if (_isExpanded) {
      Navigator.of(
        context,
      ).push(SlidePageRoute(page: AddUnit(), direction: SlideDirection.right));
    } else {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }
  }

  Future<void> getUnits() async {
    page = 0;
    noMoreData = false;
    final response = await Getunitlist.getUnitList(page, searchController.text);
    setState(() {
      unitData = response['data'];
    });
  }

  Future<void> loadMore() async {
    if (isLoadingMore || noMoreData) return;

    isLoadingMore = true;
    page++;

    final response = await Getunitlist.getUnitList(page);

    int totalPage = response["totalPage"];
    List<dynamic> newData = response["data"];

    if (newData.isEmpty || page >= totalPage) {
      noMoreData = true;
    }

    // Convert safely
    final List<Map<String, dynamic>> parsedNew =
        List<Map<String, dynamic>>.from(newData);

    setState(() {
      unitData.addAll(parsedNew);
    });

    isLoadingMore = false;
  }

  void delete(id) async {
    final response = await Deleteunitbyid.deleteUnitbyId(id);
    if (response == 'success') {
      TostMessage.showToast(
        context,
        message: 'Unit Deleted Successfully',
        isSuccess: true,
      );
      getUnits();
    }
  }

  void onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    setState(() {
      searchController.text = value;
    });

    _debounce = Timer(const Duration(milliseconds: 400), () {
      getUnits();
      ();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FlowtingIconButton(
          isExpanded: _isExpanded,
          toggleExpand: _toggleExpand,
          title: 'Add Unit',
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
            'Unit List',
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
                Container(
                  color: AppColors.Colorprimary,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  child: Expanded(
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) => onSearchChanged(value),
                      decoration: InputDecoration(
                        hint: Text(
                          'Search with Unit Name',
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
                ),
                SizedBox(height: 20),

                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F7),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: unitData != null
                        ? RefreshIndicator(
                            onRefresh: getUnits,
                            child: ListView.separated(
                              controller: _scrollController,
                              physics: AlwaysScrollableScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 6),
                              itemCount: unitData.length,
                              itemBuilder: (context, index) {
                                return Unitcard(
                                  unit: unitData[index],
                                  delete: (id) {
                                    delete(id);
                                  },
                                );
                              },
                            ),
                          )
                        : Center(
                            child: Text(
                              'No Unit Found',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
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

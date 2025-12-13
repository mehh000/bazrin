import 'package:bazrin/feature/data/API/Helper/Customer/deleteCustomer.dart';
import 'package:bazrin/feature/data/API/Helper/Customer/getCustomers.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/Components/CustomIndicator.dart';
import 'package:bazrin/feature/presentation/screens/Customers/Presentation/Customer/Add/add_customer.dart';
import 'package:bazrin/feature/presentation/screens/Customers/Components/customer.dart';

class CustomarList extends StatefulWidget {
  const CustomarList({super.key});

  @override
  State<CustomarList> createState() => _CustomarListState();
}

class _CustomarListState extends State<CustomarList> {
  bool _isExpanded = false;
  dynamic customers = [];
  bool isloaded = true;
  Timer? _debounce;

  final ScrollController _scrollController = ScrollController();
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
    getCustomerList();
  }

  void _toggleExpand() {
    if (_isExpanded) {
      Navigator.of(context).push(
        SlidePageRoute(page: AddCustomer(), direction: SlideDirection.right),
      );
    } else {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }
  }

  Future<void> getCustomerList() async {
    page = 0;
    noMoreData = false;
    final response = await Getcustomers.getCustomersList(
      page,
      searchController.text,
    );
    setState(() {
      customers = response["data"];
      isloaded = false;
    });
    // print('res $response');
  }

  Future<void> loadMore() async {
    if (isLoadingMore || noMoreData) return;

    isLoadingMore = true;
    page++;

    final response = await Getcustomers.getCustomersList(page);

    int totalPage = response["totalPage"];
    List<dynamic> newData = response["data"];

    if (newData.isEmpty || page >= totalPage) {
      noMoreData = true;
    }

    // Convert safely
    final List<Map<String, dynamic>> parsedNew =
        List<Map<String, dynamic>>.from(newData);

    setState(() {
      customers.addAll(parsedNew);
    });

    isLoadingMore = false;
  }

  Future<void> onRefrash() async {
    await getCustomerList();
  }

  void delete(id) async {
    final response = await DeleteCustomer.DeleteCustomerByID(id);
    if (response == 'success') {
      getCustomerList();
      TostMessage.showToast(
        context,
        message: "Customer deleted successfully",
        isSuccess: false,
      );
    }
  }

  void onSearchChanged(String text) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    setState(() {
      searchController.text = text;
    });

    _debounce = Timer(const Duration(milliseconds: 400), () {
      getCustomerList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FlowtingIconButton(
          isExpanded: _isExpanded,
          toggleExpand: _toggleExpand,
          title: 'Add Customer',
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
            'Customer List',
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
                  child: Expanded(
                    child: TextField(
                      onChanged: (value) => onSearchChanged(value),
                      controller: searchController,
                      decoration: InputDecoration(
                        hint: Text(
                          'Search With Customer Name',
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
                      onRefresh: onRefrash,
                      child: isloaded
                          ? Customindicator()
                          : ListView.separated(
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: _scrollController,
                              padding: const EdgeInsets.only(bottom: 80),
                              itemCount:
                                  (customers?.length ?? 0) +
                                  1, // +1 for load more
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 5),
                              itemBuilder: (context, index) {
                                if (index == (customers?.length ?? 0)) {
                                  return isLoadingMore
                                      ? const Padding(
                                          padding: EdgeInsets.all(16),
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        )
                                      : const SizedBox.shrink();
                                }

                                final cus = customers![index];
                                return Customer(
                                  cus: cus,
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

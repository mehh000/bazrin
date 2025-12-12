import 'package:bazrin/feature/data/API/Helper/Accounts/deleteAccount.dart';
import 'package:bazrin/feature/data/API/Helper/Accounts/getaccountList.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/screens/Account/Components/accountCard.dart';
import 'package:bazrin/feature/presentation/screens/Account/Presentation/Add/add_account.dart';
import 'package:flutter/widgets.dart';

class AccountsList extends StatefulWidget {
  const AccountsList({super.key});

  @override
  State<AccountsList> createState() => _AccountsListState();
}

class _AccountsListState extends State<AccountsList> {
  List<Map<String, dynamic>> accountList = [];
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;
  TextEditingController searchController = TextEditingController();
  int page = 0;
  bool isLoadingMore = false;
  bool noMoreData = false;
  bool isloading = false;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
    getacconts();
  }

  Future<void> getacconts() async {
    page = 0;
    noMoreData = false;
    try {
      final response = await Getaccountlist.getAccountsList(
        page,
        searchController.text,
      );

      // Safely cast and convert
      final List<Map<String, dynamic>> parsedList = (response['data'] as List)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();

      setState(() {
        accountList = parsedList;
      });

      // print('accounts data : $accountList');
    } catch (e) {
      // print('Error loading categories: $e');
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore || noMoreData) return;

    isLoadingMore = true;
    page++;

    final response = await Getaccountlist.getAccountsList(page);

    int totalPage = response["totalPage"];
    List<dynamic> newData = response["data"];

    if (newData.isEmpty || page >= totalPage) {
      noMoreData = true;
    }

    // Convert safely
    final List<Map<String, dynamic>> parsedNew =
        List<Map<String, dynamic>>.from(newData);

    setState(() {
      accountList.addAll(parsedNew);
    });

    isLoadingMore = false;
  }

  void delete(id) async {
    final response = await Deleteaccount.DeleteAccountByID(id);
    if (response == 'success') {
      getacconts();
      TostMessage.showToast(
        context,
        message: "Account deleted successfully",
        isSuccess: false,
      );
    }
  }

  void _toggleExpand() {
    if (_isExpanded) {
      Navigator.of(context).push(
        SlidePageRoute(page: AddAccount(), direction: SlideDirection.right),
      );
    } else {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }
  }

  void onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    setState(() {
      searchController.text = value;
    });

    _debounce = Timer(const Duration(milliseconds: 400), () {
      getacconts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FlowtingIconButton(
          isExpanded: _isExpanded,
          toggleExpand: _toggleExpand,
          title: 'Add Addcount',
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
            'Accounts List',
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
                          controller: searchController,
                          onChanged: (value) => onSearchChanged(value),
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
                      onRefresh: getacconts,
                      child: ListView.separated(
                        controller: _scrollController, // if you use pagination
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: accountList.length + 1,
                        separatorBuilder: (_, __) => const SizedBox(height: 5),
                        itemBuilder: (context, index) {
                          if (index == accountList.length) {
                            return isLoadingMore
                                ? const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : const SizedBox.shrink();
                          }

                          final acc = accountList[index];
                          return Accountcard(
                            account: acc,
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

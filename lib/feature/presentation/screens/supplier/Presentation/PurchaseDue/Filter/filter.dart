import 'package:bazrin/feature/data/API/Helper/Accounts/getaccountList.dart';
import 'package:bazrin/feature/data/API/Helper/Supplier/getSuppliers.dart';
import 'package:bazrin/feature/presentation/common/Components/customdropdown.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/classes/prettyPrint.dart';

class PurchaseDueFilter extends StatefulWidget {
  final Function filterSubmit;
  const PurchaseDueFilter({super.key, required this.filterSubmit});

  @override
  State<PurchaseDueFilter> createState() => _PurchaseDueFilterState();
}

class _PurchaseDueFilterState extends State<PurchaseDueFilter> {
  List<Map<String, dynamic>> accountList = [];
  List<Map<String, dynamic>> suppliers = [];
  final ScrollController accountScroll = ScrollController();
  final ScrollController supplierScroll = ScrollController();
  TextEditingController invoiceNumber = TextEditingController();

  int accountPage = 0;
  int supplierPage = 0;

  bool isLoadingMoreForAccount = false;
  bool isLoadingMoreForSupplier = false;
  bool noMoreDataForAccount = false;
  bool noMoreDataForSupplier = false;
  bool isloading = false;

  dynamic selectedAccount = {};
  dynamic selectedSupplier = {};

  @override
  void initState() {
    super.initState();
    accountScroll.addListener(() {
      if (accountScroll.position.pixels ==
          accountScroll.position.maxScrollExtent) {
        loadMore();
      }
    });
    supplierScroll.addListener(() {
      if (supplierScroll.position.pixels ==
          supplierScroll.position.maxScrollExtent) {
        loadMoreSupplier();
      }
    });
    getSupplie();
    getacconts();
  }

  TextEditingController searchController = TextEditingController();

  Future<void> getacconts() async {
    accountPage = 0;
    noMoreDataForAccount = false;
    try {
      final response = await Getaccountlist.getAccountsList(accountPage);

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
    if (isLoadingMoreForAccount || noMoreDataForAccount) return;

    isLoadingMoreForAccount = true;
    accountPage++;

    final response = await Getaccountlist.getAccountsList(accountPage);

    int totalPage = response["totalPage"];
    List<dynamic> newData = response["data"];

    if (newData.isEmpty || accountPage >= totalPage) {
      noMoreDataForAccount = true;
    }

    // Convert safely
    final List<Map<String, dynamic>> parsedNew =
        List<Map<String, dynamic>>.from(newData);

    setState(() {
      accountList.addAll(parsedNew);
    });
    print('Account scroll triggered');

    isLoadingMoreForAccount = false;
  }

  void getSupplie() async {
    supplierPage = 0;
    noMoreDataForSupplier = false;
    setState(() => isloading = true);

    final res = await Getsuppliers.getSuppliersList(supplierPage);

    // FIX: force convert dynamic list → List<Map<String, dynamic>>
    final List<Map<String, dynamic>> parsedSuppliers =
        List<Map<String, dynamic>>.from(res['data'] ?? []);

    setState(() {
      suppliers = [...suppliers, ...parsedSuppliers];
      isloading = false;
    });
  }

  Future<void> loadMoreSupplier() async {
    if (isLoadingMoreForSupplier || noMoreDataForSupplier) return;

    isLoadingMoreForSupplier = true;
    supplierPage++;

    final response = await Getsuppliers.getSuppliersList(supplierPage);

    int totalPage = response["totalPage"];
    List<dynamic> newData = response["data"];

    if (newData.isEmpty || supplierPage >= totalPage) {
      noMoreDataForSupplier = true;
    }

    // Convert safely
    final List<Map<String, dynamic>> parsedNew =
        List<Map<String, dynamic>>.from(newData);

    setState(() {
      suppliers = [...suppliers, ...parsedNew];
    });

    print('supplier scroll triggered $parsedNew');

    isLoadingMoreForSupplier = false;
  }

  void submitFilter() {
    dynamic filterData = {
      "invoiceNumber": invoiceNumber.text,
      "account": selectedAccount,
      "supplier": selectedSupplier,
    };
    widget.filterSubmit(filterData);
    Navigator.of(context).pop();
    // PrettyPrint.print(filterData);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      // padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F7),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Headercomponent(title: 'Filter'),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 13,
                  children: [
                    SizedBox(height: 20),
                    InputComponent(
                      preicon: true,
                      hintitle: 'Search invoice number',
                      islabel: true,
                      label: "Invoice Number",
                      spcae: 12,
                      controller: invoiceNumber,
                    ),
                    Text(
                      'Account',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.colorBlack,
                      ),
                    ),
                    SearchDropdown(
                      items: accountList,
                      getter: "type",
                      hint: "search Account",
                      onChanged: (e) {
                        setState(() {
                          selectedAccount = e;
                        });
                        // PrettyPrint.print(e);
                      },
                      scrollController: accountScroll,
                    ),
                    Text(
                      'Supplier',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.colorBlack,
                      ),
                    ),
                    SearchDropdown(
                      items: isloading ? [] : suppliers,
                      hint: "search Supplier",
                      onChanged: (e) {
                        selectedSupplier = e;
                      },
                      scrollController: supplierScroll,
                    ),
                  ],
                ),
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            width: double.infinity,
            child: Row(
              spacing: 20,
              children: [
                Expanded(
                  child: ButtonEv(
                    title: "Clear",
                    isBorder: true,
                    textColor: Colors.red,
                    borderColor: Colors.red,
                  ),
                ),

                Expanded(
                  child: ButtonEv(
                    title: "Filter",
                    colorData: AppColors.Colorprimary,
                    buttonFunction: submitFilter,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

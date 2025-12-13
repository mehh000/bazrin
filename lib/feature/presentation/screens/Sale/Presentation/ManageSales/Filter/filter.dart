import 'package:bazrin/feature/data/API/Helper/Customer/getCustomers.dart';
import 'package:bazrin/feature/presentation/common/Components/customdropdown.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:intl/intl.dart';

class ManageSalesFilter extends StatefulWidget {
  final Function filterSubmit;
  const ManageSalesFilter({super.key, required this.filterSubmit});

  @override
  State<ManageSalesFilter> createState() => _ManageSalesFilterState();
}

class _ManageSalesFilterState extends State<ManageSalesFilter> {
  List<Map<String, dynamic>> customer = [];

  final ScrollController customercroll = ScrollController();
  TextEditingController invoiceNumber = TextEditingController();

  TextEditingController searchController = TextEditingController();

  int customerPage = 0;

  bool isLoadingMoreForCustomer = false;

  bool noMoreDataForCustomer = false;
  bool isloading = false;

  dynamic selectedCustomer = {};

  DateTime? staringDate;
  DateTime? endingDate;

  String selectedSaleType = '';

  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    customercroll.addListener(() {
      if (customercroll.position.pixels ==
          customercroll.position.maxScrollExtent) {
        loadMoreCustomer();
      }
    });
    getCustomer();
  }

  void getCustomer() async {
    customerPage = 0;
    noMoreDataForCustomer = false;
    setState(() => isloading = true);

    final res = await Getcustomers.getCustomersList(
      customerPage,
      searchController.text,
    );

    // FIX: force convert dynamic list → List<Map<String, dynamic>>
    final List<Map<String, dynamic>> parsedcustomer =
        List<Map<String, dynamic>>.from(res['data'] ?? []);

    setState(() {
      if (customerPage == 0) {
        customer = parsedcustomer;
      } else {
        customer = [...customer, ...parsedcustomer];
      }

      isloading = false;
    });
  }

  Future<void> loadMoreCustomer() async {
    if (isLoadingMoreForCustomer || noMoreDataForCustomer) return;

    isLoadingMoreForCustomer = true;
    customerPage++;

    final response = await Getcustomers.getCustomersList(customerPage);

    int totalPage = response["totalPage"];
    List<dynamic> newData = response["data"];

    if (newData.isEmpty || customerPage >= totalPage) {
      noMoreDataForCustomer = true;
    }

    // Convert safely
    final List<Map<String, dynamic>> parsedNew =
        List<Map<String, dynamic>>.from(newData);

    setState(() {
      customer = [...customer, ...parsedNew];
    });

    print('Customer scroll triggered $parsedNew');

    isLoadingMoreForCustomer = false;
  }

  void submitFilter() {
    dynamic filterData = {
      "Customer": selectedCustomer['id'],
      "startMonth": staringDate == null
          ? ''
          : DateFormat(
              'yyyy/MM/dd',
            ).format(DateTime.parse(staringDate.toString())),
      "endingMonth": endingDate == null
          ? ''
          : DateFormat(
              'yyyy/MM/dd',
            ).format(DateTime.parse(endingDate.toString())),
      "saleType": selectedSaleType,
    };
    widget.filterSubmit(filterData);
    Navigator.of(context).pop();
    // PrettyPrint.print(filterData);
  }

  void onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    setState(() {
      searchController.text = value;
    });

    _debounce = Timer(const Duration(milliseconds: 400), () {
      getCustomer();
    });
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: DatePicker(
                            onDateSelected: (date) {
                              setState(() {
                                staringDate = date;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.Colorprimary,
                          ),
                          child: Center(
                            child: Image.asset('assets/images/arrowupdown.png'),
                          ),
                        ),
                        Expanded(
                          child: DatePicker(
                            onDateSelected: (date) {
                              setState(() {
                                endingDate = date;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    StatusDropdown(
                      label: "Sale Type",
                      selectedStatus: (s) {
                        setState(() {
                          selectedSaleType = s;
                        });
                      },
                      data: ['REGULAR', 'INSTAllMent'],
                    ),

                    Text(
                      'Customer',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.colorBlack,
                      ),
                    ),
                    SearchDropdown(
                      textController: searchController,
                      searchOnchanged: (value) => onSearchChanged(value),
                      items: isloading ? [] : customer,
                      hint: "search Customer",
                      onChanged: (e) {
                        selectedCustomer = e;
                      },
                      scrollController: customercroll,
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

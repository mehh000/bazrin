import 'package:bazrin/feature/data/API/Helper/Profile/getmyprofile.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/classes/prettyPrint.dart';
import 'package:bazrin/feature/presentation/screens/Promotion/flash_sale_list.dart';
import 'package:bazrin/feature/presentation/screens/Supplier/Presentation/PurchaseDismiss/Main/purchase_dismiss_list.dart';
import 'package:bazrin/feature/presentation/screens/Supplier/Presentation/PurchaseDue/Main/supplier_purchase_due_list.dart';
import 'package:bazrin/feature/presentation/screens/Supplier/Presentation/ReturnDismiss/Main/return_dismiss_list.dart';
import 'package:bazrin/feature/presentation/screens/Supplier/Presentation/ReturnDuePaid/Main/return_due_list.dart';

class DrawerContainer extends StatefulWidget {
  final dynamic shop;
  const DrawerContainer({super.key, required this.shop});

  @override
  State<DrawerContainer> createState() => _DrawerContainerState();
}

class _DrawerContainerState extends State<DrawerContainer> {
  int? activeIndex;
  dynamic profile = {};
  bool isloaded = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  void getProfile() async {
    try {
      final response = await Getmyprofile.getMyProfile();
      setState(() {
        profile = response;
        isloaded = false;
      });
    } catch (e) {}
  }

  final List<Map<String, dynamic>> demoMenuData = [
    {
      'title': 'Dashboard',
      'icon': 'assets/images/icons/deshboard.svg',
      'path': HomeScreen,
    },
    {
      'title': 'Suppliers',
      'icon': 'assets/images/icons/suppliers.svg',
      'subItems': [
        {'title': 'Suppliers List', 'path': SupplierList()},
        {'title': 'Advance', 'path': AdvanceSupplier()},
        {'title': 'Purchase Due', 'path': SupplierPurchaseDueList()},
        {'title': 'Return Due', 'path': ReturnDueList()},
        {'title': 'Purchase Dismiss', 'path': PurchaseDismissList()},
        {'title': 'Return Dismiss', 'path': ReturnDismissList()},
      ],
    },
    {
      'title': 'Customers',
      'icon': 'assets/images/icons/customar.svg',
      'subItems': [
        {'title': 'Customers List', 'path': CustomarList()},
        {'title': 'Sale Due ', 'path': SaleDuePay()},
        {'title': 'Return Due ', 'path': ReturnDuePay()},
        {'title': 'Sale Dismiss ', 'path': SaleDueDismiss()},
        {'title': 'Return Dismiss ', 'path': ReturnDueDismiss()},
      ],
    },
    {
      'title': 'Products',
      'icon': 'assets/images/icons/product.svg',
      'subItems': [
        {'title': 'Products List', 'path': ProductsScreen()},
        // {'title': 'Cetagory List ', 'path': CetagoryList()},
        {'title': 'Brand List', 'path': BrendList()},
        {'title': 'Unit List', 'path': UnitList()},
      ],
    },
    {
      'title': 'Purchases',
      'icon': 'assets/images/icons/purchases.svg',
      'subItems': [
        {'title': ' Purchase List', 'path': PurchasesList()},
        {'title': 'Purchase Return', 'path': PurchaseReturn()},
        {'title': 'Purchase Return Types', 'path': PurchaseReturnTypes()},
      ],
    },
    {
      'title': 'Sales',
      'icon': 'assets/images/icons/sales.svg',
      'subItems': [
        {'title': 'Pos', 'path': Pos()},
        {'title': 'Manage Sales', 'path': ManageSales()},
        {'title': 'Online Orders', 'path': OnlineOrders()},
        {'title': 'Sales Return', 'path': SalesReturn()},
        {'title': 'Sale Return Types', 'path': SaleReturnTypes()},
      ],
    },
    {
      'title': 'Quotation',
      'icon': 'assets/images/icons/quotation.svg',
      'subItems': [
        {'title': 'Manage  Quotation', 'path': Quotation()},
        {'title': 'Add Quotation', 'path': AddQuation()},
      ],
    },
    // {
    //   'title': 'Inventory',
    //   'icon': 'assets/images/icons/account.svg',
    //   'subItems': [
    //     {'title': 'Available Stocks', 'path': AvailableStocks()},
    //     {'title': 'Stocks Movemenrt', 'path': StocksMovement()},
    //     {'title': 'Stocks Adjustment', 'path': StocksAdjustment()},
    //     {'title': 'Stocks Adjustment Types', 'path': ''},
    //   ],
    // },
    {
      'title': 'Account',
      'icon': 'assets/images/icons/account.svg',
      'subItems': [
        {'title': 'Accounts List', 'path': AccountsList()},
      ],
    },
    {
      'title': 'Expense',
      'icon': 'assets/images/icons/expense.svg',
      'subItems': [
        {'title': 'Expense List', 'path': ExpenseList()},
        {'title': 'Expense Products', 'path': ExpenseProductList()},
        {'title': 'Expense Categoris', 'path': ExpenseCategoryList()},
      ],
    },
    // {
    //   'title': 'Role',
    //   'icon': 'assets/images/icons/role.svg',
    //   'subItems': [
    //     {'title': 'Role List', 'path': RoleList()},
    //   ],
    // },
    // {
    //   'title': 'Staff',
    //   'icon': 'assets/images/icons/staff.svg',
    //   'subItems': [
    //     {'title': 'Staff List', 'path': StaffList()},
    //     {'title': 'Invitation List', 'path': InvitationList()},
    //   ],
    // },
    // {
    //   'title': 'Promotion',
    //   'icon': 'assets/images/icons/promotion.svg',
    //   'subItems': [
    //     {'title': 'Flash Sale List', 'path': FlashSaleList()},
    //   ],
    // },
    // {
    //   'title': 'Settings',
    //   'icon': 'assets/images/icons/settings.svg',
    //   'subItems': [
    //     {'title': 'Store Settings', 'path': StoreSettings()},
    //     {'title': 'Invoice Settings', 'path': InvoiceSetting()},
    //     {'title': 'Packaging ', 'path': Packaging()},
    //     {'title': 'Point System', 'path': PointSystem()},
    //     {'title': 'Vat Setting', 'path': VatSetting()},
    //   ],
    // },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFF1CAF6F))),
            ),
            child: Skeletonizer(
              enabled: isloaded,
              child: Row(
                children: [
                  ClipOval(
                    child: Container(
                      color: Colors.blue.shade50,
                      width: 60,
                      height: 60,
                      child:
                          (profile?['setting']?['appearance']?['logo']?['md'] !=
                              null)
                          ? Image.network(
                              'https://bazrin.com/${profile?['setting']?['appearance']?['logo']?['lg']}',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                    Icons.store,
                                    size: 30,
                                    color: Colors.grey,
                                  ),
                            )
                          : const Icon(
                              Icons.store,
                              size: 30,
                              color: Colors.grey,
                            ),
                    ),
                  ),

                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      profile != null && profile['name'] != null
                          ? Text(
                              profile['name'].length > 10
                                  ? profile['name'].substring(0, 11)
                                  : profile['name'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : const Text(
                              '',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),

                      Text(
                        'User Id- ${profile?['userId'] ?? '0000'}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ...List.generate(demoMenuData.length, (index) {
            final item = demoMenuData[index];
            final isActive = activeIndex == index;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    if (item['title'] == 'Dashboard') {
                      Navigator.of(context).pop();
                      return;
                    }

                    setState(() {
                      activeIndex = activeIndex == index ? null : index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 4,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isActive ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        isActive
                            ? SizedBox(width: 24)
                            : SvgPicture.asset(
                                item['icon'],
                                width: 24,
                                height: 24,
                                color: isActive
                                    ? AppColors.Colorprimary
                                    : Colors.white,
                              ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            item['title'],
                            style: TextStyle(
                              color: isActive
                                  ? AppColors.Colorprimary
                                  : Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        item['title'] == 'Dashboard'
                            ? SizedBox()
                            : Icon(
                                isActive
                                    ? Icons.keyboard_arrow_down
                                    : Icons.arrow_forward_ios,
                                size: 16,
                                color: isActive
                                    ? AppColors.Colorprimary
                                    : Colors.white,
                              ),
                      ],
                    ),
                  ),
                ),
                if (isActive)
                  Column(
                    children: (item['subItems'] as List)
                        .map(
                          (sub) => GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                SlidePageRoute(
                                  page: sub['path'],
                                  direction: SlideDirection.right,
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 80,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  sub['title'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

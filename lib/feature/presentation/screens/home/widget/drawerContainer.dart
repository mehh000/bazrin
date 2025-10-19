import 'package:bazrin/feature/presentation/common/classes/SlidePageRoute.dart';
import 'package:bazrin/feature/presentation/common/classes/colors.dart';
import 'package:bazrin/feature/presentation/screens/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerContainer extends StatefulWidget {
  const DrawerContainer({super.key});

  @override
  State<DrawerContainer> createState() => _DrawerContainerState();
}

class _DrawerContainerState extends State<DrawerContainer> {
  int? activeIndex;

  final List<Map<String, dynamic>> demoMenuData = [
    {'title': 'Dashboard', 'icon': 'assets/images/icons/deshboard.svg'},
    {
      'title': 'Suppliers',
      'icon': 'assets/images/icons/suppliers.svg',
      'subItems': [
        {'title': 'All Suppliers', 'path': ''},
        {'title': 'Add Supplier', 'path': ''},
        {'title': 'Supplier Groups', 'path': ''},
      ],
    },
    {
      'title': 'Customers',
      'icon': 'assets/images/icons/customar.svg',
      'subItems': [
        {'title': 'All Customers', 'path': ''},
        {'title': 'Add Customer', 'path': ''},
        {'title': 'Customer Groups', 'path': ''},
      ],
    },
    {
      'title': 'Products',
      'icon': 'assets/images/icons/product.svg',
      'subItems': [
        {'title': 'Products List', 'path': ProductsScreen()},
        {'title': 'Add Product', 'path': ''},
        {'title': 'Stock', 'path': ''},
      ],
    },
    {
      'title': 'Purchases',
      'icon': 'assets/images/icons/purchases.svg',
      'subItems': [
        {'title': 'New Purchase', 'path': ''},
        {'title': 'Pending Orders', 'path': ''},
        {'title': 'Purchase History', 'path': ''},
      ],
    },
    {
      'title': 'Sales',
      'icon': 'assets/images/icons/sales.svg',
      'subItems': [
        {'title': 'Daily Sales', 'path': ''},
        {'title': 'Monthly Sales', 'path': ''},
        {'title': 'Sales Report', 'path': ''},
      ],
    },
    {
      'title': 'Quotation',
      'icon': 'assets/images/icons/quotation.svg',
      'subItems': [
        {'title': 'New Quote', 'path': ''},
        {'title': 'Pending Quotes', 'path': ''},
        {'title': 'Approved', 'path': ''},
      ],
    },
    {
      'title': 'Account',
      'icon': 'assets/images/icons/account.svg',
      'subItems': [
        {'title': 'Receivables', 'path': ''},
        {'title': 'Payables', 'path': ''},
        {'title': 'Ledger', 'path': ''},
      ],
    },
    {
      'title': 'Expense',
      'icon': 'assets/images/icons/expense.svg',
      'subItems': [
        {'title': 'Daily Expense', 'path': ''},
        {'title': 'Monthly Report', 'path': ''},
        {'title': 'Budget', 'path': ''},
      ],
    },
    {
      'title': 'Role',
      'icon': 'assets/images/icons/role.svg',
      'subItems': [
        {'title': 'Admin', 'path': ''},
        {'title': 'Manager', 'path': ''},
        {'title': 'Staff', 'path': ''},
      ],
    },
    {
      'title': 'Staff',
      'icon': 'assets/images/icons/staff.svg',
      'subItems': [
        {'title': 'All Staff', 'path': ''},
        {'title': 'Add Staff', 'path': ''},
        {'title': 'Staff Groups', 'path': ''},
      ],
    },
    {
      'title': 'Promotion',
      'icon': 'assets/images/icons/promotion.svg',
      'subItems': [
        {'title': 'Active Campaigns', 'path': ''},
        {'title': 'New Offer', 'path': ''},
        {'title': 'History', 'path': ''},
      ],
    },
    {
      'title': 'Settings',
      'icon': 'assets/images/icons/settings.svg',
      'subItems': [
        {'title': 'Profile', 'path': ''},
        {'title': 'Preferences', 'path': ''},
        {'title': 'Security', 'path': ''},
      ],
    },
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
            child: Row(
              children: [
                ClipOval(
                  child: Container(
                    color: Colors.blue.shade50,
                    width: 60,
                    height: 60,
                    child: Image.asset(
                      'assets/images/himal.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'This My Shop',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'User Id- 5662656',
                      style: TextStyle(
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
          ...List.generate(demoMenuData.length, (index) {
            final item = demoMenuData[index];
            final isActive = activeIndex == index;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    if (item['title'] == 'Dashboard') return;
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

import 'package:bazrin/feature/data/API/Helper/Supplier/deleteSupplier.dart';
import 'package:bazrin/feature/data/API/Helper/Supplier/getSuppliers.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/widgets/tost_message.dart';
import 'package:bazrin/feature/presentation/screens/supplier/Supplier/Add/add_supplier.dart';
import 'package:bazrin/feature/presentation/screens/supplier/Components/supplier.dart';
import 'package:flutter/material.dart';

class SupplierList extends StatefulWidget {
  const SupplierList({super.key});

  @override
  State<SupplierList> createState() => _SupplierListState();
}

class _SupplierListState extends State<SupplierList> {
  bool _isExpanded = false;
  bool isloaded = true;
  dynamic suppliers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSupplie();
  }

  void _toggleExpand() {
    if (_isExpanded) {
      Navigator.of(context).push(
        SlidePageRoute(page: AddSupplier(), direction: SlideDirection.right),
      );
    } else {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }
  }

  void getSupplie() async {
    final res = await Getsuppliers.getSuppliersList();
    final List<Map<String, dynamic>> supplierList = (res as List)
        .map((e) => Map<String, dynamic>.from(e))
        .toList();

    setState(() {
      suppliers = supplierList;
    });
  }

  void delete(id) async {
    final response = await Deletesupplier.DeleteSupplierByID(id);
    if (response == 'success') {
      TostMessage.showToast(
        context,
        message: 'Supplier deleted Successfully',
        isSuccess: true,
      );
    }
    getSupplie();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FlowtingIconButton(
          isExpanded: _isExpanded,
          toggleExpand: _toggleExpand,
          title: 'Add Supplier',
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
            'Supplier List',
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
                      onRefresh: () async {
                        getSupplie(); // call it
                        return Future.value(); // ✅ satisfy the Future<void> requirement
                      },

                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          spacing: 5,
                          children: (suppliers ?? [])
                              .map<Widget>(
                                (sup) => Supplier(
                                  sup: sup,
                                  delfuntion: (id) {
                                    delete(id);
                                  },
                                ),
                              )
                              .toList(),
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

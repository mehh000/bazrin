import 'package:bazrin/feature/data/API/Helper/Supplier/getSupplierLedger.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/screens/supplier/Components/ledgerCard.dart';
import 'package:flutter/widgets.dart';

class LedgerFromSupplier extends StatefulWidget {
  final dynamic data;
  const LedgerFromSupplier({super.key, required this.data});

  @override
  State<LedgerFromSupplier> createState() => _LedgerFromSupplierState();
}

class _LedgerFromSupplierState extends State<LedgerFromSupplier> {
  dynamic ledger;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSupLedger();
  }

  Future<void> getSupLedger() async {
    String id = widget.data['id'];
    final response = await Getsupplierledger.getSuppliersLedgerList(id);
    setState(() {
      ledger = response;
    });
   
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.Colorprimary,
          leading: Row(
            children: [
              SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    SlidePageRoute(
                      page: SupplierList(),
                      direction: SlideDirection.left,
                    ),
                  );
                },
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ],
          ),
          title: Text(
            'Ledger',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: AppColors.Colorprimary,
        body: Column(
          children: [
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
                child: ledger != null
                    ? RefreshIndicator(
                        onRefresh: getSupLedger,
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Column(
                            spacing: 5,
                            children: ledger
                                .map<Widget>((led) => SupplierLedgercard(led : led))
                                .toList(),
                          ),
                        ),
                      )
                    : Center(
                        child: Text(
                          'No Ledger',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.withOpacity(0.4),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

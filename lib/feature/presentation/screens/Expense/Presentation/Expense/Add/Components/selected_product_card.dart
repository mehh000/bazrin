import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/Components/simple_input.dart';
import 'package:flutter/material.dart';

class SelectedProductCard extends StatefulWidget {
  final dynamic product;
  final Function? latestData;
  final Function? latestsum;
  final Function? deleteProductFromSelect;
  const SelectedProductCard({
    super.key,
    required this.product,
    this.latestData,
    this.latestsum,
    this.deleteProductFromSelect,
  });

  @override
  State<SelectedProductCard> createState() => _SelectedProductCardState();
}

class _SelectedProductCardState extends State<SelectedProductCard> {
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController unitController = TextEditingController();

  double total = 0;

  @override
  void initState() {
    super.initState();
    qtyController.text = (widget.product['quantity'] ?? '').toString();
    unitController.text = (widget.product['unitPrice'] ?? '').toString();
    total = widget.product['totalAmount'] ?? 0;
    qtyController.addListener(_calculateTotal);
    unitController.addListener(_calculateTotal);
  }

  void _calculateTotal() {
    final double qty = double.tryParse(qtyController.text) ?? 0;
    final double unit = double.tryParse(unitController.text) ?? 0;

    setState(() {
      total = qty * unit;
    });

    dynamic updatedData = {
      'productId': widget.product['id'],
      'quantity': qty.toString(),
      'unitPrice': unit.toString(),
    };

    dynamic updatedDataofsum = {
      'productId': widget.product['id'],
      'quantity': qty.toString(),
      'unitPrice': unit.toString(),
      'total': total,
    };
    //  'total': total,
    setState(() {
      widget.latestData!(updatedData);
      widget.latestsum!(updatedDataofsum);
    });
  }

  @override
  void dispose() {
    qtyController.dispose();
    unitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Product Name ',
                  style: TextStyle(fontSize: 14, color: Color(0xFF616161)),
                ),
                TextSpan(
                  text: ' ${widget.product['name']}',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Quantity
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Quantity',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: AppColors.colorTextGray,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: 60,
                    child: SimpleInput(controller: qtyController),
                  ),
                ],
              ),

              // Unit Price
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Unit Price',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: AppColors.colorTextGray,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: 60,
                    child: SimpleInput(controller: unitController),
                  ),
                ],
              ),

              // Total
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '৳${total.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ],
              ),

              // Delete
              GestureDetector(
                onTap: () {
                  widget.deleteProductFromSelect!({
                    'id': widget.product['id'],
                    'sum': total,
                  });
                },
                child: Column(
                  children: [
                    Icon(Icons.delete_forever_outlined, color: Colors.red),
                    Text(
                      'Delete',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

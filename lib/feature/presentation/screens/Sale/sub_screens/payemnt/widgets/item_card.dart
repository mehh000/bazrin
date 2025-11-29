import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:flutter/material.dart';

class PosSellItem extends StatefulWidget {
  final dynamic item;
  final Function incrementAddedItemToCart;
  const PosSellItem({
    super.key,
    required this.item,
    required this.incrementAddedItemToCart,
  });

  @override
  State<PosSellItem> createState() => _PosSellItemState();
}

class _PosSellItemState extends State<PosSellItem> {
  int currentQty = 0;
  int maxQty = 20;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      currentQty = widget.item['posQty'] ?? 0;
      maxQty = widget.item['totalStock'] ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic item = widget.item;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 2),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: (item['coverImage']['md'] != null)
                ? Image.network(
                    'https://bazrin.com/${item['coverImage']['md']}',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.store, size: 30, color: Colors.grey),
                  )
                : const Icon(Icons.store, size: 30, color: Colors.grey),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Text(
                  '${item['name'].length > 20 ? item['name'].substring(0, 20) : item['name'] ?? ''}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Stock: ${item['totalStock']}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF60626E),
                      ),
                    ),
                  ],
                ),
                Text(
                  '৳${item['salePriceRange'][0]} x $currentQty = ৳${item['salePriceRange'][0] * currentQty}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF60626E),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

         
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (currentQty > 0) currentQty--;
                  });
                  widget.incrementAddedItemToCart({
                    ...item, // keep all original fields
                    'posQty': currentQty, // add or update posQty
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.Colorprimary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '$currentQty',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (currentQty < maxQty) currentQty++;
                  });
                  widget.incrementAddedItemToCart({
                    ...item, // keep all original fields
                    'posQty': currentQty, // add or update posQty
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.Colorprimary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

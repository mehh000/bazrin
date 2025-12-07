import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class SearchDropdownList extends StatefulWidget {
  final String label;
  final bool required;
  final String hint;
  const SearchDropdownList({
    super.key,
    this.label = "",
    this.required = false,
    this.hint = "",
  });

  @override
  State<SearchDropdownList> createState() => _SearchDropdownListState();
}

class _SearchDropdownListState extends State<SearchDropdownList> {
  final List<String> fruits = [
    'Apple',
    'Banana',
    'Mango',
    'Orange',
    'Grapes',
    'Pineapple',
    'Watermelon',
    'Strawberry',
    'Papaya',
    'Cherry',
  ];

  String? selectedFruit;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        Row(
          children: [
            Text(
              widget.label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: AppColors.colorBlack,
              ),
            ),
            Visibility(
              visible: widget.required,
              child: Text(
                '*',
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: AppColors.colorTextGray),
          ),
          child: DropdownSearch<String>(
            items: (String filter, _) {
              final lower = filter.toLowerCase();
              if (lower.isEmpty) return fruits;
              return fruits
                  .where((f) => f.toLowerCase().contains(lower))
                  .toList();
            },
            selectedItem: selectedFruit,
            popupProps: PopupProps.menu(
              
             
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  hintText: widget.hint,
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              menuProps: const MenuProps(
                backgroundColor: Colors.white,
                elevation: 2,
              ),
            ),

            // ✅ FIXED: use 'decoration:' instead of 'dropdownSearchDecoration:'
            decoratorProps: DropDownDecoratorProps(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 13,
                ),
                hintText: widget.hint,
                hintStyle: TextStyle(fontSize: 14, color: AppColors.colorGray),
                border: InputBorder.none,
              ),
            ),

            suffixProps: DropdownSuffixProps(
              dropdownButtonProps: DropdownButtonProps(
                iconClosed: Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.colorGray,
                  size: 20,
                ),
                iconOpened: Icon(
                  Icons.keyboard_arrow_up,
                  color: AppColors.colorGray,
                  size: 20,
                ),
              ),
            ),

            onChanged: (value) {
              setState(() => selectedFruit = value);
            },
          ),
        ),
      ],
    );
  }
}

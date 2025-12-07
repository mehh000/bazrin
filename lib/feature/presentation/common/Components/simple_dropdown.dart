import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class StatusDropdown extends StatefulWidget {
  final String label;
  final bool required;
  final String hint;
  final Function? selectedStatus;
  final String inistSate;
  final dynamic data;

  const StatusDropdown({
    super.key,
    this.label = "",
    this.required = false,
    this.hint = "Select status",
    this.selectedStatus,
    this.inistSate = '',
    this.data,
  });

  @override
  State<StatusDropdown> createState() => _StatusDropdownState();
}

class _StatusDropdownState extends State<StatusDropdown> {
  final List<String> statusList = ['ACTIVE', 'INACTIVE'];
  String? selectedStatus;

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
            items: (String _, __) => widget.data ?? statusList,
            selectedItem: widget.inistSate.isEmpty
                ? selectedStatus
                : widget.inistSate,
            popupProps: PopupProps.menu(
              showSearchBox: false,
              fit: FlexFit.loose,
              constraints: const BoxConstraints(maxHeight: 100, minHeight: 60),
              menuProps: const MenuProps(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                elevation: 2,
              ),
              itemBuilder: (context, item, isSelected, onTap) => ListTile(
                dense: true,
                visualDensity: VisualDensity.compact,
                title: Text(
                  item,
                  style: TextStyle(fontSize: 14, color: AppColors.colorBlack),
                ),
                //  onTap: ,
              ),
            ),
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
              setState(() {
                selectedStatus = value;
              });
              widget.selectedStatus?.call(value);
            },
          ),
        ),
      ],
    );
  }
}

import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  final bool required;
  final String label;
  final Function(DateTime)? onDateSelected;
  final DateTime? initialDate;

  const DatePicker({
    super.key,
    this.required = false,
    this.label = '',
    this.onDateSelected,
    this.initialDate,
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate; // ✅ use initial date if given
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });

      // ✅ Send the selected date back to parent
      if (widget.onDateSelected != null) {
        widget.onDateSelected!(pickedDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
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
            if (widget.required)
              const Text(
                '*',
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
          ],
        ),
        GestureDetector(
          onTap: _selectDate,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: AppColors.colorTextGray),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate != null
                      ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                      : 'Select date',
                  style: TextStyle(fontSize: 14, color: AppColors.colorGray),
                ),
                Icon(
                  Icons.calendar_month_outlined,
                  size: 20,
                  color: AppColors.colorGray,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

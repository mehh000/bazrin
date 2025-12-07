import 'package:flutter/material.dart';
import 'package:drop_down_search_field/drop_down_search_field.dart';

class MySearchDropdown extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  final ValueChanged<Map<String, dynamic>> onChanged;
  final bool isBorder;
  final String? hint;
  final VoidCallback? onAddNew;
  final String getterName;
  final String addButtonTitle;
  final bool isClear; // optional clear behavior
  final TextEditingController dropDownSearchController;

  const MySearchDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.isBorder = true,
    this.hint,
    this.onAddNew,
    this.getterName = 'name',
    this.addButtonTitle = 'Add',
    required this.dropDownSearchController,
    this.isClear = true,
  });

  @override
  State<MySearchDropdown> createState() => _MySearchDropdownState();
}

class _MySearchDropdownState extends State<MySearchDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropDownSearchFormField<Map<String, dynamic>>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: widget.dropDownSearchController,
        decoration: InputDecoration(
          hintText: widget.hint,
          border: OutlineInputBorder(
            borderSide: widget.isBorder
                ? const BorderSide(width: 1, color: Colors.grey)
                : BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      suggestionsCallback: (pattern) {
        final suggestions = widget.items
            .where(
              (i) => i[widget.getterName].toString().toLowerCase().contains(
                pattern.toLowerCase(),
              ),
            )
            .toList();

        suggestions.add({widget.getterName: '__ADD_NEW__'}); // Add new button
        return suggestions;
      },
      itemBuilder: (context, suggestion) {
        if (suggestion[widget.getterName] == '__ADD_NEW__') {
          return ListTile(
            title: TextButton.icon(
              icon: const Icon(Icons.add),
              label: Text(widget.addButtonTitle),
              onPressed: widget.onAddNew,
            ),
          );
        }
        return ListTile(title: Text(suggestion[widget.getterName]));
      },
      onSuggestionSelected: (suggestion) {
        if (suggestion[widget.getterName] == '__ADD_NEW__') {
          widget.onAddNew?.call();
          return;
        }

        widget.dropDownSearchController.text = suggestion[widget.getterName];
        widget.onChanged(suggestion);

        if (!widget.isClear) {
          widget.dropDownSearchController.clear();
        }
      },
      displayAllSuggestionWhenTap: true,
    );
  }
}

import 'package:bazrin/feature/data/API/Helper/Accounts/getaccountList.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/Components/search_dropdown.dart';

class Flaginputcomponent extends StatefulWidget {
  final bool isIcon;
  final String hintitle;
  final double spcae;
  final String label;
  final bool islabel;
  final bool preicon;
  final bool required;
  final IconData iconName;
  final String imagePath;
  final String type;
  final bool read;
  final TextEditingController? controller;
  final Function(DateTime)? onDateSelected;
  final DateTime? initialDate;
  final Function? payid;
  const Flaginputcomponent({
    super.key,
    this.islabel = false,
    this.isIcon = false,
    required this.hintitle,
    this.spcae = 0,
    this.required = false,
    this.label = '',
    this.preicon = false,
    this.iconName = Icons.keyboard_arrow_down,
    required this.imagePath,
    this.type = 'input',
    this.initialDate,
    this.onDateSelected,
    this.controller,
    this.read = false,
    this.payid,
  });

  @override
  State<Flaginputcomponent> createState() => _FlaginputcomponentState();
}

class _FlaginputcomponentState extends State<Flaginputcomponent> {
  DateTime? selectedDate = DateTime.now();
  List<Map<String, dynamic>> accountList = [];
  dynamic paymentData = {};
  TextEditingController _paytypeSearchController = TextEditingController();

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
  void initState() {
    super.initState();
    getacconts();
  }

  Future<void> getacconts() async {
    try {
      final response = await Getaccountlist.getAccountsList();

      // Safely cast and convert
      final List<Map<String, dynamic>> parsedList = (response['data'] as List)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();

      setState(() {
        accountList = parsedList;
      });

      // print('accounts data : $accountList');
    } catch (e) {
      // print('Error loading categories: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: widget.spcae,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.islabel
            ? Row(
                children: [
                  Text(
                    '${widget.label}',
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
              )
            : SizedBox(),
        Container(
          height: 50,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: AppColors.colorTextGray),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                padding: EdgeInsets.all(10),
                height: double.infinity,
                color: AppColors.Colorprimary,
                child: SvgPicture.asset(widget.imagePath, fit: BoxFit.fill),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: widget.type == 'date'
                      ? GestureDetector(
                          onTap: _selectDate,
                          child: Text(
                            selectedDate != null
                                ? '  ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                                : 'Select date',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.colorGray,
                            ),
                          ),
                        )
                      : widget.type == 'dropdown'
                      ? MySearchDropdown(
                          isBorder: false,
                          items: accountList,
                          getterName: 'type',
                          hint: "Search payment account",
                          onChanged: (e) {
                            widget.payid!(e['id']);
                          },
                          dropDownSearchController: _paytypeSearchController,
                        )
                      : TextField(
                          readOnly: widget.read,
                          controller: widget.controller,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 7,
                            ),
                            filled: true,

                            fillColor: widget.read
                                ? Colors.grey.withOpacity(0.2)
                                : Colors.white,
                            hint: Text(
                              '${widget.hintitle}',
                              style: TextStyle(color: AppColors.colorTextGray),
                            ),
                            suffixIcon: widget.isIcon
                                ? Icon(widget.iconName)
                                : null,
                            prefixIcon: widget.preicon
                                ? Icon(
                                    Icons.search_rounded,
                                    color: Colors.black,
                                    size: 20,
                                  )
                                : null,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

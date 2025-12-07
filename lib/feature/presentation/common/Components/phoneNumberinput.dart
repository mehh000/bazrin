import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneInputWidget extends StatefulWidget {
  final String label;
  final double spaceing;
  final bool required;
  final dynamic insialNumber;
  final dynamic data;
  final TextEditingController phonecontrollerl;
  final bool isBoldText;
  const PhoneInputWidget({
    super.key,
    this.label = '',
    this.spaceing = 12,
    this.required = false,
    this.data,
    this.insialNumber,
    required this.phonecontrollerl,
    this.isBoldText = true,
  });

  @override
  State<PhoneInputWidget> createState() => _PhoneInputWidgetState();
}

class _PhoneInputWidgetState extends State<PhoneInputWidget> {
  PhoneNumber? number;

  @override
  void initState() {
    super.initState();
    _initPhoneNumber();
  }

  Future<void> _initPhoneNumber() async {
    if (widget.insialNumber != null &&
        widget.insialNumber.toString().isNotEmpty) {
      try {
        PhoneNumber parsedNumber =
            await PhoneNumber.getRegionInfoFromPhoneNumber(
              widget.insialNumber.toString(),
            );
        setState(() {
          number = parsedNumber;
        });
      } catch (e) {
        // print("Failed to parse number: $e");
        // fallback
        setState(() {
          number = PhoneNumber(isoCode: 'US');
        });
      }
    } else {
      number = PhoneNumber(isoCode: 'US');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (number == null) {
      // loading state for async initialization
      return const CircularProgressIndicator();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: widget.spaceing,
      children: [
        Row(
          children: [
            Text(
              '${widget.label}',
              style: TextStyle(
                fontWeight: widget.isBoldText
                    ? FontWeight.w500
                    : FontWeight.w400,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            if (widget.required)
              const Text(
                '*',
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: AppColors.colorGray),
            borderRadius: BorderRadius.circular(8),
          ),
          child: InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber value) {
              // print('Phone number: ${value}');
              widget.data?.call(value.phoneNumber);
            },
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.DROPDOWN,
              showFlags: true,
            ),
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.disabled,
            selectorTextStyle: const TextStyle(color: Colors.black),
            initialValue: number,
            textFieldController: widget.phonecontrollerl,
            formatInput: true,
            keyboardType: const TextInputType.numberWithOptions(
              signed: true,
              decimal: false,
            ),
            inputDecoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(borderSide: BorderSide.none),
              hintText: 'Enter phone number',
            ),
          ),
        ),
      ],
    );
  }
}

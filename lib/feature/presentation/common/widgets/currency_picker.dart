import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:flutter/material.dart';
import 'package:currency_picker/currency_picker.dart';

class CurrencyPickerWidget extends StatefulWidget {
  final String label;
  const CurrencyPickerWidget({super.key, this.label = ''});

  @override
  State<CurrencyPickerWidget> createState() => _CurrencyPickerWidgetState();
}

class _CurrencyPickerWidgetState extends State<CurrencyPickerWidget> {
  Currency? selectedCurrency;

  void getCountry(BuildContext context) {
    showCurrencyPicker(
      context: context,
      showFlag: true,
      showCurrencyName: false, // hide name
      showCurrencyCode: true, // MUST be true (required)
      onSelect: (Currency currency) {
        setState(() {
          selectedCurrency = currency;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => getCountry(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),

        width: double.infinity,
        child: Row(
          children: [
            if (selectedCurrency != null) ...[
              // FLAG + SYMBOL ONLY
              Text(
                CurrencyUtils.currencyToEmoji(selectedCurrency!),
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 10),
              Text(
                selectedCurrency!.symbol,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ] else
              const Text(
                'Choose Currency',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

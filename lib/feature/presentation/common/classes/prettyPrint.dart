import 'dart:convert';
import 'package:flutter/foundation.dart';

class PrettyPrint {
  static void print(dynamic data) {
    if (kDebugMode) {
      try {
        final encoder = JsonEncoder.withIndent('  ');
        final formattedJson = encoder.convert(data);

        debugPrint('from Log : $formattedJson');
      } catch (e) {
        debugPrint('Failed to pretty print data: $e');
        debugPrint(data.toString());
      }
    }
  }
}

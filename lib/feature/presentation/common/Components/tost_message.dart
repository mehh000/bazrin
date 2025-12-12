import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class TostMessage {
  static void showToast(
    BuildContext context, {
    required String message,
    required bool isSuccess,
  }) {
    final color = isSuccess ? Colors.green : Colors.red;
    final icon = isSuccess ? Icons.check_circle : Icons.cancel;

    toastification.show(
      context: context,
      title: Text(
        isSuccess ? "Success" : "Error",
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text(message, style: const TextStyle(color: Colors.white)),
      icon: Icon(icon, color: Colors.white),
      autoCloseDuration: const Duration(seconds: 1),
      backgroundColor: color,
      primaryColor: color,
      style: ToastificationStyle.fillColored,
    );
  }
}

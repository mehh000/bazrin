import 'package:flutter/material.dart';

class FullScreenRightDialog {
  static Future open({
    required BuildContext context,
    required Widget child, // <-- your custom content
  }) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        opaque: true,
        fullscreenDialog: true,
        pageBuilder: (_, animation, __) {
          return SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(1.0, 0.0), // from RIGHT side
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeOut),
                ),
            child: Scaffold(
              body: SafeArea(child: child), // your custom widget
            ),
          );
        },
      ),
    );
  }
}

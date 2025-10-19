import 'package:flutter/material.dart';

enum SlideDirection { left, right }

class SlidePageRoute extends PageRouteBuilder {
  final Widget page;
  final SlideDirection direction;

  SlidePageRoute({required this.page, this.direction = SlideDirection.right})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            Offset begin;
            if (direction == SlideDirection.left) {
              begin = const Offset(-1.0, 0.0); // slide from left
            } else {
              begin = const Offset(1.0, 0.0); // slide from right
            }
            const end = Offset(0.0, 0.0);
            const curve = Curves.ease;

            final tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            final offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
}

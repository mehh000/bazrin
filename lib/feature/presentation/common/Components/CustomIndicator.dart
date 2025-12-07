import 'package:flutter/material.dart';

class Customindicator extends StatelessWidget {
  const Customindicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TodaysOrder extends StatefulWidget {
  const TodaysOrder({super.key});

  @override
  State<TodaysOrder> createState() => _TodaysOrderState();
}

class _TodaysOrderState extends State<TodaysOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6), boxShadow: [
        BoxShadow(
          color: Color(0xFF3326AE).withOpacity(0.1),
          spreadRadius: 0.2,
          blurRadius: 5,
        
        )
      ]),
      child: Column(
        children: [],
      ),
    );
  }
}

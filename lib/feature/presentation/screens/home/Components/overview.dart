import 'package:bazrin/feature/presentation/screens/home/Components/todaysOrder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OverView extends StatefulWidget {
  const OverView({super.key});

  @override
  State<OverView> createState() => _OverViewState();
}

class _OverViewState extends State<OverView> {
  // 🔹 Card data list
  final List<Map<String, dynamic>> overviewData = [
    {
      'icon': 'assets/images/icons/grow.svg',
      'label': 'Total Sales',
      'value': '\$7,825',
      'color': const Color(0xFFD4EBFF),
    },
    {
      'icon': 'assets/images/icons/due.svg',
      'label': 'Customer Due',
      'value': '124',
      'color': const Color(0xFFFFE0DE),
    },
    {
      'icon': 'assets/images/icons/produckbox.svg',
      'label': 'Total Products',
      'value': '652',
      'color': const Color(0xFFD4EDD4),
    },
    {
      'icon': 'assets/images/icons/handshake.svg',
      'label': 'Supplier Due',
      'value': '\$2,450',
      'color': const Color(0xFFFAE0D1),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // 📏 Responsive setup
    final crossAxisCount = screenWidth < 600 ? 2 : 4;
    final spacing = screenWidth < 600 ? 20.0 : 25.0;
    final cardWidth = (screenWidth - (spacing * (crossAxisCount + 1))) / crossAxisCount;

    return Column(
      spacing: 20,
      children: [
        Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: overviewData.map((item) {
            return SizedBox(
              width: cardWidth,
              child: gowBoxCard(
                icon: item['icon'],
                title: item['label'],
                value: item['value'],
                color: item['color'],
              ),
            );
          }).toList(),
        ),

        TodaysOrder(),
      ],
    );
  }
}

Widget gowBoxCard({
  required String icon,
  required String title,
  required String value,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(7),
      color: color,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
         crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(icon, height: 26, width: 26),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF071437),
                height: 1.83,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/icons/growline.svg'),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF071437),
                height: 1.83,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

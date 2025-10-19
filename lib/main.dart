import 'package:bazrin/feature/presentation/screens/home/home_screen.dart';
import 'package:bazrin/feature/presentation/screens/login/login_screen.dart';
import 'package:bazrin/feature/presentation/screens/products/products_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: ProductsScreen(),
    );
  }
}


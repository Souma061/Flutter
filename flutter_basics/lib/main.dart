import 'package:flutter/material.dart';
import 'package:flutter_basics/currency_converter_material_page.dart';

void main() {
  runApp(const MyApp());
}

// State is the logic and data that can change over time in a Flutter application.

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CurrencyConverterPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

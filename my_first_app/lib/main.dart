import 'package:flutter/material.dart';
import 'package:my_first_app/sample_widget.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 54, 20, 113),
        body: SampleWidget(),
      ),
    ),
  );
}

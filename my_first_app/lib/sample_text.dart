import 'package:flutter/material.dart';

class SampleText extends StatelessWidget {
  const SampleText(this.text, {super.key});

  final String text;

  @override
  Widget build(context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        color: Colors.amberAccent,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}

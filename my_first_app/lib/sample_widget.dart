import 'package:flutter/material.dart';
import 'package:my_first_app/sample_text.dart';

class SampleWidget extends StatelessWidget {
  const SampleWidget({super.key});

  @override
  Widget build(context) {
    return Center(child: SampleText('Happy new year Ghosh babu..'));
  }
}

import 'package:flutter/material.dart';
import 'package:my_first_app/roll_dice.dart';

class SampleWidget extends StatelessWidget {
  const SampleWidget({super.key});

  @override
  Widget build(context) {
    return Center(child: DiceRoller());
  }
}

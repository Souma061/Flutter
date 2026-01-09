import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_first_app/sample_text.dart';

var randomizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  var activeImage = 'assets/images/dice-1.png';

  void rollDice() {
    setState(() {
      var diceNumber = randomizer.nextInt(6) + 1;
      activeImage = 'assets/images/dice-$diceNumber.png';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        SampleText('Happy new year Ghosh babu..'),
        SizedBox(height: 20),
        Image.asset(activeImage, width: 200),
        SizedBox(height: 20),
        ElevatedButton(onPressed: rollDice, child: Text('Click Me')),
      ],
    );
  }
}

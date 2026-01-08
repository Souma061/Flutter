import 'package:flutter/material.dart';

class HourlyForecastClass extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temperature;

  const HourlyForecastClass({
    super.key,
    required this.time,
    required this.icon,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(26)),
        child: Column(
          children: [
            Text(
              time,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Icon(icon, size: 32),
            const SizedBox(height: 10),
            Text(temperature),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

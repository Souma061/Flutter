import 'package:flutter/material.dart';

class HourlyWeather {
  final String time;
  final double temperature;
  final IconData icon;

  HourlyWeather({
    required this.time,
    required this.temperature,
    required this.icon,
  });
}

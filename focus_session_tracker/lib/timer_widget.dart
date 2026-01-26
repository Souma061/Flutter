import 'package:flutter/material.dart';
import 'dart:async';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {

  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;

  void _startTmer() {
    if(_isRunning) return;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });

    setState(() {
      _isRunning = true;
    });
  }

  void _stopTimer() {
    if(!_isRunning) return;

    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }


  String formatTime(int seconds) {
    int m = seconds ~/ 60;
    int s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          formatTime(_seconds),
          style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 30),
        ElevatedButton(onPressed: _isRunning ? _stopTimer : _startTmer, child: Text(_isRunning ? "Stop" : "Start")),

      ],
    );
  }
}

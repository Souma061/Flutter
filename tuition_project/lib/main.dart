import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('My Flutter App')),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              10,
              (index) => Text(
                'Hello World ${index + 1}',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/**
 * Widget  	Main Axis  	Cross Axis
  Column	  Vertical    	Horizontal
  Row	     Horizontal	    Vertical
 */

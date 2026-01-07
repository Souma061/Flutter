import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class CurrencyConverterPage extends StatelessWidget {
  const CurrencyConverterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textFieldBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
        width: 2.0,
        style: BorderStyle.solid,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    );
    return Scaffold(
      // backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Currency Converter'),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text(
              '0',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Enter amount in INR',
                suffixIcon: Icon(Icons.currency_rupee),
                suffixIconColor: Colors.blueGrey,
                focusedBorder: textFieldBorder,
                enabledBorder: textFieldBorder,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

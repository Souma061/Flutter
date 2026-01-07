import 'package:flutter/material.dart';

// import 'package:google_fonts/google_fonts.dart';
class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  double result = 0;
  final TextEditingController textEditingController = TextEditingController();

void convertCurrency() {
    final input = textEditingController.text;

    if (input.isEmpty) return;

    setState(() {
      result = double.parse(input) * 80.0;
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
        centerTitle: false,
        backgroundColor: Colors.amberAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'USD ${(result != 0) ? result.toStringAsFixed(2) : result.toString()}',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: textEditingController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Enter amount in INR',
                  suffixIcon: Icon(Icons.currency_rupee),
                  suffixIconColor: Colors.blueGrey,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                      style: BorderStyle.solid,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                      style: BorderStyle.solid,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                convertCurrency();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amberAccent,
                foregroundColor: Colors.red,
                fixedSize: Size(100, 40),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
              child: Text('Convert'),
            ),
          ],
        ),
      ),
    );
  }
}

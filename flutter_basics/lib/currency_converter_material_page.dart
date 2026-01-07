import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// import 'package:google_fonts/google_fonts.dart';
class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  double result = 0.0;
  bool isLoading = false;
  final TextEditingController textEditingController = TextEditingController();

  // Api function
  Future<double> fetchUSDRate() async {
    final url = Uri.parse('https://api.frankfurter.app/latest?from=INR&to=USD');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['rates']['USD'] as num).toDouble();
    } else {
      throw Exception('Failed to load exchange rate');
    }
  }

  Future<void> convertCurrency() async {
    FocusScope.of(context).unfocus();
    final input = textEditingController.text;

    if (input.isEmpty) return;
    final amount = double.tryParse(input);
    if (amount == null) return;

    setState(() {
      isLoading = true;
    });
    try {
      final rate = await fetchUSDRate();
      setState(() {
        result = amount * rate;
      });
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayResult = result == 0 ? '0.00' : result.toStringAsFixed(2);
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
              isLoading ? 'Converting...' : 'USD $displayResult',
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
                fixedSize: Size(150, 50),
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

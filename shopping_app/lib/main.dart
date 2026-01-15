import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/cart_provider.dart';
import 'package:shopping_app/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping App',
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromRGBO(254, 206, 1, 1),
          ),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(fontSize: 20, color: Colors.black),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          textTheme: TextTheme(
            titleLarge: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            bodySmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          useMaterial3: true,
        ),
        home: const HomePage(),
        // home: ,
      ),
    );
  }
}

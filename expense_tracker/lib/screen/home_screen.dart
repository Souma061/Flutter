import 'package:flutter/material.dart';

import 'add_expense_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddExpenseScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(child: Text('Welcome to Expense Tracker!'),
        

      ),
    );
  }
}

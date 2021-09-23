import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import 'models/transaction.dart';
import 'widgets/chart.dart';
import 'widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense planner',
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Quicksand',
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _listTransactions = [
    Transaction(
        Id: '1',
        title: 'New shoes',
        amount: 69.95,
        date: DateTime.now().subtract(Duration(days: 2))),
    // Transaction(
    //     Id: '2',
    //     title: 'New Shirt',
    //     amount: 99.99,
    //     date: DateTime.now().subtract(Duration(days: 3))),
    // Transaction(
    //     Id: '3',
    //     title: 'Weekly groceries',
    //     amount: 12.25,
    //     date: DateTime.now().subtract(Duration(days: 4)))
  ];

  List<Transaction> get _recentTransactions {
    return _listTransactions
        .where((element) =>
            element.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void _AddNewTransation(String title, double amount) {
    var newtX = Transaction(
        Id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: DateTime.now());
    setState(() {
      this._listTransactions.add(newtX);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_AddNewTransation);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense planner',
          style: TextStyle(fontFamily: 'Open Sans'),
        ),
        actions: [
          IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            // NewTransaction(_AddNewTransation),
            TransactionList(_listTransactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}

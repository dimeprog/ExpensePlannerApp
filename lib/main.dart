import 'package:expenseplannerapp/widget/Transaction_list.dart';
import 'package:expenseplannerapp/widget/new_transaction.dart';
import 'package:flutter/material.dart';
import 'model/transactions.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses Recorder',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    Transaction(
      id: 't1',
      title: 'Monthly data',
      amount: 12000,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Food',
      amount: 59000,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: DateTime.now());

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bctx) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses Recorder'),
        actions: [
          IconButton(
            onPressed: () => _startTransaction(context),
            icon: const Icon(
              Icons.add,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: double.infinity,
              child: const Card(
                child: Text(
                  'Chart',
                  textAlign: TextAlign.center,
                ),
                color: Colors.blue,
              ),
            ),
            TransactionList(_userTransaction)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startTransaction(context),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

import 'package:expenseplannerapp/widget/Transaction_list.dart';
import 'package:expenseplannerapp/widget/new_transaction.dart';
import 'package:flutter/material.dart';
import '../model/transactions.dart';

class UserTransaction extends StatefulWidget {
  const UserTransaction({Key? key}) : super(key: key);

  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          NewTransaction(_addNewTransaction),
          TransactionList(_userTransaction),
        ],
      ),
    );
  }
}

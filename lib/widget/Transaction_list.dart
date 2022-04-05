import 'package:flutter/material.dart';
import '../model/transactions.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;

  TransactionList(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemCount: transaction.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Row(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      border: Border.all(
                    width: 1.5,
                    color: Colors.purple,
                  )),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    '\$${transaction[index].amount.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple),
                  ),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    transaction[index].title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    DateFormat.yMMMd().format(transaction[index].date),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ]),
              ],
            ),
          );
        },
      ),
    );
  }
}

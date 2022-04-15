import 'package:flutter/material.dart';
import '../model/transactions.dart';
import 'package:intl/intl.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return transactions.isEmpty
        ? LayoutBuilder(builder: ((context, constraints) {
            return Column(
              children: [
                Text(
                  'No transaction',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: constraints.maxHeight * 0.7,
                  child: Image.asset('assets/images/waiting.png'),
                ),
              ],
            );
          }))
        : ListView(
            children: transactions
                .map((tx) => TransactionItem(
                      key: ValueKey(tx.id),
                      transaction: tx,
                      mediaQuery: mediaQuery,
                      deleteTx: deleteTx,
                    ))
                .toList(),
          );
  }
}



// Card(
//                     child: Row(
//                       children: [
//                         Container(
//                           margin: const EdgeInsets.symmetric(
//                               vertical: 10, horizontal: 15),
//                           decoration: BoxDecoration(
//                               border: Border.all(
//                             width: 1.5,
//                             color: Colors.purple,
//                           )),
//                           padding: const EdgeInsets.all(10),
//                           child: Text(
//                             '\$${transaction[index].amount.toStringAsFixed(2)}',
//                             style: const TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.purple),
//                           ),
//                         ),
//                         Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 transaction[index].title,
//                                 style: Theme.of(context).textTheme.titleMedium,
//                               ),
//                               Text(
//                                 DateFormat.yMMMd()
//                                     .format(transaction[index].date),
//                                 style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.grey),
//                               ),
//                             ]),
//                       ],
//                     ),
//                   );
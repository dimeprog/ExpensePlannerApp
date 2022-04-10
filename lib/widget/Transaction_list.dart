import 'package:flutter/material.dart';
import '../model/transactions.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;

  TransactionList(this.transaction, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 200,
        child: transaction.isEmpty
            ? Column(
                children: [
                  Text(
                    'No transaction',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 200,
                    child: Image.asset('assets/images/waiting.png'),
                  ),
                ],
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: transaction.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    elevation: 6,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 35,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FittedBox(
                            child: Text(
                              '\$${transaction[index].amount.toStringAsFixed(0)}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        transaction[index].title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transaction[index].date),
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => deleteTx(transaction[index].id),
                      ),
                    ),
                  );
                },
              ),
      ),
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
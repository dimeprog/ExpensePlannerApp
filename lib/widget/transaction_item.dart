import 'dart:math';

import 'package:flutter/material.dart';
import '../model/transactions.dart';
import 'package:intl/intl.dart';
import 'Transaction_list.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.mediaQuery,
    required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final MediaQueryData mediaQuery;
  final Function deleteTx;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color? _bgColor;
  @override
  void initState() {
    const colorList = [
      Colors.blue,
      Colors.red,
      Colors.yellowAccent,
      Colors.pink,
      Colors.purpleAccent,
    ];
    _bgColor = colorList[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      elevation: 6,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 35,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text(
                '\$${widget.transaction.amount.toStringAsFixed(0)}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        trailing: widget.mediaQuery.size.width > 460
            ? FlatButton.icon(
                icon: Icon(Icons.delete),
                onPressed: () => widget.deleteTx(widget.transaction.id),
                textColor: Theme.of(context).errorColor,
                label: Text('Delete'),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => widget.deleteTx(widget.transaction.id),
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}

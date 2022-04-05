import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransactionFunc;
  NewTransaction(this.addTransactionFunc);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void onSubmitData() {
    final enterTitle = titleController.text;
    final enterAmount = double.tryParse(amountController.text);
    if (enterTitle.isEmpty || enterAmount == Null || enterAmount! <= 0) {
      return;
    }

    widget.addTransactionFunc(
      enterTitle,
      enterAmount,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleController,
              onSubmitted: (_) => onSubmitData(),
              // onChanged: (value) => titleInput = value,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: amountController,
              onSubmitted: (_) => onSubmitData(),
              // onChanged: (value) => amountInput = value,
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
            ),
            FlatButton(
              child: const Text(
                'Add Transaction',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              textColor: Colors.purple,
              onPressed: onSubmitData,
            ),
          ],
        ),
      ),
    );
  }
}

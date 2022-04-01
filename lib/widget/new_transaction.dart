import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function addTransactionFunc;
  NewTransaction(this.addTransactionFunc);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: titleController,
                // onChanged: (value) => titleInput = value,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: amountController,
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
                onPressed: () => addTransactionFunc(
                  titleController.text,
                  double.parse(amountController.text),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

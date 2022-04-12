import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransactionFunc;
  NewTransaction(this.addTransactionFunc);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void onSubmitData() {
    final enterTitle = _titleController.text;
    final enterAmount = double.tryParse(_amountController.text);
    if (enterTitle.isEmpty ||
        enterAmount == Null ||
        enterAmount! <= 0 ||
        _selectedDate == null) {
      return;
    }

    widget.addTransactionFunc(enterTitle, enterAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _selectDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: (mediaQuery.viewInsets.bottom + 10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _titleController,
                onSubmitted: (_) => onSubmitData(),
                // onChanged: (value) => titleInput = value,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: _amountController,
                onSubmitted: (_) => onSubmitData(),
                // onChanged: (value) => amountInput = value,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                ),
              ),
              Container(
                height: 60,
                child: Row(
                  children: [
                    FittedBox(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen !!'
                            : ' picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: _selectDatePicker,
                      child: const Text(
                        'choose Date ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                child: const Text(
                  'Add Transaction',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                onPressed: onSubmitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

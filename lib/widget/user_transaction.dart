import 'package:expenseplannerapp/widget/Transaction_list.dart';
import 'package:expenseplannerapp/widget/new_transaction.dart';
import 'package:flutter/material.dart';

class UserTransaction extends StatelessWidget {
  const UserTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(),
        TransactionList(),
      ],
    );
  }
}

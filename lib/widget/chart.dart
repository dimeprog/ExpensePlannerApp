import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transactions.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);
  List<Map> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDays = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDays.day &&
            recentTransaction[i].date.month == weekDays.month &&
            recentTransaction[i].date.year == weekDays.year) {
          totalSum += recentTransaction[i].amount;
        }
      }
      // print(totalSum);
      // print(DateFormat.E().format(weekDays));
      return {
        'days': DateFormat.E().format(weekDays).substring(0, 1),
        'amount': totalSum,
      };
    });
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Row(
        children: [
          ...groupedTransactionValues.map((data) {
            // print((data['amount'] as double) / maxSpending);
            return ChartBar(
                data['amount'],
                data['day'],
                maxSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / maxSpending);
          }).toList()
        ],
      ),
    );
  }
}

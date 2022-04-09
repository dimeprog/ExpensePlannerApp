import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double spendingPctValue;
  final double SpendingAmount;
  final String? label;
  ChartBar(this.SpendingAmount, this.label, this.spendingPctValue);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('\$${spendingPctValue.toStringAsFixed(0)}'),
        const SizedBox(
          height: 4,
        ),
        Container(
          width: 10,
          height: 60,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctValue,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text('$label')
      ],
    );
  }
}

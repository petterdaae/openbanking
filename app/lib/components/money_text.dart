import 'package:app/providers/dependencies.dart';
import 'package:app/providers/utilities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoneyText extends StatelessWidget {
  const MoneyText(this.amount);

  final double amount;

  @override
  Widget build(BuildContext context) {
    final Utilities utilities = Provider.of<Dependencies>(context).utilities;
    return Text(
      utilities.formatMoney(amount),
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: amount > 0 ? Colors.green : Colors.red,
      ),
    );
  }
}

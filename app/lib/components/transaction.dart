import 'package:app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({this.transaction});
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.fastfood),
      title: Text(transaction.text),
      subtitle: Text(transaction.accountingDate.toString()),
      trailing: Text(transaction.amount.toString()),
    );
  }
}

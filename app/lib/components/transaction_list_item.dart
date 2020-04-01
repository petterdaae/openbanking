import 'package:app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TransactionListItemComponent extends StatelessWidget {
  const TransactionListItemComponent({this.transaction});
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

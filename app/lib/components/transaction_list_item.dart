import 'package:app/models/category.dart';
import 'package:app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TransactionListItemComponent extends StatelessWidget {
  const TransactionListItemComponent({
    @required this.transaction,
    @required this.category,
  });

  final Transaction transaction;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Category.getIcon(category == null ? null : category.icon),
      title: Text(transaction.text),
      subtitle: Text(transaction.accountingDate.toString()),
      trailing: Text(transaction.amount.toString()),
    );
  }
}

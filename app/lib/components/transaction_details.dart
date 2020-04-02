import 'package:app/components/transaction_list_item.dart';
import 'package:app/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionDetailsComponent extends StatelessWidget {
  const TransactionDetailsComponent({
    this.transaction,
    this.children,
  });

  final Transaction transaction;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          TransactionListItemComponent(
            transaction: transaction,
          ),
          transaction.categoryId == null
              ? Text("No category")
              : Text(transaction.categoryId),
        ]..addAll(children == null ? List() : children),
      ),
    );
  }
}

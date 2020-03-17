import 'package:app/components/transaction.dart';
import 'package:app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TransactionListWidget extends StatelessWidget {
  const TransactionListWidget({this.transactions});

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, index) => Divider(
        color: Colors.grey,
      ),
      itemCount: transactions.length,
      itemBuilder: (context, index) => TransactionWidget(
        transaction: transactions[index],
      ),
    );
  }
}

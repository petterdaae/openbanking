import 'package:app/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionDetailsComponent extends StatelessWidget {
  const TransactionDetailsComponent({this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(transaction.id),
      ),
    );
  }
}

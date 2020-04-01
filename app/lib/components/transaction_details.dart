import 'package:app/components/transaction_list_item.dart';
import 'package:app/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionDetailsComponent extends StatelessWidget {
  const TransactionDetailsComponent({this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          TransactionListItemComponent(
            transaction: transaction,
          ),
          FlatButton(
            onPressed: () {},
            color: Colors.green,
            child: Text("Change category"),
          )
        ],
      ),
    );
  }
}

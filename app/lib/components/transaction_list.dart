import 'package:app/components/transaction_list_item.dart';
import 'package:app/models/transaction.dart';
import 'package:app/views/transaction_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TransactionListComponent extends StatelessWidget {
  const TransactionListComponent({this.transactions});

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, index) => Divider(
        color: Colors.grey,
      ),
      itemCount: transactions.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => TransactionDetails(
                transactionId: transactions[index].id,
              ),
            ),
          );
        },
        child: TransactionListItemComponent(
          transaction: transactions[index],
        ),
      ),
    );
  }
}

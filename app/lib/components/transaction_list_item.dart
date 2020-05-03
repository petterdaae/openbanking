import 'package:app/components/avatar_icon.dart';
import 'package:app/models/category.dart';
import 'package:app/models/transaction.dart';
import 'package:app/providers/dependencies.dart';
import 'package:app/providers/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionListItemComponent extends StatelessWidget {
  const TransactionListItemComponent({
    @required this.transaction,
    @required this.category,
  });

  final Transaction transaction;
  final Category category;

  @override
  Widget build(BuildContext context) {
    final Utilities utilities = Provider.of<Dependencies>(context).utilities;
    return ListTile(
      leading: AvatarIconComponent(category: category),
      title: Text(transaction.text),
      subtitle: Text(
        DateFormat("dd. MMM yyyy").format(transaction.accountingDate.toDate()),
      ),
      trailing: Text(
        utilities.formatMoney(transaction.amount),
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: transaction.amount > 0 ? Colors.green : Colors.red),
      ),
    );
  }
}

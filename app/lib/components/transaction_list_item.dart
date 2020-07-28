import 'package:app/components/avatar_icon.dart';
import 'package:app/components/money_text.dart';
import 'package:app/helpers/prettier_description.dart';
import 'package:app/models/category.dart';
import 'package:app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class TransactionListItemComponent extends StatelessWidget {
  const TransactionListItemComponent({
    @required this.transaction,
    @required this.category,
  });

  final Transaction transaction;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: AvatarIconComponent(category: category),
        title: Text(prettierDescription(transaction.text)),
        subtitle: Text(
          DateFormat("dd. MMM yyyy")
              .format(transaction.accountingDate.toDate()),
        ),
        trailing: MoneyText(transaction.amount),
      ),
    );
  }
}

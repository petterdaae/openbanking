import 'package:app/models/account.dart';
import 'package:app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class AccountListItemComponent extends StatelessWidget {
  const AccountListItemComponent({this.account});

  final Account account;

  @override
  Widget build(BuildContext context) {
    final MoneyMaskedTextController formatter = MoneyMaskedTextController(
      initialValue: account.balance,
      decimalSeparator: ".",
      thousandSeparator: " ",
      rightSymbol: " kr",
    );
    return ListTile(
      leading: Category.getIcon(null),
      title: Text(account.name),
      subtitle: Text(account.bank),
      trailing: Text(formatter.text),
    );
  }
}

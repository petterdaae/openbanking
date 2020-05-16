import 'package:app/components/avatar_icon.dart';
import 'package:app/models/account.dart';
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
      leading: AvatarIconComponent(
        name: account.bank,
      ),
      title: Text(account.name),
      subtitle: Text(account.bank),
      trailing: Text(formatter.text),
    );
  }
}

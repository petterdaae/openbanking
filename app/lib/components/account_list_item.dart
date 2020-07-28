import 'package:app/components/avatar_icon.dart';
import 'package:app/components/money_text.dart';
import 'package:app/models/account.dart';
import 'package:flutter/material.dart';

class AccountListItemComponent extends StatelessWidget {
  const AccountListItemComponent({this.account});

  final Account account;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: AvatarIconComponent(
          name: account.bank,
        ),
        title: Text(account.name),
        subtitle: Text(account.bank),
        trailing: MoneyText(account.balance),
      ),
    );
  }
}

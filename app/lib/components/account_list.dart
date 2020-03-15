import 'package:app/components/account.dart';
import 'package:app/models/account.dart';
import 'package:flutter/material.dart';

class AccountListWidget extends StatelessWidget {
  const AccountListWidget({this.accounts});

  final List<Account> accounts;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: accounts
          .map(
            (account) => AccountWidget(account: account),
          )
          .toList(),
    );
  }
}

import 'package:app/models/account.dart';
import 'package:flutter/material.dart';

import 'account_list_item.dart';

class AccountListComponent extends StatelessWidget {
  const AccountListComponent({this.accounts});

  final List<Account> accounts;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: accounts
          .map(
            (account) => AccountListItemComponent(account: account),
          )
          .toList(),
    );
  }
}

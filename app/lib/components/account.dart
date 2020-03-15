import 'package:app/models/account.dart';
import 'package:flutter/material.dart';

class AccountWidget extends StatelessWidget {
  const AccountWidget({this.account});

  final Account account;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(account.name),
    );
  }
}

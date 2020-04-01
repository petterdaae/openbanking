import 'package:app/models/account.dart';
import 'package:flutter/material.dart';

class AccountListItemComponent extends StatelessWidget {
  const AccountListItemComponent({this.account});

  final Account account;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: CircleAvatar(child: Icon(Icons.attach_money)),
            ),
            Expanded(flex: 1, child: Padding(padding: EdgeInsets.all(8))),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    account.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    account.bank,
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    account.balance.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

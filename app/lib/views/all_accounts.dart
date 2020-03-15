import 'package:app/auth.dart';
import 'package:app/components/account_list.dart';
import 'package:app/dependencies.dart';
import 'package:app/models/account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AllAccountsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firestore firestore = Provider.of<Dependencies>(context).firestore;
    String uid = Provider.of<Auth>(context).uid;
    return StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection('users')
            .document(uid)
            .collection('accounts')
            .snapshots(),
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (!snapshot.hasData) return Text("Loading");
          List<Account> accounts = snapshot.data.documents
              .map((account) => Account.parse(account))
              .toList();
          return AccountListWidget(
            accounts: accounts,
          );
        });
  }
}

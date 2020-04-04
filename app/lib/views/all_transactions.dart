import 'package:app/auth.dart';
import 'package:app/components/transaction_list.dart';
import 'package:app/dependencies.dart';
import 'package:app/models/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../models/transaction.dart' as T;

class AllTransactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firestore firestore = Provider.of<Dependencies>(context).firestore;
    String uid = Provider.of<Auth>(context).uid;
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection('users')
          .document(uid)
          .collection('transactions')
          .orderBy('accountingDate', descending: true)
          .limit(100)
          .snapshots(),
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot> snapshot,
      ) {
        if (!snapshot.hasData) return Text("Loading");
        List<T.Transaction> transactions = snapshot.data.documents
            .map((transaction) => T.Transaction.parse(transaction))
            .toList();
        return StreamBuilder<QuerySnapshot>(
            stream: firestore
                .collection('users')
                .document(uid)
                .collection('categories')
                .snapshots(),
            builder: (
              BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot,
            ) {
              if (!snapshot.hasData) return Text("Loading");
              List<Category> categories = snapshot.data.documents
                  .map((category) => Category.parse(category))
                  .toList();
              return TransactionListComponent(
                transactions: transactions,
                categories: categories,
              );
            });
      },
    );
  }
}

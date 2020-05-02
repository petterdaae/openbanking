import 'package:app/auth.dart';
import 'package:app/components/transaction_list.dart';
import 'package:app/dependencies.dart';
import 'package:app/models/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../models/transaction.dart' as T;
import '../utilities.dart';

class AllTransactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firestore firestore = Provider.of<Dependencies>(context).firestore;
    String uid = Provider.of<Auth>(context).uid;
    return StreamBuilder2<QuerySnapshot, QuerySnapshot>(
      stream1: firestore
          .collection('users')
          .document(uid)
          .collection('transactions')
          .orderBy('accountingDate', descending: true)
          .limit(100)
          .snapshots(),
      stream2: firestore
          .collection('users')
          .document(uid)
          .collection('categories')
          .snapshots(),
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot> transactionsSnapshot,
        AsyncSnapshot<QuerySnapshot> categoriesSnapshot,
      ) {
        if (!transactionsSnapshot.hasData || !categoriesSnapshot.hasData) {
          return Text("Loading");
        }

        List<T.Transaction> transactions = transactionsSnapshot.data.documents
            .map((transaction) => T.Transaction.parse(transaction))
            .toList();

        List<Category> categories = categoriesSnapshot.data.documents
            .map((category) => Category.parse(category))
            .toList();

        return TransactionListComponent(
          transactions: transactions,
          categories: categories,
        );
      },
    );
  }
}

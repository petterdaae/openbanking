import 'package:app/components/transaction_list.dart';
import 'package:app/models/category.dart';
import 'package:app/providers/auth.dart';
import 'package:app/providers/dependencies.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../models/transaction.dart' as T;
import '../providers/utilities.dart';

class AllTransactions extends StatefulWidget {
  const AllTransactions({
    this.hideHiddenTransactions,
  });

  final bool hideHiddenTransactions;

  @override
  _AllTransactionsState createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  int limit;
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    limit = 30;
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    final Firestore firestore = Provider.of<Dependencies>(context).firestore;
    final String uid = Provider.of<Auth>(context).uid;
    return StreamBuilder2<QuerySnapshot, QuerySnapshot>(
      stream1: firestore
          .collection('users')
          .document(uid)
          .collection('transactions')
          .orderBy('accountingDate', descending: true)
          .limit(limit)
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
          scrollController: scrollController,
          hideHiddenTransactions: widget.hideHiddenTransactions,
        );
      },
    );
  }

  scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("loading more transactions"),
        duration: Duration(seconds: 1),
      ));
      setState(() {
        limit += 10;
      });
    }
  }
}

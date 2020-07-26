import 'package:app/components/spending.dart';
import 'package:app/models/category.dart';
import 'package:app/models/transaction.dart' as T;
import 'package:app/providers/auth.dart';
import 'package:app/providers/dependencies.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../providers/utilities.dart';

class Spending extends StatefulWidget {
  @override
  _SpendingState createState() => _SpendingState();
}

class _SpendingState extends State<Spending> {
  _SpendingState() {
    final DateTime now = DateTime.now();
    _dateTime = DateTime(now.year, now.month, 1);
  }

  DateTime _dateTime;

  @override
  Widget build(BuildContext context) {
    Firestore firestore = Provider.of<Dependencies>(context).firestore;
    String uid = Provider.of<Auth>(context).uid;
    final DateTime firstInThisMonth = this._dateTime;
    final DateTime firstInNextMonth = Jiffy(this._dateTime).add(months: 1);
    return StreamBuilder2<QuerySnapshot, QuerySnapshot>(
      stream1: firestore
          .collection('users')
          .document(uid)
          .collection('categories')
          .snapshots(),
      stream2: firestore
          .collection('users')
          .document(uid)
          .collection('transactions')
          .where('accountingDate',
              isGreaterThanOrEqualTo: firstInThisMonth.millisecondsSinceEpoch)
          .where('accountingDate',
              isLessThan: firstInNextMonth.millisecondsSinceEpoch)
          .snapshots(),
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot> snapshot1,
        AsyncSnapshot<QuerySnapshot> snapshot2,
      ) {
        if (!snapshot1.hasData || !snapshot2.hasData) return Text("loading");

        final List<Category> categories =
            snapshot1.data.documents.map((c) => Category.parse(c)).toList();

        final List<T.Transaction> transactions = snapshot2.data.documents
            .map((c) => T.Transaction.parse(c))
            .toList();

        return SpendingComponent(
          dateTime: this._dateTime,
          spending: _buildTupleList(transactions, categories),
          onNextPressed: () {
            this.setState(
                () => this._dateTime = Jiffy(this._dateTime).add(months: 1));
          },
          onPrevPressed: () {
            this.setState(() =>
                this._dateTime = Jiffy(this._dateTime).subtract(months: 1));
          },
        );
      },
    );
  }

  List<Tuple2<Category, double>> _buildTupleList(
    List<T.Transaction> transactions,
    List<Category> categories,
  ) {
    List<Tuple2<Category, double>> result = List();

    for (Category category in categories) {
      if (category.hidden) continue;
      final List<T.Transaction> matching =
          transactions.where((t) => t.categoryId == category.id).toList();
      final double sum = matching.fold(0, (prev, elem) => prev + elem.amount);
      result.add(Tuple2(category, sum));
    }

    result.sort((a, b) => a.item2 > b.item2 ? 1 : -1);

    return result;
  }
}

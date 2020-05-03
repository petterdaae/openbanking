import 'package:app/components/transaction_details.dart';
import 'package:app/models/category.dart';
import 'package:app/providers/auth.dart';
import 'package:app/providers/dependencies.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/transaction.dart' as T;
import 'category_list.dart';

class TransactionDetails extends StatelessWidget {
  const TransactionDetails({
    @required this.transactionId,
  });

  final String transactionId;

  @override
  Widget build(BuildContext context) {
    final Firestore firestore = Provider.of<Dependencies>(context).firestore;
    final String uid = Provider.of<Auth>(context).uid;
    return StreamBuilder<DocumentSnapshot>(
      stream: firestore
          .collection('users')
          .document(uid)
          .collection('transactions')
          .document(transactionId)
          .snapshots(),
      builder: (
        BuildContext context,
        AsyncSnapshot<DocumentSnapshot> snapshot,
      ) {
        if (!snapshot.hasData) return Text("Loading");
        final T.Transaction transaction = T.Transaction.parse(snapshot.data);
        return StreamBuilder<DocumentSnapshot>(
          stream: firestore
              .collection('users')
              .document(uid)
              .collection('categories')
              .document(transaction.categoryId)
              .snapshots(),
          builder: (
            BuildContext context,
            AsyncSnapshot<DocumentSnapshot> snapshot,
          ) {
            if (!snapshot.hasData) return Text("Loading");
            final Category category =
                !snapshot.data.exists ? null : Category.parse(snapshot.data);
            return TransactionDetailsComponent(
              transaction: transaction,
              category: category,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: FlatButton(
                    padding: EdgeInsets.all(16),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Scaffold(
                            appBar: AppBar(),
                            body: CategoryList(
                              onCategoryTapped: (String categoryId) {
                                firestore
                                    .collection('users')
                                    .document(uid)
                                    .collection('transactions')
                                    .document(transaction.id)
                                    .updateData(<String, dynamic>{
                                  'categoryId': categoryId,
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    color: Colors.green,
                    child: Text(
                      "Change category",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

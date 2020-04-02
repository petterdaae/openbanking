import 'package:app/auth.dart';
import 'package:app/components/transaction_details.dart';
import 'package:app/dependencies.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/transaction.dart' as T;
import 'category_list.dart';

class TransactionDetails extends StatelessWidget {
  const TransactionDetails({this.transactionId});

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
        return TransactionDetailsComponent(
          transaction: transaction,
          children: <Widget>[
            FlatButton(
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
              child: Text("Change category"),
            ),
          ],
        );
      },
    );
  }
}

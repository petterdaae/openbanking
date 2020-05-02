import 'package:app/auth.dart';
import 'package:app/components/firestore_pagination.dart';
import 'package:app/components/transaction_list_item.dart';
import 'package:app/dependencies.dart';
import 'package:app/models/category.dart';
import 'package:app/models/transaction.dart' as T;
import 'package:app/views/transaction_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AllTransactions extends StatefulWidget {
  @override
  _AllTransactionsState createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  int limit;

  @override
  void initState() {
    super.initState();
    this.limit = 20;
  }

  @override
  Widget build(BuildContext context) {
    Firestore firestore = Provider.of<Dependencies>(context).firestore;
    String uid = Provider.of<Auth>(context).uid;
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection('users')
          .document(uid)
          .collection('categories')
          .snapshots(),
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot> categoriesSnapshot,
      ) {
        if (!categoriesSnapshot.hasData) {
          return Text("Loading");
        }

        List<Category> categories = categoriesSnapshot.data.documents
            .map((category) => Category.parse(category))
            .toList();

        return FirestorePagination(
          query: firestore
              .collection('users')
              .document(uid)
              .collection('transactions')
              .orderBy('accountingDate', descending: true),
          itemBuilder: (BuildContext context, DocumentSnapshot snapshot) {
            final T.Transaction transaction = T.Transaction.parse(snapshot);
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => TransactionDetails(
                      transactionId: transaction.id,
                    ),
                  ),
                );
              },
              child: TransactionListItemComponent(
                transaction: transaction,
                category: getCategory(transaction, categories),
              ),
            );
          },
          loaderBuilder: (BuildContext context) => Text("Loading..."),
          separatorBuilder: (BuildContext context) => Divider(
            color: Colors.grey,
          ),
        );
      },
    );
  }

  Category getCategory(T.Transaction transaction, List<Category> categories) {
    for (Category category in categories) {
      if (transaction.categoryId == category.id) {
        return category;
      }
    }
    return null;
  }
}

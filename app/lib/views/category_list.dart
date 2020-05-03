import 'package:app/components/category_list.dart';
import 'package:app/models/category.dart';
import 'package:app/providers/auth.dart';
import 'package:app/providers/dependencies.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({this.onCategoryTapped});

  final void Function(String) onCategoryTapped;

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
        AsyncSnapshot<QuerySnapshot> snapshot,
      ) {
        if (!snapshot.hasData) return Text("loading");
        final List<Category> categories =
            snapshot.data.documents.map((c) => Category.parse(c)).toList();
        return CategoryListComponent(
          categories: categories,
          onCategoryTapped: onCategoryTapped,
        );
      },
    );
  }
}

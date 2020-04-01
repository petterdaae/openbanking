import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Category {
  const Category({
    @required this.name,
    @required this.id,
  });

  final String name;
  final String id;

  static Category parse(DocumentSnapshot snapshot) => Category(
        name: snapshot["name"],
        id: snapshot.documentID,
      );
}

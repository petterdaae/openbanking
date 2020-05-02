import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Category {
  const Category({
    @required this.name,
    @required this.id,
    @required this.icon,
  });

  final String name;
  final String id;
  final String icon;

  static Category parse(DocumentSnapshot snapshot) => Category(
        name: snapshot["name"],
        id: snapshot.documentID,
        icon: snapshot["icon"],
      );
}

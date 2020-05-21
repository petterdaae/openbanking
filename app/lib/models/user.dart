import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class User {
  const User({
    @required this.name,
  });

  final String name;

  static User parse(DocumentSnapshot snapshot) => User(name: snapshot["name"]);
}

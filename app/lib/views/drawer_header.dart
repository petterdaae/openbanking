import 'package:app/components/drawer_header_component.dart';
import 'package:app/models/user.dart';
import 'package:app/providers/auth.dart';
import 'package:app/providers/dependencies.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firestore firestore = Provider.of<Dependencies>(context).firestore;
    String uid = Provider.of<Auth>(context).uid;
    return StreamBuilder<DocumentSnapshot>(
      stream: firestore.collection("users").document(uid).snapshots(),
      builder: (
        BuildContext context,
        AsyncSnapshot<DocumentSnapshot> snapshot,
      ) {
        if (!snapshot.hasData) return Text("Loading");
        User user = User.parse(snapshot.data);
        return DrawerHeaderComponent(
          user: user,
        );
      },
    );
  }
}

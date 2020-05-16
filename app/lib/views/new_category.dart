import 'package:app/components/avatar_icon.dart';
import 'package:app/views/pick_icon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/dependencies.dart';
import '../providers/dependencies.dart';

class NewCategory extends StatefulWidget {
  @override
  _NewCategoryState createState() => _NewCategoryState();
}

class _NewCategoryState extends State<NewCategory> {
  String _iconName;
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context);
    final Firestore firestore = Provider.of<Dependencies>(context).firestore;
    return Scaffold(
      appBar: AppBar(
        title: Text("New category"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => PickIcon(
                      onIconTapped: (icon) {
                        setState(() {
                          _iconName = icon;
                        });
                      },
                    ),
                  ),
                );
              },
              child: AvatarIconComponent(name: _iconName, size: 50),
            ),
            Padding(padding: EdgeInsets.all(8)),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Category name"),
            ),
            Padding(padding: EdgeInsets.all(8)),
            OutlineButton(
              child: Text("Create"),
              onPressed: () {
                firestore
                    .collection('users')
                    .document(auth.uid)
                    .collection('categories')
                    .add({
                  "icon": _iconName,
                  "name": descriptionController.text
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:app/views/category_list.dart';
import 'package:app/views/new_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/dependencies.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context);
    final Firestore firestore = Provider.of<Dependencies>(context).firestore;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => NewCategory(),
          ),
        ),
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            child: CategoryList(
              onCategoryTapped: (id) {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      child: Wrap(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              firestore
                                  .collection('users')
                                  .document(auth.uid)
                                  .collection('categories')
                                  .document(id)
                                  .delete();
                              Navigator.of(context).pop();
                            },
                            child: ListTile(
                              title: Text("Delete category"),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

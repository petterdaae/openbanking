import 'package:app/views/category_list.dart';
import 'package:app/views/new_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => NewCategory(),
          ),
        ),
        child: Icon(Icons.add),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: CategoryList()),
        ],
      ),
    );
  }
}

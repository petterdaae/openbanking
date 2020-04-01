import 'package:app/models/category.dart';
import 'package:flutter/material.dart';

class CategoryListItemComponent extends StatelessWidget {
  const CategoryListItemComponent({
    @required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(category.name),
    );
  }
}

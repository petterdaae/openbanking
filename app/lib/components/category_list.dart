import 'package:app/components/category_list_item.dart';
import 'package:app/models/category.dart';
import 'package:flutter/material.dart';

class CategoryListComponent extends StatelessWidget {
  const CategoryListComponent({this.categories});

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, index) => Divider(
        color: Colors.grey,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) => CategoryListItemComponent(
        category: categories[index],
      ),
    );
  }
}

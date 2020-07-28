import 'package:app/components/category_list_item.dart';
import 'package:app/models/category.dart';
import 'package:flutter/material.dart';

class CategoryListComponent extends StatelessWidget {
  const CategoryListComponent({
    @required this.categories,
    this.onCategoryTapped,
  });

  final List<Category> categories;
  final void Function(String) onCategoryTapped;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) => InkWell(
        onTap: this.onCategoryTapped == null
            ? null
            : () => this.onCategoryTapped(categories[index].id),
        child: CategoryListItemComponent(
          category: categories[index],
        ),
      ),
    );
  }
}

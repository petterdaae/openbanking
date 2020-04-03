import 'package:app/components/avatar_icon.dart';
import 'package:app/dependencies.dart';
import 'package:app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryListItemComponent extends StatelessWidget {
  const CategoryListItemComponent({
    @required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    var utilities = Provider.of<Dependencies>(context).utilities;
    return ListTile(
      leading: AvatarIconComponent(category: category),
      title: Text(category.name),
      trailing: Text(utilities.formatMoney(category.balance)),
    );
  }
}

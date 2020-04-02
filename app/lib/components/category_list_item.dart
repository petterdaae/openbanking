import 'package:app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class CategoryListItemComponent extends StatelessWidget {
  const CategoryListItemComponent({
    @required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    final MoneyMaskedTextController formatter = MoneyMaskedTextController(
      initialValue: category.balance,
      decimalSeparator: ".",
      thousandSeparator: " ",
      rightSymbol: " kr",
    );
    return ListTile(
      leading: Category.getIcon(category.icon),
      title: Text(category.name),
      trailing: Text(formatter.text),
    );
  }
}

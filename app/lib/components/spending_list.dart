import 'package:app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../dependencies.dart';
import '../utilities.dart';
import 'avatar_icon.dart';

class SpendingList extends StatelessWidget {
  const SpendingList({
    @required this.spending,
  });

  final List<Tuple2<Category, double>> spending;

  @override
  Widget build(BuildContext context) {
    final Utilities utilities = Provider.of<Dependencies>(context).utilities;
    return ListView.separated(
      separatorBuilder: (_, index) => Divider(color: Colors.grey),
      itemCount: spending.length,
      itemBuilder: (context, index) => ListTile(
        leading: AvatarIconComponent(category: spending[index].item1),
        title: Text(spending[index].item1.name),
        trailing: Text(utilities.formatMoney(spending[index].item2)),
      ),
    );
  }
}

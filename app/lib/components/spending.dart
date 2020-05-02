import 'package:app/components/avatar_icon.dart';
import 'package:app/models/category.dart';
import 'package:app/utilities.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../dependencies.dart';

class SpendingComponent extends StatelessWidget {
  const SpendingComponent({
    @required this.spending,
    @required this.dateTime,
    @required this.onNextPressed,
    @required this.onPrevPressed,
  });

  final List<Tuple2<Category, double>> spending;
  final DateTime dateTime;
  final Function onNextPressed;
  final Function onPrevPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: _MonthPicker(
            dateTime: this.dateTime,
            onNextPressed: this.onNextPressed,
            onPrevPressed: this.onPrevPressed,
          ),
        ),
        Divider(color: Colors.grey),
        SpendingList(spending: this.spending),
        // SpendingList(),
      ],
    );
  }
}

class SpendingList extends StatelessWidget {
  const SpendingList({
    @required this.spending,
  });

  final List<Tuple2<Category, double>> spending;

  @override
  Widget build(BuildContext context) {
    final Utilities utilities = Provider.of<Dependencies>(context).utilities;
    return SingleChildScrollView(
      child: Column(
        children: spending
            .map((tup) => ListTile(
                  leading: AvatarIconComponent(category: tup.item1),
                  title: Text(tup.item1.name),
                  trailing: Text(utilities.formatMoney(tup.item2)),
                ))
            .toList(),
      ),
    );
  }
}

class _MonthPicker extends StatelessWidget {
  const _MonthPicker({
    @required this.dateTime,
    @required this.onNextPressed,
    @required this.onPrevPressed,
  });

  final DateTime dateTime;
  final Function onNextPressed;
  final Function onPrevPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _IconButton(
          onPressed: this.onPrevPressed,
          icon: CommunityMaterialIcons.arrow_left,
        ),
        Text(DateFormat("MMMM").format(dateTime)),
        Text("/"),
        Text(DateFormat("y").format(dateTime)),
        _IconButton(
          onPressed: this.onNextPressed,
          icon: CommunityMaterialIcons.arrow_right,
        ),
      ],
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    @required this.icon,
    @required this.onPressed,
  });

  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: const ShapeDecoration(
        color: Colors.lightBlue,
        shape: CircleBorder(),
      ),
      child: IconButton(
        icon: Icon(icon),
        color: Colors.white,
        onPressed: this.onPressed,
      ),
    );
  }
}

import 'package:app/components/month_year_picker.dart';
import 'package:app/components/spending_list.dart';
import 'package:app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

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
          child: MonthYearPicker(
            dateTime: this.dateTime,
            onNextPressed: this.onNextPressed,
            onPrevPressed: this.onPrevPressed,
          ),
        ),
        Divider(color: Colors.grey),
        Expanded(child: SpendingList(spending: this.spending)),
        // SpendingList(),
      ],
    );
  }
}

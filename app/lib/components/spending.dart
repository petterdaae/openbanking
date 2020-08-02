import 'package:app/components/month_year_picker.dart';
import 'package:app/components/spending_list.dart';
import 'package:app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tuple/tuple.dart';

class SpendingComponent extends StatelessWidget {
  const SpendingComponent({
    @required this.spending,
    @required this.dateTime,
    @required this.onNextPressed,
    @required this.onPrevPressed,
    @required this.totalIncome,
    @required this.totalExpenses,
  });

  final List<Tuple2<Category, double>> spending;
  final DateTime dateTime;
  final Function onNextPressed;
  final Function onPrevPressed;
  final double totalIncome;
  final double totalExpenses;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Flexible(
          child: SvgPicture.asset("assets/investing.svg"),
          flex: 3,
        ),
        //Flexible(
        //  child: Text(this.totalExpenses.toString()),
        //  flex: 1,
        //),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: MonthYearPicker(
              dateTime: this.dateTime,
              onNextPressed: this.onNextPressed,
              onPrevPressed: this.onPrevPressed,
            ),
          ),
        ),
        Flexible(
          child: SpendingList(spending: this.spending),
          fit: FlexFit.loose,
          flex: 6,
        ),
        // SpendingList(),
      ],
    );
  }
}

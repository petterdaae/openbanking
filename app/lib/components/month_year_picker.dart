import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthYearPicker extends StatelessWidget {
  const MonthYearPicker({
    @required this.dateTime,
    @required this.onNextPressed,
    @required this.onPrevPressed,
  });

  final DateTime dateTime;
  final Function onNextPressed;
  final Function onPrevPressed;

  @override
  Widget build(BuildContext context) {
    final DateTime previousMonth =
        DateTime(dateTime.year, dateTime.month - 1, dateTime.day);
    final DateTime nextMonth =
        DateTime(dateTime.year, dateTime.month + 1, dateTime.day);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _MonthYearButton(
          dateTime: previousMonth,
          backgroundColor: Colors.grey,
          onPressed: this.onPrevPressed,
        ),
        _MonthYearButton(
          dateTime: dateTime,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        _MonthYearButton(
          dateTime: nextMonth,
          backgroundColor: Colors.grey,
          onPressed: this.onNextPressed,
        ),
      ],
    );
  }
}

class _MonthYearButton extends StatelessWidget {
  const _MonthYearButton({
    @required this.dateTime,
    @required this.backgroundColor,
    this.onPressed,
  });

  final DateTime dateTime;
  final Color backgroundColor;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: InkWell(
          onTap: this.onPressed,
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.all(
                Radius.circular(50.0),
              ),
            ),
            child: Text(
              DateFormat("MMMM").format(dateTime) +
                  " " +
                  DateFormat("y").format(dateTime),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

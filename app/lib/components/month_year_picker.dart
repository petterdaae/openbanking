import 'package:app/components/round_icon_button.dart';
import 'package:community_material_icon/community_material_icon.dart';
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        RoundIconButton(
          onPressed: this.onPrevPressed,
          icon: CommunityMaterialIcons.arrow_left,
        ),
        Text(DateFormat("MMMM").format(dateTime)),
        Text("/"),
        Text(DateFormat("y").format(dateTime)),
        RoundIconButton(
          onPressed: this.onNextPressed,
          icon: CommunityMaterialIcons.arrow_right,
        ),
      ],
    );
  }
}

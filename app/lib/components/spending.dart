import 'package:app/models/transaction.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class SpendingComponent extends StatelessWidget {
  const SpendingComponent({
    @required this.transactions,
    @required this.dateTime,
    @required this.onNextPressed,
    @required this.onPrevPressed,
  });

  final List<Transaction> transactions;
  final DateTime dateTime;
  final Function onNextPressed;
  final Function onPrevPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Center(child: Text("Spending")),
      ],
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

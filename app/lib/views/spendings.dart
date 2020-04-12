import 'package:app/components/bar_chart.dart';
import 'package:flutter/material.dart';

class Spendings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BarChartComponent(
        barWidth: 20,
        values: [1, 2, 3, 4, 5],
        categories: ["food", "transport", "alcohol", "food", "transport"],
      ),
    );
  }
}

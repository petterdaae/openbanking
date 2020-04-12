import 'package:app/components/avatar_icon.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartComponent extends StatelessWidget {
  const BarChartComponent({
    this.barWidth = 16,
    @required this.values,
    @required this.categories,
    this.colors,
  });

  final double barWidth;
  final List<double> values;
  final List<String> categories;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceBetween,
              barGroups: values.map((v) => bar(v)).toList(),
              titlesData: FlTitlesData(
                leftTitles: SideTitles(showTitles: false),
                bottomTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              borderData: FlBorderData(show: false),
            ),
          ),
          Padding(padding: EdgeInsets.all(4)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: categories
                .map((cat) => AvatarIconComponent(
                      name: cat,
                      size: barWidth / 2,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  BarChartGroupData bar(double value, [Color color = Colors.orange]) =>
      BarChartGroupData(
        x: 0,
        barRods: [BarChartRodData(y: value, width: barWidth, color: color)],
      );
}

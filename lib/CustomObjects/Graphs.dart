import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:metrics_app/utils/constants.dart';
import 'package:metrics_app/utils/sample_data.dart';

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({Key? key}) : super(key: key);

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  List<Color> gradientColors = [
    DARKBLUEGRAPH,
    MAERSKBLUE,
    DARKBLUEGRAPH,
  ];
  final double barWidth = 5;

  @override
  Widget build(BuildContext context) => BarChart(BarChartData(
        minY: 80,
        maxY: 100,
        groupsSpace: 12,
        barTouchData: BarTouchData(enabled: true),
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
            show: false,
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false))),
        barGroups: BarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.id,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    width: barWidth,
                    color: Colors.orange,
                    borderRadius: data.y > 0
                        ? BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          )
                        : BorderRadius.only(
                            bottomLeft: Radius.circular(6),
                            bottomRight: Radius.circular(6),
                          ),
                  ),
                ],
              ),
            )
            .toList(),
      ));
}

class OutagesChartWidget extends StatefulWidget {
  const OutagesChartWidget({Key? key}) : super(key: key);

  @override
  State<OutagesChartWidget> createState() => _OutagesChartWidgetState();
}

class _OutagesChartWidgetState extends State<OutagesChartWidget> {
  final double barWidth = 5;

  @override
  Widget build(BuildContext context) => BarChart(BarChartData(
        minY: 80,
        maxY: 100,
        groupsSpace: 12,
        barTouchData: BarTouchData(enabled: true),
        gridData:
            FlGridData(horizontalInterval: 10000, verticalInterval: 10000),
        titlesData: FlTitlesData(
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false))),
        barGroups: BarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.id,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    width: barWidth,
                    color: DANGER,
                    borderRadius: data.y > 0
                        ? BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          )
                        : BorderRadius.only(
                            bottomLeft: Radius.circular(6),
                            bottomRight: Radius.circular(6),
                          ),
                  ),
                ],
              ),
            )
            .toList(),
      ));
}

class IndividualLineChartWidget extends StatefulWidget {
  const IndividualLineChartWidget({Key? key}) : super(key: key);

  @override
  State<IndividualLineChartWidget> createState() =>
      _IndividualLineChartWidgetState();
}

class _IndividualLineChartWidgetState extends State<IndividualLineChartWidget> {
  List<Color> gradientColors = [
    DARKBLUEGRAPH,
    MAERSKBLUE,
    DARKBLUEGRAPH,
  ];
  final double barWidth = 5;

  @override
  Widget build(BuildContext context) => BarChart(BarChartData(
        minY: 80,
        maxY: 100,
        groupsSpace: 12,
        barTouchData: BarTouchData(enabled: true),
        gridData:
            FlGridData(horizontalInterval: 10000, verticalInterval: 10000),
        titlesData: FlTitlesData(
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false))),
        barGroups: BarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.id,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    width: barWidth,
                    color: SUCCESS,
                    borderRadius: data.y > 0
                        ? BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          )
                        : BorderRadius.only(
                            bottomLeft: Radius.circular(6),
                            bottomRight: Radius.circular(6),
                          ),
                  ),
                ],
              ),
            )
            .toList(),
      ));
}

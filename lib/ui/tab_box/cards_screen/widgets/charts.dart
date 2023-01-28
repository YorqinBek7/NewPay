import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:new_pay/utils/colors.dart';

LineChartData mainData(
  bool isIncome,
) {
  return LineChartData(
    titlesData: FlTitlesData(
      show: true,
      leftTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    ),
    borderData: FlBorderData(
      show: true,
      border: Border.all(color: NewPayColors.C_828282.withOpacity(.2)),
    ),
    minX: 0,
    maxX: 11,
    minY: 0,
    maxY: 6,
    lineBarsData: [
      LineChartBarData(
        spots: isIncome
            ? const [
                FlSpot(0, 2.5),
                FlSpot(2.6, 2),
                FlSpot(4.9, 3),
                FlSpot(6.8, 3.1),
                FlSpot(8, 3.5),
                FlSpot(9.5, 3),
                FlSpot(11, 4),
              ]
            : const [
                FlSpot(1, 2.5),
                FlSpot(2.6, 2),
                FlSpot(4.5, 3),
                FlSpot(5.5, 3.1),
                FlSpot(7, 2.5),
                FlSpot(9.5, 2),
                FlSpot(11, 3),
              ],
        isCurved: true,
        gradient: LinearGradient(
          colors: incomeGradientColors,
        ),
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: isIncome
                ? incomeGradientColors
                    .map((color) => color.withOpacity(0.3))
                    .toList()
                : expensesGradientColors
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
          ),
        ),
      ),
    ],
  );
}

List<Color> incomeGradientColors = [
  const Color(0xff23b6e6),
  const Color(0xff02d39a),
];
List<Color> expensesGradientColors = [
  const Color(0xffC145FC),
  const Color(0xffC145FC),
];

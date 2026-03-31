import 'package:autovault/core/utils/size_config.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:autovault/data/models/dashboard_models.dart';

class SalesChart extends StatelessWidget {
  final List<MonthlySales> data;
  const SalesChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SizedBox(
      height: SizeConfig.h(224),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 10,
            getDrawingHorizontalLine: (value) => FlLine(
              color: cs.onSurface.withValues(alpha: 0.05),
              strokeWidth: 1,
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: SizeConfig.w(32),
                interval: 10,
                getTitlesWidget: (v, _) => Text(
                  v.toInt().toString(),
                  style:
                      TextStyle(color: cs.outline, fontSize: SizeConfig.w(10)),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: SizeConfig.h(28),
                interval: 1,
                getTitlesWidget: (v, _) {
                  final i = v.toInt();
                  if (i < 0 || i >= data.length) return const SizedBox.shrink();
                  return Padding(
                    padding: EdgeInsets.only(top: SizeConfig.h(8)),
                    child: Text(
                      data[i].month,
                      style: TextStyle(
                        color: cs.outline,
                        fontSize: SizeConfig.w(10),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: (data.length - 1).toDouble(),
          minY: 0,
          maxY: 40,
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: cs.surfaceContainer.withValues(alpha: 0.95),
              tooltipBorder:
                  BorderSide(color: cs.primary.withValues(alpha: 0.3)),
              tooltipRoundedRadius: SizeConfig.w(8),
              getTooltipItems: (spots) => spots.map((s) {
                final i = s.x.toInt();
                return LineTooltipItem(
                  '${data[i].month}\n${s.y.toInt()} cars',
                  TextStyle(
                      color: cs.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.w(12)),
                );
              }).toList(),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: data
                  .asMap()
                  .entries
                  .map((e) => FlSpot(e.key.toDouble(), e.value.value))
                  .toList(),
              isCurved: true,
              curveSmoothness: 0.3,
              color: cs.primary,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (_, __, ___, ____) => FlDotCirclePainter(
                  radius: SizeConfig.w(4),
                  color: cs.primary,
                  strokeWidth: 2,
                  strokeColor: cs.surface,
                ),
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    cs.primary.withValues(alpha: 0.25),
                    cs.primary.withValues(alpha: 0.0)
                  ],
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 800),
      ),
    );
  }
}


import 'dart:math';
import 'package:flutter/material.dart';
import 'package:autovault/core/utils/size_config.dart';

class InventoryTile extends StatelessWidget {
  final String label;
  final int count;
  final int total;
  final Color color;
  final IconData icon;

  const InventoryTile(
      {super.key,
      required this.label,
      required this.count,
      required this.total,
      required this.color,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final ratio = total > 0 ? count / total : 0.0;

    return Expanded(
      child: Container(
        padding: EdgeInsets.all(SizeConfig.w(12)),
        decoration: BoxDecoration(
          color: cs.surfaceContainerHigh.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(SizeConfig.w(12)),
          border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.3)),
        ),
        child: Column(children: [
          SizedBox(
            width: SizeConfig.w(48),
            height: SizeConfig.w(48),
            child: CustomPaint(
              painter: _DonutPainter(
                  ratio: ratio,
                  color: color,
                  bg: cs.onSurface.withValues(alpha: 0.08)),
              child: Center(
                  child: Icon(icon, size: SizeConfig.w(16), color: color)),
            ),
          ),
          SizedBox(height: SizeConfig.h(8)),
          Text('$count',
              style: tt.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w800, color: cs.onSurface)),
          SizedBox(height: SizeConfig.h(4)),
          Text(label,
              style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant),
              textAlign: TextAlign.center),
        ]),
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final double ratio;
  final Color color;
  final Color bg;
  _DonutPainter({required this.ratio, required this.color, required this.bg});
  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final r = size.width / 2;
    const sw = 4.0;
    canvas.drawCircle(
        c,
        r - sw / 2,
        Paint()
          ..color = bg
          ..style = PaintingStyle.stroke
          ..strokeWidth = sw
          ..strokeCap = StrokeCap.round);
    canvas.drawArc(
        Rect.fromCircle(center: c, radius: r - sw / 2),
        -pi / 2,
        2 * pi * ratio,
        false,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = sw
          ..strokeCap = StrokeCap.round);
  }

  @override
  bool shouldRepaint(covariant _DonutPainter o) =>
      o.ratio != ratio || o.color != color;
}


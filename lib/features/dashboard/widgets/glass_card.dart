import 'dart:ui';
import 'package:autovault/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final List<Color>? gradient;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;

  const GlassCard({
    super.key,
    required this.child,
    this.gradient,
    this.padding,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(SizeConfig.w(16)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          width: width,
          height: height,
          padding: padding ?? EdgeInsets.all(SizeConfig.w(16)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeConfig.w(16)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradient ??
                  [
                    cs.surfaceContainerHigh.withValues(alpha: 0.75),
                    cs.surfaceContainerHighest.withValues(alpha: 0.35),
                  ],
            ),
            border: Border.all(
              color: cs.outlineVariant.withValues(alpha: 0.3),
            ),
            boxShadow: [
              BoxShadow(
                color: cs.shadow.withValues(alpha: 0.2),
                blurRadius: SizeConfig.w(12),
                offset: Offset(0, SizeConfig.h(4)),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}


// features/purchases/widgets/step_indicator.dart

import 'package:flutter/material.dart';

class PurchaseStepIndicator extends StatelessWidget {
  const PurchaseStepIndicator({
    super.key,
    required this.steps,
    required this.currentStep,
    required this.skippedSteps,
    required this.onStepTap,
  });

  final List<String> steps;
  final int currentStep;
  final Set<int> skippedSteps;
  final void Function(int) onStepTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs    = theme.colorScheme;

    return Container(
      color: cs.surface,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
      child: Row(
        children: List.generate(steps.length * 2 - 1, (i) {
          if (i.isOdd) {
            // Connector
            final leftIdx   = i ~/ 2;
            final completed = leftIdx < currentStep &&
                !skippedSteps.contains(leftIdx + 1);
            return Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 2,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: completed
                      ? cs.primary
                      : cs.outline.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            );
          }

          final idx      = i ~/ 2;
          final label    = steps[idx];
          final isDone   = idx < currentStep && !skippedSteps.contains(idx);
          final isActive = idx == currentStep;
          final isSkipped = skippedSteps.contains(idx);
          final canTap   = isDone;

          return GestureDetector(
            onTap: canTap ? () => onStepTap(idx) : null,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Dot
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width:  isActive ? 30 : 24,
                  height: isActive ? 30 : 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSkipped
                        ? cs.surfaceVariant
                        : isDone
                            ? cs.primary
                            : isActive
                                ? cs.primary.withOpacity(0.15)
                                : cs.surfaceVariant,
                    border: Border.all(
                      color: isSkipped
                          ? cs.outline.withOpacity(0.2)
                          : (isDone || isActive)
                              ? cs.primary
                              : cs.outline.withOpacity(0.3),
                      width: isActive ? 2 : 1.5,
                    ),
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: cs.primary.withOpacity(0.3),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: isDone
                        ? Icon(Icons.check_rounded,
                            size: 13, color: cs.onPrimary)
                        : isSkipped
                            ? Icon(Icons.remove_rounded,
                                size: 12,
                                color:
                                    cs.onSurfaceVariant.withOpacity(0.4))
                            : isActive
                                ? Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: cs.primary,
                                      shape: BoxShape.circle,
                                    ),
                                  )
                                : Text(
                                    '${idx + 1}',
                                    style: theme.textTheme.labelSmall!
                                        .copyWith(
                                      color: cs.onSurface.withOpacity(0.4),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                  ),
                ),
                const SizedBox(height: 4),
                // Label
                SizedBox(
                  width: 52,
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: theme.textTheme.labelSmall!.copyWith(
                      color: isSkipped
                          ? cs.onSurface.withOpacity(0.25)
                          : (isDone || isActive)
                              ? cs.primary
                              : cs.onSurface.withOpacity(0.4),
                      fontWeight: isActive
                          ? FontWeight.w700
                          : FontWeight.normal,
                      fontSize: 9,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

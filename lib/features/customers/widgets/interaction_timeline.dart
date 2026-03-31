// features/customers/widgets/interaction_timeline.dart

import 'package:flutter/material.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/interaction_model.dart';

class InteractionTimeline extends StatelessWidget {
  const InteractionTimeline({
    super.key,
    required this.interactions,
  });

  final List<InteractionModel> interactions;

  Color _typeColor(InteractionType t) => switch (t) {
        InteractionType.call      => const Color(0xFF1E88E5),
        InteractionType.visit     => const Color(0xFF8E24AA),
        InteractionType.testDrive => const Color(0xFFFFC107),
        InteractionType.purchase  => const Color(0xFF4CAF50),
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs    = theme.colorScheme;

    if (interactions.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Text(
            'No interactions recorded yet.',
            style: theme.textTheme.bodySmall!
                .copyWith(color: cs.onSurface.withOpacity(0.4)),
          ),
        ),
      );
    }

    // Sort newest first
    final sorted = [...interactions]
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return Column(
      children: List.generate(sorted.length, (i) {
        final item    = sorted[i];
        final isLast  = i == sorted.length - 1;
        final tColor  = _typeColor(item.type);

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Timeline spine ─────────────────────────────────────────
              SizedBox(
                width: 40,
                child: Column(
                  children: [
                    // Dot
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: tColor.withOpacity(0.15),
                        shape: BoxShape.circle,
                        border: Border.all(color: tColor.withOpacity(0.6)),
                      ),
                      child: Center(
                        child: Text(
                          item.type.emoji,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    // Line
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2,
                          color: cs.outline.withOpacity(0.15),
                          margin: const EdgeInsets.symmetric(vertical: 2),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 10),

              // ── Content ────────────────────────────────────────────────
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: isLast ? 0 : 20, top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: tColor.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              item.type.label,
                              style: theme.textTheme.labelSmall!.copyWith(
                                color: tColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            dateFormatter.format(item.timestamp),
                            style: theme.textTheme.labelSmall!.copyWith(
                              color: cs.onSurface.withOpacity(0.4),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        item.note,
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: cs.onSurface.withOpacity(0.75),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

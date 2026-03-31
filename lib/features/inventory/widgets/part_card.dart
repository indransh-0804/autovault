import 'package:autovault/data/models/part_model.dart';
import 'package:autovault/features/inventory/providers/parts_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final _inrFmt =
    NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 0);

class PartCard extends ConsumerWidget {
  const PartCard({
    super.key,
    required this.part,
    required this.isOwner,
    required this.onEdit,
  });

  final PartModel part;
  final bool isOwner;
  final VoidCallback onEdit;

  Color _stockColor(StockStatus s) => switch (s) {
        StockStatus.inStock => const Color(0xFF4CAF50),
        StockStatus.lowStock => const Color(0xFFFFC107),
        StockStatus.outOfStock => const Color(0xFFF44336),
      };

  void _showOwnerSheet(BuildContext ctx, WidgetRef ref) {
    showModalBottomSheet(
      context: ctx,
      backgroundColor: Theme.of(ctx).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color:
                    Theme.of(ctx).colorScheme.onSurfaceVariant.withOpacity(0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(part.name,
                  style: Theme.of(ctx).textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ),
            const Divider(height: 24),
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text('Edit Part'),
              onTap: () {
                Navigator.pop(ctx);
                onEdit();
              },
              dense: true,
            ),
            ListTile(
              leading: Icon(Icons.delete_outline,
                  color: Theme.of(ctx).colorScheme.error),
              title: Text('Delete',
                  style: TextStyle(color: Theme.of(ctx).colorScheme.error)),
              onTap: () {
                ref.read(partsNotifierProvider.notifier).deletePart(part.id);
                Navigator.pop(ctx);
              },
              dense: true,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final status = part.stockStatus;
    final sColor = _stockColor(status);
    final isLow = status != StockStatus.inStock;

    return GestureDetector(
      onLongPress: isOwner ? () => _showOwnerSheet(context, ref) : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                isLow ? sColor.withOpacity(0.35) : cs.outline.withOpacity(0.15),
          ),
        ),
        child: Row(
          children: [
            // ── Category icon ──────────────────────────────────────────────
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: cs.primaryContainer.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(_categoryIcon(part.category),
                  color: cs.primary, size: 22),
            ),
            const SizedBox(width: 12),

            // ── Main content ───────────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    part.name,
                    style: theme.textTheme.titleSmall!
                        .copyWith(fontWeight: FontWeight.w700),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    part.partNumber,
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: cs.onSurface.withOpacity(0.5),
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    part.supplierName,
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: cs.onSurface.withOpacity(0.45),
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      // Qty
                      if (isLow) ...[
                        Icon(Icons.warning_amber_rounded,
                            size: 14, color: sColor),
                        const SizedBox(width: 3),
                      ],
                      Text(
                        '${part.quantity} units',
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: isLow ? sColor : cs.onSurface.withOpacity(0.7),
                          fontWeight:
                              isLow ? FontWeight.w700 : FontWeight.normal,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Reorder at: ${part.reorderLevel}',
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: cs.onSurface.withOpacity(0.4),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Right column: price + badge ────────────────────────────────
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _inrFmt.format(part.unitPrice),
                  style: theme.textTheme.titleSmall!.copyWith(
                    color: cs.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: sColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: sColor.withOpacity(0.5)),
                  ),
                  child: Text(
                    part.stockLabel,
                    style: theme.textTheme.labelSmall!.copyWith(
                      color: sColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _categoryIcon(PartCategory cat) => switch (cat) {
        PartCategory.engine => Icons.settings_outlined,
        PartCategory.brakes => Icons.album_outlined,
        PartCategory.electrical => Icons.bolt_outlined,
        PartCategory.body => Icons.car_repair_outlined,
        PartCategory.tyres => Icons.tire_repair_outlined,
        PartCategory.interior => Icons.weekend_outlined,
        PartCategory.other => Icons.category_outlined,
      };
}

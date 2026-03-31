import 'package:autovault/data/models/car_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final _inrFmt =
    NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 0);

class CarCard extends ConsumerWidget {
  const CarCard({
    super.key,
    required this.car,
    required this.isOwner,
    required this.onTap,
    required this.onEdit,
  });

  final CarModel car;
  final bool isOwner;
  final VoidCallback onTap;
  final VoidCallback onEdit;

  Color _statusColor(CarStatus s) => switch (s) {
        CarStatus.available => const Color(0xFF4CAF50),
        CarStatus.reserved => const Color(0xFFFFC107),
        CarStatus.sold => const Color(0xFF9E9E9E),
      };

  bool _isAttention(CarStatus s) =>
      s == CarStatus.reserved || s == CarStatus.sold;

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
              child: Text(
                '${car.make} ${car.model}',
                style: Theme.of(ctx).textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Divider(height: 24),
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text('Edit Car'),
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
                // fix provider name if needed
                // ref.read(carsNotifierProvider.notifier).deleteCar(car.id);
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

    final status = car.status;
    final sColor = _statusColor(status);
    final isAttention = _isAttention(status);

    return GestureDetector(
      onTap: onTap,
      onLongPress: isOwner ? () => _showOwnerSheet(context, ref) : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isAttention
                ? sColor.withOpacity(0.35)
                : cs.outline.withOpacity(0.15),
          ),
        ),
        child: Row(
          children: [
            // ── Icon ─────────────────────────────
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: cs.primaryContainer.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.directions_car_outlined,
                  color: cs.primary, size: 22),
            ),
            const SizedBox(width: 12),

            // ── Main content ─────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${car.make} ${car.model}',
                    style: theme.textTheme.titleSmall!
                        .copyWith(fontWeight: FontWeight.w700),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),

                  // VIN
                  Text(
                    car.vin,
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: cs.onSurface.withOpacity(0.5),
                      fontSize: 11,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Details row
                  Text(
                    '${car.year} • ${car.fuelType.label} • ${car.transmission.label}',
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: cs.onSurface.withOpacity(0.45),
                      fontSize: 11,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      if (isAttention) ...[
                        Icon(Icons.info_outline, size: 14, color: sColor),
                        const SizedBox(width: 3),
                      ],
                      Text(
                        car.status.label,
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: isAttention
                              ? sColor
                              : cs.onSurface.withOpacity(0.7),
                          fontWeight:
                              isAttention ? FontWeight.w700 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Right column ─────────────────────
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _inrFmt.format(car.sellingPrice),
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
                    car.status.label,
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
}

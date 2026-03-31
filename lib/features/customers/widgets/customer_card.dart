import 'package:autovault/core/utils/formatters.dart';
import 'package:autovault/data/models/customer_model.dart';
import 'package:autovault/features/customers/providers/customers_provider.dart';
import 'package:autovault/features/shared/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerCard extends ConsumerWidget {
  const CustomerCard({
    super.key,
    required this.customer,
    required this.isOwner,
    required this.onTap,
    required this.onEdit,
  });

  final CustomerModel customer;
  final bool isOwner;
  final VoidCallback onTap;
  final VoidCallback onEdit;

  // ── Status badge ──────────────────────────────────────────────────────────

  Color _statusColor(LeadStatus s) => switch (s) {
        LeadStatus.hotLead => const Color(0xFFF44336),
        LeadStatus.followUp => const Color(0xFFFFC107),
        LeadStatus.converted => const Color(0xFF4CAF50),
        LeadStatus.inactive => const Color(0xFF9E9E9E),
      };

  void _showOwnerSheet(BuildContext ctx, WidgetRef ref) {
    showModalBottomSheet(
      context: ctx,
      backgroundColor: Theme.of(ctx).colorScheme.surface,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
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
                    Theme.of(ctx).colorScheme.onSurfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(customer.fullName,
                  style: Theme.of(ctx).textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ),
            const Divider(height: 24),
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text('Edit Customer'),
              onTap: () {
                Navigator.pop(ctx);
                onEdit();
              },
              dense: true,
            ),
            ListTile(
              leading: const Icon(Icons.swap_horiz_rounded),
              title: const Text('Reassign to Employee'),
              onTap: () {
                Navigator.pop(ctx);
                // TODO: open employee picker sheet
                ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(
                      content: Text('Reassign — wire to employeesProvider')),
                );
              },
              dense: true,
            ),
            ListTile(
              leading: Icon(Icons.delete_outline,
                  color: Theme.of(ctx).colorScheme.error),
              title: Text('Delete Customer',
                  style: TextStyle(color: Theme.of(ctx).colorScheme.error)),
              onTap: () {
                ref
                    .read(customersNotifierProvider.notifier)
                    .deleteCustomer(customer.id);
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
    final sColor = _statusColor(customer.leadStatus);

    return GestureDetector(
      onTap: onTap,
      onLongPress: isOwner ? () => _showOwnerSheet(context, ref) : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: cs.outline.withOpacity(0.15)),
        ),
        child: Row(
          children: [
            // Avatar
            AvatarWidget(name: customer.fullName, radius: 26),
            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + status badge
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          customer.fullName,
                          style: theme.textTheme.titleSmall!
                              .copyWith(fontWeight: FontWeight.w700),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _StatusBadge(status: customer.leadStatus, color: sColor),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    customer.phone,
                    style: theme.textTheme.bodySmall!
                        .copyWith(color: cs.onSurface.withOpacity(0.55)),
                  ),
                  if (customer.email.isNotEmpty) ...[
                    const SizedBox(height: 1),
                    Text(
                      customer.email,
                      style: theme.textTheme.bodySmall!.copyWith(
                          color: cs.onSurface.withOpacity(0.45), fontSize: 11),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      // Assigned employee chip (owner only)
                      if (isOwner &&
                          customer.assignedEmployeeName.isNotEmpty) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: cs.primaryContainer.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            customer.assignedEmployeeName,
                            style: theme.textTheme.labelSmall!.copyWith(
                              color: cs.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      // Purchases count
                      if (customer.purchaseIds.isNotEmpty) ...[
                        Icon(Icons.shopping_bag_outlined,
                            size: 12, color: cs.onSurface.withOpacity(0.4)),
                        const SizedBox(width: 3),
                        Text(
                          '${customer.purchaseIds.length}',
                          style: theme.textTheme.labelSmall!
                              .copyWith(color: cs.onSurface.withOpacity(0.4)),
                        ),
                        const SizedBox(width: 8),
                      ],
                      const Spacer(),
                      // Last interaction
                      Text(
                        dateFormatter.format(customer.lastInteractionAt),
                        style: theme.textTheme.labelSmall!.copyWith(
                            color: cs.onSurface.withOpacity(0.4), fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Status badge ─────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status, required this.color});
  final LeadStatus status;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Text(
          status.label,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: 10,
              ),
        ),
      );
}

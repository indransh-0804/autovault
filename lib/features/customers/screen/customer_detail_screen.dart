import 'package:autovault/features/customers/providers/customers_provider.dart';
import 'package:autovault/features/shared/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:autovault/core/utils/formatters.dart';
import 'package:autovault/data/models/customer_model.dart';
import 'package:autovault/data/mock/customer_mock_data.dart';
import 'package:autovault/features/customers/widgets/add_edit_customer_sheet.dart';
import 'package:autovault/features/customers/widgets/interaction_timeline.dart';
import 'package:autovault/features/customers/widgets/loan_summary_card.dart';

// Journey stages
const _journeyStages = [
  'Lead',
  'Contacted',
  'Test Drive',
  'Purchase',
  'Converted',
];

int _stageIndex(CustomerModel c) {
  if (c.purchaseIds.isNotEmpty) return 3;
  if (c.leadStatus == LeadStatus.converted) return 4;
  if (c.testDriveIds.isNotEmpty) return 2;
  if (c.leadStatus == LeadStatus.followUp) return 1;
  return 0;
}

class CustomerDetailScreen extends ConsumerWidget {
  const CustomerDetailScreen({super.key, required this.customer});
  final CustomerModel customer;

  void _openEditSheet(BuildContext ctx, CustomerModel c) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddEditCustomerSheet(existingCustomer: c),
    );
  }

  // Latest customer state from provider (in case edits happened)
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latest = ref.watch(customerByIdProvider(customer.id)) ?? customer;
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final interactions = mockInteractions
        .where((i) => i.customerId == latest.id)
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    final purchases =
        mockPurchases.where((p) => p.customerId == latest.id).toList();

    final loans =
        mockLoanSummaries.where((l) => l.customerId == latest.id).toList();

    return Scaffold(
      backgroundColor: cs.surface,
      body: CustomScrollView(
        slivers: [
          // ── Collapsing Header ──────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            backgroundColor: cs.surface,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () => context.pop(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () => _openEditSheet(context, latest),
                tooltip: 'Edit',
              ),
              const SizedBox(width: 4),
            ],
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.fromLTRB(56, 0, 56, 14),
              background: _ExpandedHeader(customer: latest),
            ),
          ),

          // ── Body ──────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Quick actions
                  _QuickActions(customer: latest),
                  const SizedBox(height: 20),

                  // Info card
                  _InfoCard(customer: latest, theme: theme, cs: cs),
                  const SizedBox(height: 20),

                  // Journey stepper
                  _SectionHeader(title: 'Customer Journey', theme: theme),
                  const SizedBox(height: 12),
                  _JourneyStepper(
                      stageIndex: _stageIndex(latest), theme: theme, cs: cs),
                  const SizedBox(height: 20),

                  // Activity timeline
                  _SectionHeader(title: 'Activity Timeline', theme: theme),
                  const SizedBox(height: 12),
                  InteractionTimeline(interactions: interactions),
                  const SizedBox(height: 20),

                  // Purchase history
                  _SectionHeader(title: 'Purchase History', theme: theme),
                  const SizedBox(height: 12),
                  if (purchases.isEmpty)
                    _EmptySection(
                      icon: Icons.receipt_long_outlined,
                      message: 'No purchases yet',
                    )
                  else
                    ...purchases.map((p) =>
                        _PurchaseTile(purchase: p, theme: theme, cs: cs)),
                  const SizedBox(height: 20),

                  // Loans
                  if (loans.isNotEmpty) ...[
                    _SectionHeader(title: 'Active Loan', theme: theme),
                    const SizedBox(height: 12),
                    ...loans.map((l) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: LoanSummaryCard(loanId: l.loanId),
                        )),
                    const SizedBox(height: 8),
                  ],

                  // Test drives
                  _SectionHeader(title: 'Test Drives', theme: theme),
                  const SizedBox(height: 12),
                  if (latest.testDriveIds.isEmpty)
                    _EmptySection(
                      icon: Icons.directions_car_outlined,
                      message: 'No upcoming test drives',
                      actionLabel: 'Schedule One',
                      onAction: () => ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                              content:
                                  Text('Test drive scheduling — coming soon'))),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: cs.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: cs.outline.withOpacity(0.15)),
                      ),
                      child: Text(
                        '${latest.testDriveIds.length} test drive(s) on record.\nFull view coming in Test Drive module.',
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: cs.onSurface.withOpacity(0.5)),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openEditSheet(context, latest),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        child: const Icon(Icons.edit_rounded),
      ),
    );
  }
}

// ─── Expanded Header ──────────────────────────────────────────────────────────

class _ExpandedHeader extends StatelessWidget {
  const _ExpandedHeader({required this.customer});
  final CustomerModel customer;

  Color _statusColor(LeadStatus s) => switch (s) {
        LeadStatus.hotLead => const Color(0xFFF44336),
        LeadStatus.followUp => const Color(0xFFFFC107),
        LeadStatus.converted => const Color(0xFF4CAF50),
        LeadStatus.inactive => const Color(0xFF9E9E9E),
      };

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    final sColor = _statusColor(customer.leadStatus);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            cs.primary.withOpacity(0.25),
            cs.surface,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 48, 20, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AvatarWidget(name: customer.fullName, radius: 36),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customer.fullName,
                      style: theme.textTheme.titleLarge!
                          .copyWith(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: sColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: sColor.withOpacity(0.5)),
                      ),
                      child: Text(
                        customer.leadStatus.label,
                        style: theme.textTheme.labelSmall!.copyWith(
                          color: sColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Since ${dateFormatter.format(customer.createdAt)}',
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: cs.onSurface.withOpacity(0.5)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Quick Actions ────────────────────────────────────────────────────────────

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.customer});
  final CustomerModel customer;

  @override
  Widget build(BuildContext context) {
    void snack(String msg) => ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));

    return Row(
      children: [
        _ActionBtn(
          icon: Icons.call_rounded,
          label: 'Call',
          color: const Color(0xFF4CAF50),
          onTap: () => snack('url_launcher: tel:${customer.phone}'),
        ),
        const SizedBox(width: 12),
        _ActionBtn(
          icon: Icons.chat_rounded,
          label: 'WhatsApp',
          color: const Color(0xFF25D366),
          onTap: () => snack(
              'url_launcher: https://wa.me/${customer.phone.replaceAll('+', '')}'),
        ),
        const SizedBox(width: 12),
        _ActionBtn(
          icon: Icons.mail_outline_rounded,
          label: 'Email',
          color: const Color(0xFF1E88E5),
          onTap: () => snack('url_launcher: mailto:${customer.email}'),
        ),
      ],
    );
  }
}

class _ActionBtn extends StatelessWidget {
  const _ActionBtn({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(height: 4),
              Text(label,
                  style: theme.textTheme.labelSmall!
                      .copyWith(color: color, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Info Card ────────────────────────────────────────────────────────────────

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.customer,
    required this.theme,
    required this.cs,
  });
  final CustomerModel customer;
  final ThemeData theme;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: cs.outline.withOpacity(0.15)),
        ),
        child: Column(
          children: [
            _InfoRow('Phone', customer.phone, theme, cs),
            if (customer.email.isNotEmpty)
              _InfoRow('Email', customer.email, theme, cs),
            if (customer.dateOfBirth != null)
              _InfoRow('Date of Birth', formatDobWithAge(customer.dateOfBirth!),
                  theme, cs),
            if (customer.address.isNotEmpty)
              _InfoRow('Address', customer.address, theme, cs),
            if (customer.assignedEmployeeName.isNotEmpty)
              _InfoRow('Assigned To', customer.assignedEmployeeName, theme, cs),
            _InfoRow('Customer Since', dateFormatter.format(customer.createdAt),
                theme, cs),
            if (customer.notes.isNotEmpty)
              _InfoRow('Notes', customer.notes, theme, cs, isLast: true),
          ],
        ),
      );
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.label, this.value, this.theme, this.cs,
      {this.isLast = false});
  final String label;
  final String value;
  final ThemeData theme;
  final ColorScheme cs;
  final bool isLast;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 110,
                  child: Text(label,
                      style: theme.textTheme.bodySmall!.copyWith(
                        color: cs.onSurface.withOpacity(0.45),
                        fontWeight: FontWeight.w600,
                      )),
                ),
                Expanded(
                  child: Text(value,
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: cs.onSurface.withOpacity(0.85))),
                ),
              ],
            ),
          ),
          if (!isLast) Divider(height: 1, color: cs.outline.withOpacity(0.1)),
        ],
      );
}

// ─── Journey Stepper ──────────────────────────────────────────────────────────

class _JourneyStepper extends StatelessWidget {
  const _JourneyStepper({
    required this.stageIndex,
    required this.theme,
    required this.cs,
  });
  final int stageIndex;
  final ThemeData theme;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) => Row(
        children: List.generate(_journeyStages.length * 2 - 1, (i) {
          if (i.isOdd) {
            // Connector line
            final filled = (i ~/ 2) < stageIndex;
            return Expanded(
              child: Container(
                height: 2,
                color: filled ? cs.primary : cs.outline.withOpacity(0.2),
              ),
            );
          }
          final idx = i ~/ 2;
          final active = idx == stageIndex;
          final done = idx < stageIndex;
          final dotColor =
              (active || done) ? cs.primary : cs.outline.withOpacity(0.3);

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: active ? 28 : 22,
                height: active ? 28 : 22,
                decoration: BoxDecoration(
                  color: done
                      ? cs.primary
                      : active
                          ? cs.primary.withOpacity(0.15)
                          : cs.surfaceVariant,
                  shape: BoxShape.circle,
                  border: Border.all(color: dotColor, width: active ? 2 : 1.5),
                ),
                child: done
                    ? Icon(Icons.check_rounded, size: 14, color: cs.onPrimary)
                    : active
                        ? Center(
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: cs.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          )
                        : null,
              ),
              const SizedBox(height: 5),
              Text(
                _journeyStages[idx],
                style: theme.textTheme.labelSmall!.copyWith(
                  color: (active || done)
                      ? cs.primary
                      : cs.onSurface.withOpacity(0.35),
                  fontWeight: active ? FontWeight.w700 : FontWeight.normal,
                  fontSize: 9,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        }),
      );
}

// ─── Purchase Tile ────────────────────────────────────────────────────────────

class _PurchaseTile extends StatelessWidget {
  const _PurchaseTile({
    required this.purchase,
    required this.theme,
    required this.cs,
  });
  final MockPurchaseEntry purchase;
  final ThemeData theme;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: cs.outline.withOpacity(0.15)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: cs.primaryContainer.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.directions_car_rounded,
                  color: cs.primary, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${purchase.carMakeModel} (${purchase.year})',
                    style: theme.textTheme.bodyMedium!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    dateFormatter.format(purchase.date),
                    style: theme.textTheme.bodySmall!
                        .copyWith(color: cs.onSurface.withOpacity(0.5)),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  inrFormatter.format(purchase.amount),
                  style: theme.textTheme.titleSmall!.copyWith(
                    color: cs.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: (purchase.paymentType == 'Loan'
                                ? const Color(0xFF1E88E5)
                                : const Color(0xFF4CAF50))
                            .withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        purchase.paymentType,
                        style: theme.textTheme.labelSmall!.copyWith(
                          color: purchase.paymentType == 'Loan'
                              ? const Color(0xFF1E88E5)
                              : const Color(0xFF4CAF50),
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    if (purchase.loanId != null) ...[
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Loan detail — coming soon'))),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: cs.primary.withOpacity(0.4)),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'View Loan',
                            style: theme.textTheme.labelSmall!.copyWith(
                              color: cs.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ],
        ),
      );
}

// ─── Helpers ──────────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.theme});
  final String title;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => Text(
        title,
        style:
            theme.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w700),
      );
}

class _EmptySection extends StatelessWidget {
  const _EmptySection({
    required this.icon,
    required this.message,
    this.actionLabel,
    this.onAction,
  });
  final IconData icon;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceVariant.withOpacity(0.2),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.outline.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: cs.onSurface.withOpacity(0.3)),
          const SizedBox(width: 10),
          Text(message,
              style: theme.textTheme.bodySmall!
                  .copyWith(color: cs.onSurface.withOpacity(0.45))),
          if (actionLabel != null) ...[
            const Spacer(),
            GestureDetector(
              onTap: onAction,
              child: Text(
                actionLabel!,
                style: theme.textTheme.labelSmall!
                    .copyWith(color: cs.primary, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

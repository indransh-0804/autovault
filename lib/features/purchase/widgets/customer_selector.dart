import 'package:autovault/data/models/customer_model.dart';
import 'package:autovault/features/customers/providers/customers_provider.dart';
import 'package:autovault/features/purchase/providers/purchase_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerSelector extends ConsumerStatefulWidget {
  const CustomerSelector({
    super.key,
    required this.onAddNew,
  });
  final VoidCallback onAddNew;

  @override
  ConsumerState<CustomerSelector> createState() => _CustomerSelectorState();
}

class _CustomerSelectorState extends ConsumerState<CustomerSelector> {
  final _searchCtr = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final formState = ref.watch(purchaseFormNotifierProvider);
    final selected = formState.selectedCustomer;

    final customers = ref
        .watch(allCustomersProvider)
        .where((c) =>
            _query.isEmpty ||
            c.fullName.toLowerCase().contains(_query.toLowerCase()) ||
            c.phone.contains(_query))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (selected != null) ...[
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: cs.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: cs.primary.withOpacity(0.4)),
            ),
            child: Row(
              children: [
                Icon(Icons.person_rounded, size: 16, color: cs.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(selected.fullName,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                            color: cs.primary,
                          )),
                      Text(selected.phone,
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: cs.primary.withOpacity(0.7))),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close_rounded, size: 18, color: cs.primary),
                  onPressed: () => ref
                      .read(purchaseFormNotifierProvider.notifier)
                      .clearCustomer(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
        ],

        // ── Search ───────────────────────────────────────────────────────
        TextField(
          controller: _searchCtr,
          onChanged: (v) => setState(() => _query = v),
          decoration: InputDecoration(
            hintText: 'Search customer by name or phone…',
            prefixIcon: const Icon(Icons.search, size: 20),
            suffixIcon: _query.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, size: 18),
                    onPressed: () {
                      _searchCtr.clear();
                      setState(() => _query = '');
                    },
                  )
                : null,
            filled: true,
            fillColor: cs.surfaceVariant.withOpacity(0.5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
        const SizedBox(height: 10),

        // ── List ─────────────────────────────────────────────────────────
        if (customers.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: Text('No customers found',
                  style: theme.textTheme.bodySmall!
                      .copyWith(color: cs.onSurface.withOpacity(0.4))),
            ),
          )
        else
          ...customers.map((c) => _CompactCustomerTile(
                customer: c,
                isSelected: selected?.id == c.id,
                onTap: () => ref
                    .read(purchaseFormNotifierProvider.notifier)
                    .selectCustomer(c),
              )),

        const SizedBox(height: 8),

        // ── Add new ──────────────────────────────────────────────────────
        OutlinedButton.icon(
          onPressed: widget.onAddNew,
          icon: const Icon(Icons.person_add_alt_1_rounded, size: 18),
          label: const Text('New Customer'),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: cs.primary.withOpacity(0.5)),
            foregroundColor: cs.primary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }
}

class _CompactCustomerTile extends StatelessWidget {
  const _CompactCustomerTile({
    required this.customer,
    required this.isSelected,
    required this.onTap,
  });
  final CustomerModel customer;
  final bool isSelected;
  final VoidCallback onTap;

  Color _statusColor(LeadStatus s) => switch (s) {
        LeadStatus.hotLead => const Color(0xFFF44336),
        LeadStatus.followUp => const Color(0xFFFFC107),
        LeadStatus.converted => const Color(0xFF4CAF50),
        LeadStatus.inactive => const Color(0xFF9E9E9E),
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final sColor = _statusColor(customer.leadStatus);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? cs.primary.withOpacity(0.08) : cs.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? cs.primary : cs.outline.withOpacity(0.15),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(Icons.check_circle_rounded,
                    color: cs.primary, size: 18),
              ),
            Expanded(
              child: Text(customer.fullName,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isSelected ? cs.primary : cs.onSurface,
                  )),
            ),
            Text(customer.phone,
                style: theme.textTheme.bodySmall!
                    .copyWith(color: cs.onSurface.withOpacity(0.5))),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: sColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(customer.leadStatus.label,
                  style: theme.textTheme.labelSmall!.copyWith(
                    color: sColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

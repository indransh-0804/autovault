import 'package:autovault/data/models/customer_model.dart';
import 'package:autovault/features/auth/providers/auth_provider.dart';
import 'package:autovault/features/customers/providers/customers_provider.dart';
import 'package:autovault/features/customers/widgets/add_edit_customer_sheet.dart';
import 'package:autovault/features/customers/widgets/customer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _devIsOwnerProvider = StateProvider<bool>((ref) => true);

const _statusFilters = [
  'All',
  'Hot Lead',
  'Follow-up',
  'Converted',
  'Inactive'
];
const _sortOptions = ['Recent', 'Name A–Z', 'Most Purchases'];

class CustomersListScreen extends ConsumerStatefulWidget {
  const CustomersListScreen({super.key});

  @override
  ConsumerState<CustomersListScreen> createState() =>
      _CustomersListScreenState();
}

class _CustomersListScreenState extends ConsumerState<CustomersListScreen> {
  final _searchCtr = TextEditingController();
  String _query = '';
  String _statusFilter = 'All';
  String _sortBy = 'Recent';

  @override
  void dispose() {
    _searchCtr.dispose();
    super.dispose();
  }

  void _openAddSheet([CustomerModel? existing]) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddEditCustomerSheet(existingCustomer: existing),
    );
  }

  void _showSortSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
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
                color: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant
                    .withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 4),
              child: Text('Sort By',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w700)),
            ),
            const Divider(),
            ..._sortOptions.map(
              (opt) => ListTile(
                title: Text(opt),
                trailing: _sortBy == opt
                    ? Icon(Icons.check_rounded,
                        color: Theme.of(context).colorScheme.primary)
                    : null,
                onTap: () {
                  setState(() => _sortBy = opt);
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isOwner = ref.watch(currentUserProvider)!.isOwner;

    final customers = ref.watch(filteredCustomersProvider(
      query: _query,
      statusFilter: _statusFilter,
      sortBy: _sortBy,
    ));

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text('Customers',
            style: theme.textTheme.titleMedium!
                .copyWith(fontWeight: FontWeight.w800)),
      ),
      body: Column(
        children: [
          // ── Search ──────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: TextField(
              controller: _searchCtr,
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: 'Search by name, phone or email…',
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
          ),
          const SizedBox(height: 10),

          // ── Status filter chips ──────────────────────────────────────────
          SizedBox(
            height: 36,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _statusFilters.length,
              itemBuilder: (_, i) {
                final f = _statusFilters[i];
                final sel = f == _statusFilter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(f),
                    selected: sel,
                    onSelected: (_) => setState(() => _statusFilter = f),
                    selectedColor: cs.primary,
                    backgroundColor: Colors.transparent,
                    labelStyle: TextStyle(
                      color: sel ? cs.onPrimary : cs.onSurface,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                    side: BorderSide(
                        color: sel ? cs.primary : cs.outline.withOpacity(0.4)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 6),

          // ── Sort row ─────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  '${customers.length} customer${customers.length == 1 ? '' : 's'}',
                  style: theme.textTheme.bodySmall!
                      .copyWith(color: cs.onSurface.withOpacity(0.5)),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: _showSortSheet,
                  child: Row(
                    children: [
                      Icon(Icons.sort_rounded, size: 16, color: cs.primary),
                      const SizedBox(width: 4),
                      Text(
                        _sortBy,
                        style: theme.textTheme.labelMedium!.copyWith(
                          color: cs.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),

          // ── List ─────────────────────────────────────────────────────────
          Expanded(
            child: customers.isEmpty
                ? _EmptyState(
                    isFiltered: _query.isNotEmpty || _statusFilter != 'All',
                    onAdd: _openAddSheet,
                  )
                : AnimatedList(
                    key: ValueKey(customers.length),
                    initialItemCount: customers.length,
                    itemBuilder: (ctx, idx, animation) {
                      if (idx >= customers.length)
                        return const SizedBox.shrink();
                      final c = customers[idx];
                      return SizeTransition(
                        sizeFactor: animation,
                        child: CustomerCard(
                          customer: c,
                          isOwner: isOwner,
                          onTap: () => ctx.push('/customers/${c.id}', extra: c),
                          onEdit: () => _openAddSheet(c),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddSheet,
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        icon: const Icon(Icons.person_add_alt_1_rounded),
        label: const Text('Add Customer',
            style: TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }
}

// ─── Empty State ──────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.isFiltered, required this.onAdd});
  final bool isFiltered;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.people_outline_rounded,
                size: 72, color: cs.onSurfaceVariant.withOpacity(0.25)),
            const SizedBox(height: 20),
            Text(
              isFiltered ? 'No customers found' : 'No customers yet',
              style: theme.textTheme.titleMedium!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              isFiltered
                  ? 'Try a different search or filter'
                  : 'Add your first customer to get started',
              style: theme.textTheme.bodySmall!
                  .copyWith(color: cs.onSurface.withOpacity(0.5)),
              textAlign: TextAlign.center,
            ),
            if (!isFiltered) ...[
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.person_add_alt_1_rounded),
                label: const Text('Add your first customer'),
                style: FilledButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

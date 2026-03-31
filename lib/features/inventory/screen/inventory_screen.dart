import 'package:autovault/data/models/car_model.dart';
import 'package:autovault/data/models/part_model.dart';
import 'package:autovault/features/auth/providers/auth_provider.dart';
import 'package:autovault/features/inventory/providers/cars_provider.dart';
import 'package:autovault/features/inventory/providers/parts_provider.dart';
import 'package:autovault/features/inventory/widgets/add_edit_car_sheet.dart';
import 'package:autovault/features/inventory/widgets/add_edit_part_sheet.dart';
import 'package:autovault/features/inventory/widgets/car_card.dart';
import 'package:autovault/features/inventory/widgets/part_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _devIsOwnerProvider = StateProvider<bool>((ref) => true);

class InventoryScreen extends ConsumerStatefulWidget {
  const InventoryScreen({super.key});

  @override
  ConsumerState<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends ConsumerState<InventoryScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showAddCarSheet([CarModel? existing]) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddEditCarSheet(existingCar: existing),
    );
  }

  void _showAddPartSheet([PartModel? existing]) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddEditPartSheet(existingPart: existing),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isOwner = ref.watch(currentUserProvider)!.isOwner;
    final isCarsTab = _tabController.index == 0;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Inventory',
          style:
              theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w800),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: _StyledTabBar(controller: _tabController),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _CarsTab(
            isOwner: !isOwner,
            onAddCar: _showAddCarSheet,
            onEditCar: _showAddCarSheet,
          ),
          _PartsTab(
            isOwner: !isOwner,
            onAddPart: _showAddPartSheet,
            onEditPart: _showAddPartSheet,
          ),
        ],
      ),
      floatingActionButton: !isOwner
          ? FloatingActionButton.extended(
              onPressed: isCarsTab
                  ? () => _showAddCarSheet()
                  : () => _showAddPartSheet(),
              backgroundColor: cs.primaryContainer,
              foregroundColor: cs.onPrimaryContainer,
              icon: const Icon(Icons.add),
              label: Text(
                isCarsTab ? 'Add Car' : 'Add Part',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            )
          : null,
    );
  }
}

// ─── Custom TabBar ─────────────────────────────────────────────────────────────

class _StyledTabBar extends StatelessWidget {
  const _StyledTabBar({required this.controller});
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      height: 40,
      decoration: BoxDecoration(
        color: cs.surfaceVariant.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: controller,
        indicator: BoxDecoration(
          color: cs.primaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: cs.onPrimaryContainer,
        unselectedLabelColor: cs.onSurfaceVariant,
        labelStyle: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(fontWeight: FontWeight.w700),
        tabs: const [
          Tab(text: 'Cars'),
          Tab(text: 'Parts'),
        ],
      ),
    );
  }
}

// ─── Cars Tab ─────────────────────────────────────────────────────────────────

class _CarsTab extends ConsumerStatefulWidget {
  const _CarsTab({
    required this.isOwner,
    required this.onAddCar,
    required this.onEditCar,
  });
  final bool isOwner;
  final VoidCallback onAddCar;
  final void Function(CarModel) onEditCar;

  @override
  ConsumerState<_CarsTab> createState() => _CarsTabState();
}

class _CarsTabState extends ConsumerState<_CarsTab> {
  final _searchCtr = TextEditingController();
  String _query = '';
  String _filter = 'All';

  static const _filters = [
    'All',
    'Available',
    'Reserved',
    'Sold',
    'New',
    'Used'
  ];

  @override
  void dispose() {
    _searchCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final cars = ref.watch(filteredCarsProvider(
      query: _query,
      statusFilter: _filter,
    ));

    return Column(
      children: [
        // ── Search + filter ────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: TextField(
            controller: _searchCtr,
            onChanged: (v) => setState(() => _query = v),
            decoration: InputDecoration(
              hintText: 'Search by make, model or VIN…',
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
        SizedBox(
          height: 36,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _filters.length,
            itemBuilder: (ctx, i) {
              final f = _filters[i];
              final selected = f == _filter;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(f),
                  selected: selected,
                  onSelected: (_) => setState(() => _filter = f),
                  selectedColor: cs.primary,
                  backgroundColor: Colors.transparent,
                  labelStyle: TextStyle(
                    color: selected ? cs.onPrimary : cs.onSurface,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  side: BorderSide(
                    color: selected ? cs.primary : cs.outline.withOpacity(0.4),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 4),

        // ── List ───────────────────────────────────────────────────────────
        Expanded(
          child: cars.isEmpty
              ? _CarsEmptyState(
                  isOwner: widget.isOwner,
                  isFiltered: _query.isNotEmpty || _filter != 'All',
                  onAdd: widget.onAddCar,
                )
              : AnimatedList(
                  key: ValueKey(cars.length),
                  initialItemCount: cars.length,
                  itemBuilder: (ctx, idx, animation) {
                    if (idx >= cars.length) return const SizedBox.shrink();
                    final car = cars[idx];
                    return SizeTransition(
                      sizeFactor: animation,
                      child: CarCard(
                        car: car,
                        isOwner: widget.isOwner,
                        onTap: () {
                          // Navigate to car detail placeholder
                          ctx.push('/inventory/car/${car.id}', extra: car);
                        },
                        onEdit: () => widget.onEditCar(car),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

// ─── Parts Tab ────────────────────────────────────────────────────────────────

class _PartsTab extends ConsumerStatefulWidget {
  const _PartsTab({
    required this.isOwner,
    required this.onAddPart,
    required this.onEditPart,
  });
  final bool isOwner;
  final VoidCallback onAddPart;
  final void Function(PartModel) onEditPart;

  @override
  ConsumerState<_PartsTab> createState() => _PartsTabState();
}

class _PartsTabState extends ConsumerState<_PartsTab> {
  final _searchCtr = TextEditingController();
  final _listKey = GlobalKey<AnimatedListState>();
  String _query = '';
  String _filter = 'All';

  static const _categories = [
    'All',
    'Engine',
    'Brakes',
    'Electrical',
    'Body',
    'Tyres',
    'Interior',
    'Other',
  ];

  @override
  void dispose() {
    _searchCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final parts = ref.watch(filteredPartsProvider(
      query: _query,
      categoryFilter: _filter,
    ));
    final lowStock = ref.watch(lowStockPartsProvider);

    return Column(
      children: [
        // ── Search ─────────────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: TextField(
            controller: _searchCtr,
            onChanged: (v) => setState(() => _query = v),
            decoration: InputDecoration(
              hintText: 'Search parts by name, number or supplier…',
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

        // ── Category chips ─────────────────────────────────────────────────
        SizedBox(
          height: 36,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _categories.length,
            itemBuilder: (ctx, i) {
              final f = _categories[i];
              final selected = f == _filter;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(f),
                  selected: selected,
                  onSelected: (_) => setState(() => _filter = f),
                  selectedColor: cs.primary,
                  backgroundColor: Colors.transparent,
                  labelStyle: TextStyle(
                    color: selected ? cs.onPrimary : cs.onSurface,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  side: BorderSide(
                    color: selected ? cs.primary : cs.outline.withOpacity(0.4),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 4),

        // ── Low stock banner ───────────────────────────────────────────────
        if (lowStock.isNotEmpty)
          _LowStockBanner(
            count: lowStock.length,
            onTap: () => setState(() {
              _filter = 'All';
              _query = '';
              _searchCtr.clear();
            }),
          ),

        // ── List ───────────────────────────────────────────────────────────
        Expanded(
          child: parts.isEmpty
              ? _PartsEmptyState(
                  isOwner: widget.isOwner, onAdd: widget.onAddPart)
              : AnimatedList(
                  key: ValueKey(parts.length),
                  initialItemCount: parts.length,
                  itemBuilder: (ctx, idx, animation) {
                    if (idx >= parts.length) return const SizedBox.shrink();
                    final part = parts[idx];
                    return SizeTransition(
                      sizeFactor: animation,
                      child: PartCard(
                        part: part,
                        isOwner: widget.isOwner,
                        onEdit: () => widget.onEditPart(part),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

// ─── Low Stock Banner ─────────────────────────────────────────────────────────

class _LowStockBanner extends StatelessWidget {
  const _LowStockBanner({required this.count, required this.onTap});
  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFFFC107).withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFFFC107).withOpacity(0.5)),
        ),
        child: Row(
          children: [
            const Icon(Icons.warning_amber_rounded,
                color: Color(0xFFFFC107), size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '$count ${count == 1 ? 'part is' : 'parts are'} running low — tap to review',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: const Color(0xFFFFC107),
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                color: Color(0xFFFFC107), size: 18),
          ],
        ),
      ),
    );
  }
}

// ─── Empty States ─────────────────────────────────────────────────────────────

class _CarsEmptyState extends StatelessWidget {
  const _CarsEmptyState({
    required this.isOwner,
    required this.isFiltered,
    required this.onAdd,
  });
  final bool isOwner;
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
            Icon(Icons.directions_car_rounded,
                size: 72, color: cs.onSurfaceVariant.withOpacity(0.25)),
            const SizedBox(height: 20),
            Text(
              isFiltered ? 'No cars found' : 'Your inventory is empty',
              style: theme.textTheme.titleMedium!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              isFiltered
                  ? 'Try changing the search or filter'
                  : 'Add your first car to get started',
              style: theme.textTheme.bodySmall!.copyWith(
                color: cs.onSurface.withOpacity(0.5),
              ),
              textAlign: TextAlign.center,
            ),
            if (!isFiltered && isOwner) ...[
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.add),
                label: const Text('Add your first car'),
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

class _PartsEmptyState extends StatelessWidget {
  const _PartsEmptyState({required this.isOwner, required this.onAdd});
  final bool isOwner;
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
            Icon(Icons.build_circle_outlined,
                size: 72, color: cs.onSurfaceVariant.withOpacity(0.25)),
            const SizedBox(height: 20),
            Text('No parts found',
                style: theme.textTheme.titleMedium!
                    .copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text(
              'Try changing the search or category filter',
              style: theme.textTheme.bodySmall!
                  .copyWith(color: cs.onSurface.withOpacity(0.5)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:autovault/data/models/car_model.dart';
import 'package:autovault/features/inventory/providers/cars_provider.dart';
import 'package:autovault/features/purchase/providers/purchase_form_provider.dart';
import 'package:autovault/core/utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarSelector extends ConsumerStatefulWidget {
  const CarSelector({super.key});

  @override
  ConsumerState<CarSelector> createState() => _CarSelectorState();
}

class _CarSelectorState extends ConsumerState<CarSelector> {
  final _searchCtr = TextEditingController();
  String _query = '';
  bool _availableOnly = true;

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
    final selected = formState.selectedCar;

    final allCars = ref.watch(carsNotifierProvider);
    final filtered = allCars.where((c) {
      final q = _query.toLowerCase();
      final matchQ = q.isEmpty ||
          c.make.toLowerCase().contains(q) ||
          c.model.toLowerCase().contains(q) ||
          c.vin.toLowerCase().contains(q);
      final matchStatus = !_availableOnly || c.status == CarStatus.available;
      return matchQ && matchStatus;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Selected car summary ─────────────────────────────────────────
        if (selected != null) ...[
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: cs.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: cs.primary.withOpacity(0.4)),
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 50,
                  decoration: BoxDecoration(
                    color: cs.surfaceVariant,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.directions_car_rounded,
                      color: cs.primary, size: 26),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${selected.make} ${selected.model}',
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                            color: cs.primary,
                          )),
                      Text('${selected.year} · ${selected.vin}',
                          style: theme.textTheme.bodySmall!.copyWith(
                              color: cs.primary.withOpacity(0.6),
                              fontSize: 11)),
                      Text(inrFormatter.format(selected.sellingPrice),
                          style: theme.textTheme.bodySmall!.copyWith(
                            color: cs.primary,
                            fontWeight: FontWeight.w700,
                          )),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close_rounded, size: 18, color: cs.primary),
                  onPressed: () => ref
                      .read(purchaseFormNotifierProvider.notifier)
                      .clearCar(),
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
        const SizedBox(height: 10),

        // ── Filter chips ──────────────────────────────────────────────────
        Row(
          children: [
            _Chip(
              label: 'Available Only',
              selected: _availableOnly,
              onSelected: (v) => setState(() => _availableOnly = v),
              cs: cs,
              theme: theme,
            ),
            const SizedBox(width: 8),
            _Chip(
              label: 'All',
              selected: !_availableOnly,
              onSelected: (v) => setState(() => _availableOnly = !v),
              cs: cs,
              theme: theme,
            ),
          ],
        ),
        const SizedBox(height: 10),

        // ── Car list ──────────────────────────────────────────────────────
        if (filtered.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: Text('No cars found',
                  style: theme.textTheme.bodySmall!
                      .copyWith(color: cs.onSurface.withOpacity(0.4))),
            ),
          )
        else
          ...filtered.map((c) => _SelectableCarTile(
                car: c,
                isSelected: selected?.id == c.id,
                onTap: c.status == CarStatus.available
                    ? () => ref
                        .read(purchaseFormNotifierProvider.notifier)
                        .selectCar(c)
                    : null,
              )),
      ],
    );
  }
}

// ─── Selectable car tile ──────────────────────────────────────────────────────

class _SelectableCarTile extends StatelessWidget {
  const _SelectableCarTile({
    required this.car,
    required this.isSelected,
    required this.onTap,
  });
  final CarModel car;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final available = car.status == CarStatus.available;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: !available
              ? cs.surfaceVariant.withOpacity(0.3)
              : isSelected
                  ? cs.primary.withOpacity(0.08)
                  : cs.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? cs.primary : cs.outline.withOpacity(0.15),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  // Image / placeholder
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 80,
                          height: 70,
                          color: cs.surfaceVariant,
                          child: Icon(Icons.directions_car_rounded,
                              size: 32,
                              color: cs.onSurfaceVariant.withOpacity(0.4)),
                        ),
                      ),
                      if (isSelected)
                        Positioned(
                          top: 4,
                          left: 4,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: cs.primary,
                            child: Icon(Icons.check_rounded,
                                size: 12, color: cs.onPrimary),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${car.make} ${car.model}',
                            style: theme.textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: available
                                  ? cs.onSurface
                                  : cs.onSurface.withOpacity(0.4),
                            )),
                        Text('${car.year}  ·  ${car.vin}',
                            style: theme.textTheme.bodySmall!.copyWith(
                              color: cs.onSurface.withOpacity(0.45),
                              fontSize: 11,
                            )),
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 5,
                          runSpacing: 4,
                          children: [
                            _Tag(car.condition.label, cs),
                            _Tag(car.fuelType.label, cs),
                            _Tag(car.transmission.label, cs),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(inrFormatter.format(car.sellingPrice),
                            style: theme.textTheme.titleSmall!.copyWith(
                              color: available
                                  ? cs.primary
                                  : cs.onSurface.withOpacity(0.3),
                              fontWeight: FontWeight.w800,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Not available overlay
            if (!available)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: cs.surface.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: cs.errorContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('Not Available',
                          style: theme.textTheme.labelSmall!.copyWith(
                            color: cs.onErrorContainer,
                            fontWeight: FontWeight.w700,
                          )),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.label, this.cs);
  final String label;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
        decoration: BoxDecoration(
          color: cs.surfaceVariant,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(label,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: cs.onSurfaceVariant,
                  fontSize: 10,
                )),
      );
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.selected,
    required this.onSelected,
    required this.cs,
    required this.theme,
  });
  final String label;
  final bool selected;
  final void Function(bool) onSelected;
  final ColorScheme cs;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: onSelected,
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      );
}

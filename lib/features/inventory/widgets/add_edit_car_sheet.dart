// features/inventory/widgets/add_edit_car_sheet.dart

import 'package:autovault/data/models/car_model.dart';
import 'package:autovault/features/inventory/providers/cars_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ─── Color palette for the color-dot selector ─────────────────────────────────

const _colorOptions = <String, Color>{
  'White': Color(0xFFF5F5F5),
  'Black': Color(0xFF212121),
  'Silver': Color(0xFFBDBDBD),
  'Grey': Color(0xFF616161),
  'Red': Color(0xFFE53935),
  'Blue': Color(0xFF1E88E5),
  'Orange': Color(0xFFFB8C00),
  'Green': Color(0xFF43A047),
  'Brown': Color(0xFF6D4C41),
  'Yellow': Color(0xFFFDD835),
};

class AddEditCarSheet extends ConsumerStatefulWidget {
  const AddEditCarSheet({super.key, this.existingCar});

  /// If non-null, the form is in "edit" mode.
  final CarModel? existingCar;

  @override
  ConsumerState<AddEditCarSheet> createState() => _AddEditCarSheetState();
}

class _AddEditCarSheetState extends ConsumerState<AddEditCarSheet> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  late final TextEditingController _makeCtr;
  late final TextEditingController _modelCtr;
  late final TextEditingController _yearCtr;
  late final TextEditingController _vinCtr;
  late final TextEditingController _colorCtr;
  late final TextEditingController _mileageCtr;
  late final TextEditingController _purchasePriceCtr;
  late final TextEditingController _sellingPriceCtr;
  late final TextEditingController _descCtr;

  // State
  CarCondition _condition = CarCondition.newCar;
  FuelType _fuelType = FuelType.petrol;
  Transmission _transmission = Transmission.automatic;
  String? _selectedColor;
  final List<String> _imagePaths =
      []; // Would hold real file paths after picking

  bool get _isEdit => widget.existingCar != null;

  @override
  void initState() {
    super.initState();
    final c = widget.existingCar;
    _makeCtr = TextEditingController(text: c?.make ?? '');
    _modelCtr = TextEditingController(text: c?.model ?? '');
    _yearCtr = TextEditingController(text: c != null ? '${c.year}' : '');
    _vinCtr = TextEditingController(text: c?.vin ?? '');
    _colorCtr = TextEditingController(text: c?.color ?? '');
    _mileageCtr = TextEditingController(text: c != null ? '${c.mileage}' : '');
    _purchasePriceCtr = TextEditingController(
        text: c != null ? '${c.purchasePrice.toInt()}' : '');
    _sellingPriceCtr = TextEditingController(
        text: c != null ? '${c.sellingPrice.toInt()}' : '');
    _descCtr = TextEditingController(text: c?.description ?? '');

    if (c != null) {
      _condition = c.condition;
      _fuelType = c.fuelType;
      _transmission = c.transmission;
      _selectedColor = c.color;
    }
  }

  @override
  void dispose() {
    for (final ctr in [
      _makeCtr,
      _modelCtr,
      _yearCtr,
      _vinCtr,
      _colorCtr,
      _mileageCtr,
      _purchasePriceCtr,
      _sellingPriceCtr,
      _descCtr,
    ]) {
      ctr.dispose();
    }
    super.dispose();
  }

  // ── Image picker mock ──────────────────────────────────────────────────────

  void _pickImage() {
    // TODO: wire image_picker + flutter_image_compress
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Image picker — connect image_picker package here'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // ── Save ──────────────────────────────────────────────────────────────────

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final car = CarModel(
      id: _isEdit
          ? widget.existingCar!.id
          : 'car_${DateTime.now().millisecondsSinceEpoch}',
      make: _makeCtr.text.trim(),
      model: _modelCtr.text.trim(),
      year: int.parse(_yearCtr.text.trim()),
      vin: _vinCtr.text.trim().toUpperCase(),
      color: _colorCtr.text.trim(),
      condition: _condition,
      fuelType: _fuelType,
      transmission: _transmission,
      mileage: _condition == CarCondition.used
          ? int.tryParse(_mileageCtr.text.trim()) ?? 0
          : 0,
      purchasePrice: double.parse(_purchasePriceCtr.text.trim()),
      sellingPrice: double.parse(_sellingPriceCtr.text.trim()),
      status: _isEdit ? widget.existingCar!.status : CarStatus.available,
      imageUrls: _isEdit ? widget.existingCar!.imageUrls : [],
      description: _descCtr.text.trim(),
      createdAt: _isEdit ? widget.existingCar!.createdAt : DateTime.now(),
    );

    final notifier = ref.read(carsNotifierProvider.notifier);
    if (_isEdit) {
      notifier.updateCar(car);
    } else {
      notifier.addCar(car);
    }
    Navigator.pop(context);
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return DraggableScrollableSheet(
      initialChildSize: 0.93,
      minChildSize: 0.6,
      maxChildSize: 0.98,
      expand: false,
      builder: (_, scrollCtrl) => Container(
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // ── Handle ────────────────────────────────────────────────────
            const SizedBox(height: 10),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: cs.onSurfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
              child: Row(
                children: [
                  Text(
                    _isEdit ? 'Edit Car' : 'Add New Car',
                    style: theme.textTheme.titleLarge!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // ── Scrollable form ───────────────────────────────────────────
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  controller: scrollCtrl,
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
                  children: [
                    // Image picker row
                    _sectionLabel(context, 'Photos'),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 90,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          // Add button
                          if (_imagePaths.length < 6)
                            GestureDetector(
                              onTap: _pickImage,
                              child: Container(
                                width: 80,
                                height: 80,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: cs.primary.withOpacity(0.5),
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_photo_alternate_outlined,
                                        color: cs.primary),
                                    const SizedBox(height: 4),
                                    Text('Add',
                                        style: theme.textTheme.labelSmall!
                                            .copyWith(color: cs.primary)),
                                  ],
                                ),
                              ),
                            ),
                          // Image thumbs
                          ..._imagePaths.asMap().entries.map((e) => Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      color: cs.surfaceVariant,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(Icons.image_outlined),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: () => setState(
                                          () => _imagePaths.removeAt(e.key)),
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor: cs.error,
                                        child: const Icon(Icons.close,
                                            size: 12, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Make + Model
                    Row(
                      children: [
                        Expanded(
                            child: _field('Make', _makeCtr,
                                hint: 'e.g. Maruti Suzuki')),
                        const SizedBox(width: 12),
                        Expanded(
                            child: _field('Model', _modelCtr,
                                hint: 'e.g. Baleno')),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Year + VIN
                    Row(
                      children: [
                        Expanded(
                            child: _field('Year', _yearCtr,
                                hint: '2024',
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ], validator: (v) {
                          final year = int.tryParse(v ?? '');
                          if (year == null ||
                              year < 1900 ||
                              year > DateTime.now().year + 1) {
                            return 'Enter a valid year';
                          }
                          return null;
                        })),
                        const SizedBox(width: 12),
                        Expanded(
                            child: _field('VIN', _vinCtr,
                                hint: 'MBLFA56B7...',
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[A-Za-z0-9]')),
                                  UpperCaseTextFormatter(),
                                ],
                                validator: (v) => v == null || v.length < 10
                                    ? 'Enter a valid VIN'
                                    : null)),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Color field + dot selector
                    _field('Color', _colorCtr, hint: 'e.g. Pearl White'),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      children: _colorOptions.entries.map((e) {
                        final selected = _selectedColor == e.key;
                        return GestureDetector(
                          onTap: () => setState(() {
                            _selectedColor = e.key;
                            _colorCtr.text = e.key;
                          }),
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: e.value,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: selected
                                    ? cs.primary
                                    : cs.outline.withOpacity(0.4),
                                width: selected ? 2.5 : 1,
                              ),
                            ),
                            child: selected
                                ? Icon(Icons.check,
                                    size: 14,
                                    color: e.value.computeLuminance() > 0.5
                                        ? Colors.black
                                        : Colors.white)
                                : null,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),

                    // Condition toggle
                    _sectionLabel(context, 'Condition'),
                    const SizedBox(height: 8),
                    _toggleRow<CarCondition>(
                      context,
                      values: CarCondition.values,
                      current: _condition,
                      labelOf: (v) => v.label,
                      onChanged: (v) => setState(() => _condition = v),
                    ),
                    const SizedBox(height: 20),

                    // Fuel type
                    _sectionLabel(context, 'Fuel Type'),
                    const SizedBox(height: 8),
                    _toggleRow<FuelType>(
                      context,
                      values: FuelType.values,
                      current: _fuelType,
                      labelOf: (v) => v.label,
                      onChanged: (v) => setState(() => _fuelType = v),
                    ),
                    const SizedBox(height: 20),

                    // Transmission
                    _sectionLabel(context, 'Transmission'),
                    const SizedBox(height: 8),
                    _toggleRow<Transmission>(
                      context,
                      values: Transmission.values,
                      current: _transmission,
                      labelOf: (v) => v.label,
                      onChanged: (v) => setState(() => _transmission = v),
                    ),
                    const SizedBox(height: 20),

                    // Mileage (only if used)
                    if (_condition == CarCondition.used) ...[
                      _field('Mileage (km)', _mileageCtr,
                          hint: 'e.g. 25000',
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ]),
                      const SizedBox(height: 16),
                    ],

                    // Prices
                    Row(
                      children: [
                        Expanded(
                            child: _field(
                                'Purchase Price (₹)', _purchasePriceCtr,
                                hint: '700000',
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                validator: (v) =>
                                    double.tryParse(v ?? '') == null
                                        ? 'Enter valid amount'
                                        : null)),
                        const SizedBox(width: 12),
                        Expanded(
                            child: _field('Selling Price (₹)', _sellingPriceCtr,
                                hint: '850000',
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                validator: (v) =>
                                    double.tryParse(v ?? '') == null
                                        ? 'Enter valid amount'
                                        : null)),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Description
                    _field('Description (optional)', _descCtr,
                        hint: 'Any notable details about the car...',
                        maxLines: 3,
                        validator: null),
                    const SizedBox(height: 32),

                    // Save button
                    FilledButton(
                      onPressed: _save,
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Text(
                        _isEdit ? 'Update Car' : 'Save Car',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  Widget _sectionLabel(BuildContext ctx, String label) => Text(
        label,
        style: Theme.of(ctx).textTheme.labelMedium!.copyWith(
              color: Theme.of(ctx).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
      );

  Widget _field(
    String label,
    TextEditingController ctr, {
    String? hint,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) =>
      TextFormField(
        controller: ctr,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            ),
          ),
        ),
        validator: validator ??
            (v) => v == null || v.trim().isEmpty ? '$label is required' : null,
      );

  Widget _toggleRow<T>(
    BuildContext ctx, {
    required List<T> values,
    required T current,
    required String Function(T) labelOf,
    required void Function(T) onChanged,
  }) {
    final cs = Theme.of(ctx).colorScheme;
    return Wrap(
      spacing: 8,
      children: values.map((v) {
        final selected = v == current;
        return ChoiceChip(
          label: Text(labelOf(v)),
          selected: selected,
          onSelected: (_) => onChanged(v),
          selectedColor: cs.primary,
          labelStyle: TextStyle(
            color: selected ? cs.onPrimary : cs.onSurface,
            fontWeight: FontWeight.w600,
          ),
          side: BorderSide(
            color: selected ? cs.primary : cs.outline.withOpacity(0.4),
          ),
          backgroundColor: cs.surface,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        );
      }).toList(),
    );
  }
}

// ─── Formatter ────────────────────────────────────────────────────────────────

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
          TextEditingValue _, TextEditingValue newValue) =>
      newValue.copyWith(text: newValue.text.toUpperCase());
}

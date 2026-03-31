import 'package:autovault/data/models/part_model.dart';
import 'package:autovault/features/inventory/providers/parts_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _SupplierOption {
  const _SupplierOption(this.id, this.name);
  final String id;
  final String name;
}

const _mockSuppliers = [
  _SupplierOption('sup_001', 'Maruti Genuine Parts'),
  _SupplierOption('sup_002', 'Hyundai Mobis'),
  _SupplierOption('sup_003', 'Exide Industries'),
  _SupplierOption('sup_004', 'Tata Genuine Accessories'),
  _SupplierOption('sup_005', 'MRF Tyres'),
  _SupplierOption('sup_006', 'AutoFix Accessories'),
  _SupplierOption('sup_007', 'Honda Access'),
  _SupplierOption('sup_008', 'Toyota Genuine Parts'),
  _SupplierOption('sup_009', 'LuK India'),
];

// ─────────────────────────────────────────────────────────────────────────────

class AddEditPartSheet extends ConsumerStatefulWidget {
  const AddEditPartSheet({super.key, this.existingPart});

  final PartModel? existingPart;

  @override
  ConsumerState<AddEditPartSheet> createState() => _AddEditPartSheetState();
}

class _AddEditPartSheetState extends ConsumerState<AddEditPartSheet> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameCtr;
  late final TextEditingController _partNumCtr;
  late final TextEditingController _qtyCtr;
  late final TextEditingController _reorderCtr;
  late final TextEditingController _priceCtr;
  late final TextEditingController _descCtr;

  PartCategory _category = PartCategory.engine;
  _SupplierOption? _selectedSupplier;

  bool get _isEdit => widget.existingPart != null;

  @override
  void initState() {
    super.initState();
    final p = widget.existingPart;
    _nameCtr = TextEditingController(text: p?.name ?? '');
    _partNumCtr = TextEditingController(text: p?.partNumber ?? '');
    _qtyCtr = TextEditingController(text: p != null ? '${p.quantity}' : '');
    _reorderCtr =
        TextEditingController(text: p != null ? '${p.reorderLevel}' : '');
    _priceCtr =
        TextEditingController(text: p != null ? '${p.unitPrice.toInt()}' : '');
    _descCtr = TextEditingController(text: p?.description ?? '');

    if (p != null) {
      _category = p.category;
      _selectedSupplier =
          _mockSuppliers.where((s) => s.id == p.supplierId).firstOrNull;
    }
  }

  @override
  void dispose() {
    for (final c in [
      _nameCtr,
      _partNumCtr,
      _qtyCtr,
      _reorderCtr,
      _priceCtr,
      _descCtr
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final supplier = _selectedSupplier!;

    final part = PartModel(
      id: _isEdit
          ? widget.existingPart!.id
          : 'part_${DateTime.now().millisecondsSinceEpoch}',
      name: _nameCtr.text.trim(),
      partNumber: _partNumCtr.text.trim().toUpperCase(),
      category: _category,
      supplierId: supplier.id,
      supplierName: supplier.name,
      quantity: int.parse(_qtyCtr.text.trim()),
      reorderLevel: int.parse(_reorderCtr.text.trim()),
      unitPrice: double.parse(_priceCtr.text.trim()),
      description: _descCtr.text.trim(),
      createdAt: _isEdit ? widget.existingPart!.createdAt : DateTime.now(),
    );

    final notifier = ref.read(partsNotifierProvider.notifier);
    if (_isEdit) {
      notifier.updatePart(part);
    } else {
      notifier.addPart(part);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.98,
      expand: false,
      builder: (_, scrollCtrl) => Container(
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
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
                    _isEdit ? 'Edit Part' : 'Add New Part',
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
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  controller: scrollCtrl,
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
                  children: [
                    // Part Name
                    _field('Part Name', _nameCtr, hint: 'e.g. Oil Filter'),
                    const SizedBox(height: 16),

                    // Part Number
                    _field('Part Number', _partNumCtr,
                        hint: 'e.g. MUL-OFT-001',
                        inputFormatters: [UpperCaseFormatter()]),
                    const SizedBox(height: 20),

                    // Category
                    _sectionLabel(context, 'Category'),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<PartCategory>(
                      value: _category,
                      decoration: _inputDeco(context, 'Category'),
                      items: PartCategory.values
                          .map((c) => DropdownMenuItem(
                                value: c,
                                child: Text(c.label),
                              ))
                          .toList(),
                      onChanged: (v) {
                        if (v != null) setState(() => _category = v);
                      },
                    ),
                    const SizedBox(height: 16),

                    // Supplier
                    _sectionLabel(context, 'Supplier'),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<_SupplierOption>(
                      value: _selectedSupplier,
                      decoration: _inputDeco(context, 'Select Supplier'),
                      items: _mockSuppliers
                          .map((s) => DropdownMenuItem(
                                value: s,
                                child: Text(s.name),
                              ))
                          .toList(),
                      onChanged: (v) => setState(() => _selectedSupplier = v),
                      validator: (v) =>
                          v == null ? 'Please select a supplier' : null,
                    ),
                    const SizedBox(height: 16),

                    // Qty + Reorder
                    Row(
                      children: [
                        Expanded(
                          child: _field('Qty in Stock', _qtyCtr,
                              hint: '10',
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: (v) => int.tryParse(v ?? '') == null
                                  ? 'Enter a number'
                                  : null),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _field('Reorder Level', _reorderCtr,
                              hint: '5',
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: (v) => int.tryParse(v ?? '') == null
                                  ? 'Enter a number'
                                  : null),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Unit Price
                    _field('Unit Price (₹)', _priceCtr,
                        hint: '1500',
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        validator: (v) => double.tryParse(v ?? '') == null
                            ? 'Enter valid price'
                            : null),
                    const SizedBox(height: 16),

                    // Description
                    _field('Description (optional)', _descCtr,
                        hint: 'Compatible models, notes...',
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
                        _isEdit ? 'Update Part' : 'Save Part',
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

  Widget _sectionLabel(BuildContext ctx, String label) => Text(
        label,
        style: Theme.of(ctx).textTheme.labelMedium!.copyWith(
              color: Theme.of(ctx).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
      );

  InputDecoration _inputDeco(BuildContext ctx, String label) => InputDecoration(
        labelText: label,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(ctx).colorScheme.outline.withOpacity(0.2),
          ),
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
        decoration: _inputDeco(context, label).copyWith(hintText: hint),
        validator: validator ??
            (v) => v == null || v.trim().isEmpty ? '$label is required' : null,
      );
}

class UpperCaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue _, TextEditingValue n) =>
      n.copyWith(text: n.text.toUpperCase());
}

import 'package:autovault/core/utils/formatters.dart';
import 'package:autovault/data/models/customer_model.dart';
import 'package:autovault/features/customers/providers/customers_provider.dart';
import 'package:autovault/features/shared/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _mockEmployees = [
  ('emp_001', 'Rohan Sharma'),
  ('emp_002', 'Sneha Desai'),
  ('emp_003', 'Amit Patel'),
];

class AddEditCustomerSheet extends ConsumerStatefulWidget {
  const AddEditCustomerSheet({super.key, this.existingCustomer});
  final CustomerModel? existingCustomer;

  @override
  ConsumerState<AddEditCustomerSheet> createState() =>
      _AddEditCustomerSheetState();
}

class _AddEditCustomerSheetState extends ConsumerState<AddEditCustomerSheet> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _firstNameCtr;
  late final TextEditingController _lastNameCtr;
  late final TextEditingController _phoneCtr;
  late final TextEditingController _emailCtr;
  late final TextEditingController _addressCtr;
  late final TextEditingController _notesCtr;

  LeadStatus _leadStatus = LeadStatus.hotLead;
  DateTime? _dateOfBirth;
  String? _assignedEmployeeId;
  String? _assignedEmployeeName;

  bool get _isEdit => widget.existingCustomer != null;

  @override
  void initState() {
    super.initState();
    final c = widget.existingCustomer;
    _firstNameCtr = TextEditingController(text: c?.firstName ?? '');
    _lastNameCtr = TextEditingController(text: c?.lastName ?? '');
    _phoneCtr = TextEditingController(
        text: c != null ? c.phone.replaceFirst('+91', '').trim() : '');
    _emailCtr = TextEditingController(text: c?.email ?? '');
    _addressCtr = TextEditingController(text: c?.address ?? '');
    _notesCtr = TextEditingController(text: c?.notes ?? '');

    if (c != null) {
      _leadStatus = c.leadStatus;
      _dateOfBirth = c.dateOfBirth;
      _assignedEmployeeId = c.assignedEmployeeId;
      _assignedEmployeeName = c.assignedEmployeeName;
    }
  }

  @override
  void dispose() {
    for (final c in [
      _firstNameCtr,
      _lastNameCtr,
      _phoneCtr,
      _emailCtr,
      _addressCtr,
      _notesCtr,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _pickDob() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime(1995),
      firstDate: DateTime(1940),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 16)),
    );
    if (picked != null) setState(() => _dateOfBirth = picked);
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final customer = CustomerModel(
      id: _isEdit
          ? widget.existingCustomer!.id
          : 'cust_${DateTime.now().millisecondsSinceEpoch}',
      firstName: _firstNameCtr.text.trim(),
      lastName: _lastNameCtr.text.trim(),
      phone: '+91${_phoneCtr.text.trim()}',
      email: _emailCtr.text.trim(),
      dateOfBirth: _dateOfBirth,
      address: _addressCtr.text.trim(),
      assignedEmployeeId: _assignedEmployeeId ?? '',
      assignedEmployeeName: _assignedEmployeeName ?? '',
      leadStatus: _leadStatus,
      notes: _notesCtr.text.trim(),
      purchaseIds: _isEdit ? widget.existingCustomer!.purchaseIds : [],
      loanIds: _isEdit ? widget.existingCustomer!.loanIds : [],
      testDriveIds: _isEdit ? widget.existingCustomer!.testDriveIds : [],
      createdAt: _isEdit ? widget.existingCustomer!.createdAt : DateTime.now(),
      lastInteractionAt: DateTime.now(),
    );

    final notifier = ref.read(customersNotifierProvider.notifier);
    if (_isEdit) {
      notifier.updateCustomer(customer);
    } else {
      notifier.addCustomer(customer);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final fullName =
        '${_firstNameCtr.text.trim()} ${_lastNameCtr.text.trim()}'.trim();

    return DraggableScrollableSheet(
      initialChildSize: 0.92,
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
                    _isEdit ? 'Edit Customer' : 'Add Customer',
                    style: theme.textTheme.titleLarge!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context)),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  controller: scrollCtrl,
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                  children: [
                    // ── Avatar preview + photo picker stub ────────────────
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          AvatarWidget(
                            name: fullName.isEmpty ? '?' : fullName,
                            radius: 40,
                          ),
                          GestureDetector(
                            onTap: () => ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    content: Text(
                                        'Photo picker — wire image_picker here'))),
                            child: CircleAvatar(
                              radius: 13,
                              backgroundColor: cs.primary,
                              child: const Icon(Icons.camera_alt,
                                  size: 14, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── Name ──────────────────────────────────────────────
                    Row(
                      children: [
                        Expanded(
                            child: _field('First Name', _firstNameCtr,
                                hint: 'Arjun',
                                onChanged: (_) => setState(() {}))),
                        const SizedBox(width: 12),
                        Expanded(
                            child: _field('Last Name', _lastNameCtr,
                                hint: 'Mehta',
                                onChanged: (_) => setState(() {}))),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // ── Phone ─────────────────────────────────────────────
                    TextFormField(
                      controller: _phoneCtr,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)
                      ],
                      decoration: _inputDeco('Phone Number').copyWith(
                        prefixText: '+91 ',
                        hintText: '9876543210',
                      ),
                      validator: (v) {
                        if (v == null || v.length != 10) {
                          return 'Enter a valid 10-digit number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // ── Email ─────────────────────────────────────────────
                    _field('Email (optional)', _emailCtr,
                        hint: 'arjun@gmail.com',
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) {
                      if (v == null || v.trim().isEmpty) return null;
                      if (!v.contains('@') || !v.contains('.')) {
                        return 'Enter a valid email';
                      }
                      return null;
                    }),
                    const SizedBox(height: 16),

                    // ── Date of Birth ─────────────────────────────────────
                    GestureDetector(
                      onTap: _pickDob,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                          color: cs.surfaceVariant.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: cs.outline.withOpacity(0.2)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.cake_outlined,
                                size: 18, color: cs.onSurfaceVariant),
                            const SizedBox(width: 10),
                            Text(
                              _dateOfBirth != null
                                  ? formatDobWithAge(_dateOfBirth!)
                                  : 'Date of Birth (optional)',
                              style: _dateOfBirth != null
                                  ? theme.textTheme.bodyMedium
                                  : theme.textTheme.bodyMedium!.copyWith(
                                      color: cs.onSurface.withOpacity(0.4)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── Address ───────────────────────────────────────────
                    _field('Address', _addressCtr,
                        hint: '14, Sunrise Apartments, Surat',
                        maxLines: 2,
                        validator: null),
                    const SizedBox(height: 20),

                    // ── Lead Status ───────────────────────────────────────
                    _sectionLabel('Lead Status'),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: LeadStatus.values.map((s) {
                        final sel = s == _leadStatus;
                        return ChoiceChip(
                          label: Text(s.label),
                          selected: sel,
                          onSelected: (_) => setState(() => _leadStatus = s),
                          selectedColor: cs.primary,
                          backgroundColor: Colors.transparent,
                          labelStyle: TextStyle(
                            color: sel ? cs.onPrimary : cs.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                          side: BorderSide(
                            color:
                                sel ? cs.primary : cs.outline.withOpacity(0.4),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),

                    // ── Assigned Employee (Owner only) ────────────────────
                    // TODO: hide for Employee role using your auth provider
                    _sectionLabel('Assigned Employee'),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _assignedEmployeeId,
                      decoration: _inputDeco('Select Employee'),
                      items: _mockEmployees
                          .map((e) => DropdownMenuItem(
                                value: e.$1,
                                child: Text(e.$2),
                              ))
                          .toList(),
                      onChanged: (v) {
                        if (v == null) return;
                        final emp = _mockEmployees.firstWhere((e) => e.$1 == v);
                        setState(() {
                          _assignedEmployeeId = emp.$1;
                          _assignedEmployeeName = emp.$2;
                        });
                      },
                      validator: null,
                    ),
                    const SizedBox(height: 16),

                    // ── Notes ─────────────────────────────────────────────
                    _field('Notes (optional)', _notesCtr,
                        hint: 'Any relevant notes about this customer…',
                        maxLines: 3,
                        validator: null),
                    const SizedBox(height: 32),

                    // ── Save ──────────────────────────────────────────────
                    FilledButton(
                      onPressed: _save,
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Text(
                        _isEdit ? 'Update Customer' : 'Save Customer',
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

  Widget _sectionLabel(String label) => Text(
        label,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
      );

  InputDecoration _inputDeco(String label) => InputDecoration(
        labelText: label,
        filled: true,
        fillColor:
            Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.4),
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
      );

  Widget _field(
    String label,
    TextEditingController ctr, {
    String? hint,
    TextInputType? keyboardType,
    int maxLines = 1,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
  }) =>
      TextFormField(
        controller: ctr,
        keyboardType: keyboardType,
        maxLines: maxLines,
        onChanged: onChanged,
        decoration: _inputDeco(label).copyWith(hintText: hint),
        validator: validator ??
            (v) => v == null || v.trim().isEmpty ? '$label is required' : null,
      );
}

import 'package:autovault/core/utils/formatters.dart';
import 'package:autovault/data/models/test_drive_activity_model.dart';
import 'package:autovault/data/models/test_drive_model.dart';
import 'package:autovault/features/test_drive/providers/test_drives_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TestDrivePrefill {
  final String? customerId;
  final String? customerName;
  final String? customerPhone;
  final String? carId;
  final String? carMake;
  final String? carModel;
  final int? carYear;
  final bool lockCustomer;
  final bool lockCar;

  const TestDrivePrefill({
    this.customerId,
    this.customerName,
    this.customerPhone,
    this.carId,
    this.carMake,
    this.carModel,
    this.carYear,
    this.lockCustomer = false,
    this.lockCar = false,
  });
}

// ─── Mock employees — replace with employeesProvider ─────────────────────────

const _mockEmployees = [
  ('emp_001', 'Rohan Sharma'),
  ('emp_002', 'Sneha Desai'),
  ('emp_003', 'Amit Patel'),
];

// ─── Sheet ────────────────────────────────────────────────────────────────────

class AddEditTestDriveSheet extends ConsumerStatefulWidget {
  const AddEditTestDriveSheet({
    super.key,
    this.existing,
    this.prefill,
    this.isOwner = true,
  });

  final TestDriveModel? existing;
  final TestDrivePrefill? prefill;
  final bool isOwner;

  @override
  ConsumerState<AddEditTestDriveSheet> createState() =>
      _AddEditTestDriveSheetState();
}

class _AddEditTestDriveSheetState extends ConsumerState<AddEditTestDriveSheet> {
  // Customer
  String? _customerId;
  String _customerName = '';
  String _customerPhone = '';
  bool _lockCustomer = false;

  // Car
  String? _carId;
  String _carMake = '';
  String _carModel = '';
  int _carYear = DateTime.now().year;
  bool _lockCar = false;

  // Schedule
  DateTime? _scheduledDate;
  TimeOfDay? _scheduledTime;
  int _durationMinutes = 30;

  // Employee
  String _employeeId = '';
  String _employeeName = '';

  // Details
  final _locationCtr = TextEditingController();
  final _notesCtr = TextEditingController();

  // Conflict
  bool _acknowledgedConflict = false;

  // Status (edit mode, owner only)
  TestDriveStatus? _status;

  bool get _isEdit => widget.existing != null;

  DateTime? get _scheduledAt {
    if (_scheduledDate == null || _scheduledTime == null) return null;
    return DateTime(
      _scheduledDate!.year,
      _scheduledDate!.month,
      _scheduledDate!.day,
      _scheduledTime!.hour,
      _scheduledTime!.minute,
    );
  }

  bool get _canSave =>
      _customerId != null &&
      _carId != null &&
      _scheduledAt != null &&
      _employeeId.isNotEmpty;

  @override
  void initState() {
    super.initState();

    final p = widget.prefill;
    final e = widget.existing;

    if (p != null) {
      _customerId = p.customerId;
      _customerName = p.customerName ?? '';
      _customerPhone = p.customerPhone ?? '';
      _lockCustomer = p.lockCustomer;
      _carId = p.carId;
      _carMake = p.carMake ?? '';
      _carModel = p.carModel ?? '';
      _carYear = p.carYear ?? DateTime.now().year;
      _lockCar = p.lockCar;
    }

    if (e != null) {
      _customerId = e.customerId;
      _customerName = e.customerName;
      _customerPhone = e.customerPhone;
      _carId = e.carId;
      _carMake = e.carMake;
      _carModel = e.carModel;
      _carYear = e.carYear;
      _scheduledDate = e.scheduledAt;
      _scheduledTime = TimeOfDay.fromDateTime(e.scheduledAt);
      _durationMinutes = e.durationMinutes;
      _employeeId = e.assignedEmployeeId;
      _employeeName = e.assignedEmployeeName;
      _locationCtr.text = e.location;
      _notesCtr.text = e.notes;
      _status = e.status;
    }

    // Default employee for employee role
    if (!widget.isOwner && _employeeId.isEmpty) {
      _employeeId = 'emp_001'; // TODO: from authProvider
      _employeeName = 'Rohan Sharma';
    }
  }

  @override
  void dispose() {
    _locationCtr.dispose();
    _notesCtr.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate:
          _scheduledDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _scheduledDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _scheduledTime ?? const TimeOfDay(hour: 10, minute: 0),
    );
    if (picked != null) setState(() => _scheduledTime = picked);
  }

  void _save() {
    if (!_canSave) return;

    final notifier = ref.read(testDrivesNotifierProvider.notifier);
    final now = DateTime.now();

    final activityLog = _isEdit
        ? widget.existing!.activityLog
        : [
            TestDriveActivityModel(
              id: 'act_${now.millisecondsSinceEpoch}',
              timestamp: now,
              description: 'Test drive booked by $_employeeName.',
              type: TestDriveActivityType.booked,
            ),
          ];

    final td = TestDriveModel(
      id: _isEdit ? widget.existing!.id : 'td_${now.millisecondsSinceEpoch}',
      customerId: _customerId!,
      customerName: _customerName,
      customerPhone: _customerPhone,
      carId: _carId!,
      carMake: _carMake,
      carModel: _carModel,
      carYear: _carYear,
      assignedEmployeeId: _employeeId,
      assignedEmployeeName: _employeeName,
      scheduledAt: _scheduledAt!,
      durationMinutes: _durationMinutes,
      status: _isEdit
          ? (_status ?? widget.existing!.status)
          : TestDriveStatus.pending,
      location: _locationCtr.text.trim(),
      notes: _notesCtr.text.trim(),
      activityLog: activityLog,
      createdAt: _isEdit ? widget.existing!.createdAt : now,
    );

    if (_isEdit) {
      notifier.updateTestDrive(td);
    } else {
      notifier.scheduleTestDrive(td);
    }

    Navigator.pop(context);

    final fmt = DateFormat('d MMM');
    final timeFmt = DateFormat('h:mm a');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Test drive scheduled for ${fmt.format(_scheduledAt!)} at ${timeFmt.format(_scheduledAt!)}',
        ),
        backgroundColor: const Color(0xFF4CAF50),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    // Reactive conflict detection
    final conflict = _carId != null && _scheduledAt != null
        ? ref.watch(conflictingTestDriveProvider(
            carId: _carId!,
            scheduledAt: _scheduledAt!,
            durationMinutes: _durationMinutes,
            excludeId: widget.existing?.id,
          ))
        : null;

    final hasConflict = conflict != null;

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.97,
      minChildSize: 0.5,
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
                    _isEdit ? 'Edit Test Drive' : 'Schedule Test Drive',
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
              child: ListView(
                controller: scrollCtrl,
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
                children: [
                  // ── Customer ────────────────────────────────────────────
                  _sectionLabel('Customer', theme, cs),
                  const SizedBox(height: 8),
                  if (_lockCustomer && _customerId != null)
                    _LockedChip(
                      label: _customerName,
                      icon: Icons.person_rounded,
                      cs: cs,
                      theme: theme,
                    )
                  else
                    _CustomerPicker(
                      selectedId: _customerId,
                      selectedName: _customerName,
                      onSelected: (id, name, phone) => setState(() {
                        _customerId = id;
                        _customerName = name;
                        _customerPhone = phone;
                      }),
                      onClear: () => setState(() {
                        _customerId = null;
                        _customerName = '';
                        _customerPhone = '';
                      }),
                      cs: cs,
                      theme: theme,
                    ),
                  const SizedBox(height: 16),

                  // ── Car ─────────────────────────────────────────────────
                  _sectionLabel('Vehicle', theme, cs),
                  const SizedBox(height: 8),
                  if (_lockCar && _carId != null)
                    _LockedChip(
                      label: '$_carMake $_carModel ($_carYear)',
                      icon: Icons.directions_car_rounded,
                      cs: cs,
                      theme: theme,
                    )
                  else
                    _CarPicker(
                      selectedId: _carId,
                      selectedName: _carId != null
                          ? '$_carMake $_carModel ($_carYear)'
                          : null,
                      onSelected: (id, make, model, year) => setState(() {
                        _carId = id;
                        _carMake = make;
                        _carModel = model;
                        _carYear = year;
                        _acknowledgedConflict = false;
                      }),
                      onClear: () => setState(() {
                        _carId = null;
                        _acknowledgedConflict = false;
                      }),
                      cs: cs,
                      theme: theme,
                    ),

                  // Conflict warning
                  if (hasConflict) ...[
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: cs.error.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: cs.error.withOpacity(0.4)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.warning_rounded,
                                  size: 16, color: cs.error),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  'This car is already scheduled at '
                                  '${DateFormat('h:mm a').format(conflict!.scheduledAt)} '
                                  '— please choose a different time or car.',
                                  style: theme.textTheme.bodySmall!
                                      .copyWith(color: cs.error),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Checkbox(
                                value: _acknowledgedConflict,
                                onChanged: (v) => setState(
                                    () => _acknowledgedConflict = v ?? false),
                                activeColor: cs.error,
                              ),
                              Expanded(
                                child: Text(
                                  'I understand and want to proceed anyway',
                                  style: theme.textTheme.bodySmall!.copyWith(
                                      color: cs.onSurface.withOpacity(0.7)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),

                  // ── Date & Time ──────────────────────────────────────────
                  _sectionLabel('Date & Time', theme, cs),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _TapField(
                          label: _scheduledDate != null
                              ? dateFormatter.format(_scheduledDate!)
                              : 'Select date',
                          icon: Icons.calendar_today_outlined,
                          onTap: _pickDate,
                          cs: cs,
                          theme: theme,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _TapField(
                          label: _scheduledTime != null
                              ? _scheduledTime!.format(context)
                              : 'Select time',
                          icon: Icons.access_time_rounded,
                          onTap: _pickTime,
                          cs: cs,
                          theme: theme,
                        ),
                      ),
                    ],
                  ),
                  // Past datetime warning
                  if (_scheduledAt != null &&
                      _scheduledAt!.isBefore(DateTime.now())) ...[
                    const SizedBox(height: 6),
                    Text('Selected time is in the past.',
                        style: theme.textTheme.labelSmall!
                            .copyWith(color: cs.error)),
                  ],
                  const SizedBox(height: 16),

                  // ── Duration ─────────────────────────────────────────────
                  _sectionLabel('Duration', theme, cs),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [15, 30, 45, 60].map((mins) {
                      final sel = _durationMinutes == mins;
                      return ChoiceChip(
                        label: Text(mins < 60 ? '$mins min' : '1 hour'),
                        selected: sel,
                        onSelected: (_) =>
                            setState(() => _durationMinutes = mins),
                        selectedColor: cs.primary,
                        backgroundColor: Colors.transparent,
                        labelStyle: TextStyle(
                          color: sel ? cs.onPrimary : cs.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                        side: BorderSide(
                          color: sel ? cs.primary : cs.outline.withOpacity(0.4),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

                  // ── Assigned Employee ─────────────────────────────────────
                  _sectionLabel('Assigned Employee', theme, cs),
                  const SizedBox(height: 8),
                  if (!widget.isOwner)
                    _LockedChip(
                      label: _employeeName,
                      icon: Icons.badge_rounded,
                      cs: cs,
                      theme: theme,
                    )
                  else
                    DropdownButtonFormField<String>(
                      value: _employeeId.isEmpty ? null : _employeeId,
                      decoration: _deco(cs, 'Select Employee'),
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
                          _employeeId = emp.$1;
                          _employeeName = emp.$2;
                        });
                      },
                    ),
                  const SizedBox(height: 16),

                  // ── Location ──────────────────────────────────────────────
                  TextFormField(
                    controller: _locationCtr,
                    decoration: _deco(cs, 'Route / Location (optional)',
                        hint: 'e.g. City loop via MG Road'),
                  ),
                  const SizedBox(height: 14),

                  // ── Notes ─────────────────────────────────────────────────
                  TextFormField(
                    controller: _notesCtr,
                    maxLines: 3,
                    decoration: _deco(cs, 'Notes (optional)',
                        hint: 'Any specific instructions…'),
                  ),

                  // ── Status override (edit, owner only) ────────────────────
                  if (_isEdit && widget.isOwner) ...[
                    const SizedBox(height: 16),
                    _sectionLabel('Status Override', theme, cs),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<TestDriveStatus>(
                      value: _status,
                      decoration: _deco(cs, 'Status'),
                      items: TestDriveStatus.values
                          .map((s) => DropdownMenuItem(
                                value: s,
                                child: Text(s.label),
                              ))
                          .toList(),
                      onChanged: (v) => setState(() => _status = v),
                    ),
                  ],

                  const SizedBox(height: 32),

                  // ── Save ──────────────────────────────────────────────────
                  FilledButton(
                    onPressed:
                        (_canSave && (!hasConflict || _acknowledgedConflict))
                            ? _save
                            : null,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      disabledBackgroundColor: cs.primary.withOpacity(0.25),
                    ),
                    child: Text(
                      _isEdit ? 'Update Test Drive' : 'Schedule Test Drive',
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: cs.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String label, ThemeData theme, ColorScheme cs) =>
      Text(label,
          style: theme.textTheme.labelMedium!.copyWith(
            color: cs.onSurfaceVariant,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ));

  InputDecoration _deco(ColorScheme cs, String label, {String? hint}) =>
      InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: cs.surfaceVariant.withOpacity(0.4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.outline.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.primary, width: 1.5),
        ),
      );
}

// ─── Locked chip ──────────────────────────────────────────────────────────────

class _LockedChip extends StatelessWidget {
  const _LockedChip({
    required this.label,
    required this.icon,
    required this.cs,
    required this.theme,
  });
  final String label;
  final IconData icon;
  final ColorScheme cs;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: cs.primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cs.primary.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: cs.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(label,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: cs.primary,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            Icon(Icons.lock_outline_rounded,
                size: 14, color: cs.onSurface.withOpacity(0.3)),
          ],
        ),
      );
}

// ─── Tap-to-pick field ────────────────────────────────────────────────────────

class _TapField extends StatelessWidget {
  const _TapField({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.cs,
    required this.theme,
  });
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final ColorScheme cs;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cs.surfaceVariant.withOpacity(0.4),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.outline.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Icon(icon, size: 16, color: cs.onSurface.withOpacity(0.5)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(label,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: label.startsWith('Select')
                          ? cs.onSurface.withOpacity(0.4)
                          : cs.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
      );
}

// ─── Inline customer picker ───────────────────────────────────────────────────

class _CustomerPicker extends StatefulWidget {
  const _CustomerPicker({
    required this.selectedId,
    required this.selectedName,
    required this.onSelected,
    required this.onClear,
    required this.cs,
    required this.theme,
  });
  final String? selectedId;
  final String selectedName;
  final void Function(String id, String name, String phone) onSelected;
  final VoidCallback onClear;
  final ColorScheme cs;
  final ThemeData theme;

  @override
  State<_CustomerPicker> createState() => _CustomerPickerState();
}

class _CustomerPickerState extends State<_CustomerPicker> {
  final _ctr = TextEditingController();
  bool _expanded = false;

  // Mock — replace with allCustomersProvider
  final _mockCustomers = const [
    ('cust_001', 'Arjun Mehta', '+919876543210'),
    ('cust_002', 'Priya Nair', '+919845001122'),
    ('cust_003', 'Vikram Patel', '+917698001234'),
    ('cust_005', 'Rahul Gupta', '+919512345678'),
    ('cust_006', 'Anjali Singh', '+917755443322'),
    ('cust_007', 'Karan Shah', '+919898765432'),
    ('cust_008', 'Deepika Rao', '+918877665544'),
  ];

  @override
  void dispose() {
    _ctr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = widget.cs;
    final theme = widget.theme;

    if (widget.selectedId != null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: cs.primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cs.primary.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(Icons.person_rounded, size: 16, color: cs.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(widget.selectedName,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: cs.primary,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            GestureDetector(
              onTap: widget.onClear,
              child: Icon(Icons.close_rounded, size: 16, color: cs.primary),
            ),
          ],
        ),
      );
    }

    final q = _ctr.text.toLowerCase();
    final filtered = _mockCustomers
        .where((c) =>
            q.isEmpty || c.$2.toLowerCase().contains(q) || c.$3.contains(q))
        .toList();

    return Column(
      children: [
        TextField(
          controller: _ctr,
          onChanged: (_) => setState(() => _expanded = true),
          onTap: () => setState(() => _expanded = true),
          decoration: InputDecoration(
            hintText: 'Search customer…',
            prefixIcon: const Icon(Icons.search, size: 18),
            filled: true,
            fillColor: cs.surfaceVariant.withOpacity(0.4),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: cs.outline.withOpacity(0.2)),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
          ),
        ),
        if (_expanded && filtered.isNotEmpty) ...[
          const SizedBox(height: 4),
          ...filtered.take(4).map((c) => GestureDetector(
                onTap: () {
                  widget.onSelected(c.$1, c.$2, c.$3);
                  setState(() => _expanded = false);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: cs.surfaceVariant.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(c.$2, style: theme.textTheme.bodyMedium)),
                      Text(c.$3,
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: cs.onSurface.withOpacity(0.4))),
                    ],
                  ),
                ),
              )),
        ],
      ],
    );
  }
}

// ─── Inline car picker ────────────────────────────────────────────────────────

class _CarPicker extends StatefulWidget {
  const _CarPicker({
    required this.selectedId,
    required this.selectedName,
    required this.onSelected,
    required this.onClear,
    required this.cs,
    required this.theme,
  });
  final String? selectedId;
  final String? selectedName;
  final void Function(String id, String make, String model, int year)
      onSelected;
  final VoidCallback onClear;
  final ColorScheme cs;
  final ThemeData theme;

  @override
  State<_CarPicker> createState() => _CarPickerState();
}

class _CarPickerState extends State<_CarPicker> {
  final _ctr = TextEditingController();
  bool _expanded = false;

  // Mock — replace with carsNotifierProvider filtered to available/reserved
  final _mockCars = const [
    ('car_001', 'Maruti Suzuki', 'Baleno Alpha', 2024),
    ('car_002', 'Hyundai', 'Creta SX(O)', 2024),
    ('car_003', 'Tata', 'Nexon EV Max', 2023),
    ('car_005', 'Toyota', 'Innova Crysta GX', 2023),
    ('car_006', 'Maruti Suzuki', 'Swift ZXi+', 2024),
    ('car_007', 'Tata', 'Punch Creative', 2024),
  ];

  @override
  void dispose() {
    _ctr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = widget.cs;
    final theme = widget.theme;

    if (widget.selectedId != null && widget.selectedName != null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: cs.primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cs.primary.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(Icons.directions_car_rounded, size: 16, color: cs.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(widget.selectedName!,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: cs.primary,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            GestureDetector(
              onTap: widget.onClear,
              child: Icon(Icons.close_rounded, size: 16, color: cs.primary),
            ),
          ],
        ),
      );
    }

    final q = _ctr.text.toLowerCase();
    final filtered = _mockCars
        .where((c) =>
            q.isEmpty ||
            c.$2.toLowerCase().contains(q) ||
            c.$3.toLowerCase().contains(q))
        .toList();

    return Column(
      children: [
        TextField(
          controller: _ctr,
          onChanged: (_) => setState(() => _expanded = true),
          onTap: () => setState(() => _expanded = true),
          decoration: InputDecoration(
            hintText: 'Search vehicle…',
            prefixIcon: const Icon(Icons.search, size: 18),
            filled: true,
            fillColor: cs.surfaceVariant.withOpacity(0.4),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: cs.outline.withOpacity(0.2)),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
          ),
        ),
        if (_expanded && filtered.isNotEmpty) ...[
          const SizedBox(height: 4),
          ...filtered.take(4).map((c) => GestureDetector(
                onTap: () {
                  widget.onSelected(c.$1, c.$2, c.$3, c.$4);
                  setState(() => _expanded = false);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: cs.surfaceVariant.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('${c.$2} ${c.$3}',
                            style: theme.textTheme.bodyMedium),
                      ),
                      Text('${c.$4}',
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: cs.onSurface.withOpacity(0.4))),
                    ],
                  ),
                ),
              )),
        ],
      ],
    );
  }
}

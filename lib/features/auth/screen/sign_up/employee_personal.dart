// features/auth/steps/signup_step4_employee_personal.dart

import 'package:autovault/core/utils/formatters.dart';
import 'package:autovault/data/models/user_model.dart';
import 'package:autovault/features/auth/providers/sign_up_provider.dart';
import 'package:autovault/features/shared/widgets/avatar_widget.dart';
import 'package:autovault/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupStep4EmployeePersonal extends ConsumerStatefulWidget {
  const SignupStep4EmployeePersonal({super.key});

  @override
  ConsumerState<SignupStep4EmployeePersonal> createState() =>
      _SignupStep4EmployeePersonalState();
}

class _SignupStep4EmployeePersonalState
    extends ConsumerState<SignupStep4EmployeePersonal> {
  final _formKey = GlobalKey<FormState>();
  final _firstCtr = TextEditingController();
  final _lastCtr = TextEditingController();
  final _phoneCtr = TextEditingController();
  final _codeCtr = TextEditingController();
  final _empIdCtr = TextEditingController();
  Gender? _gender;
  DateTime? _dob;
  final bool _isLoading = false;

  bool get _canContinue =>
      _firstCtr.text.trim().isNotEmpty &&
      _lastCtr.text.trim().isNotEmpty &&
      _phoneCtr.text.length == 10 &&
      _codeCtr.text.length == 6;

  String get _fullName =>
      '${_firstCtr.text.trim()} ${_lastCtr.text.trim()}'.trim();

  @override
  void dispose() {
    _firstCtr.dispose();
    _lastCtr.dispose();
    _phoneCtr.dispose();
    _codeCtr.dispose();
    _empIdCtr.dispose();
    super.dispose();
  }

  Future<void> _pickDob() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1995),
      firstDate: DateTime(1960),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 16)),
    );
    if (picked != null) setState(() => _dob = picked);
  }

  Future<void> _completeSetup() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();

    final personal = UserProfileData(
      firstName: _firstCtr.text.trim(),
      lastName: _lastCtr.text.trim(),
      phone: '+91${_phoneCtr.text.trim()}',
      dateOfBirth: _dob,
      gender: _gender,
      // employee only:
      showroomCode: _codeCtr.text.trim().toUpperCase(),
      employeeId: _empIdCtr.text.trim(),
    );

    await ref
        .read(signUpNotifierProvider.notifier)
        .completeSignUp(personal, ref, context);

    // Show error from auth provider if it failed
    final error = ref.read(authNotifierProvider).error;
    if (error != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
      ref.read(authNotifierProvider.notifier).clearError();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Set up your profile',
                          style: theme.textTheme.headlineSmall!
                              .copyWith(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 4),
                      Text('Tell us a bit about yourself',
                          style: theme.textTheme.bodyMedium!.copyWith(
                              color: cs.onSurface.withValues(alpha: 0.5))),
                      const SizedBox(height: 28),

                      // Avatar
                      Center(
                        child: GestureDetector(
                          onTap: () => ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  content: Text(
                                      'Photo picker — wire image_picker here'))),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              AvatarWidget(
                                  name: _fullName.isEmpty ? '?' : _fullName,
                                  radius: 40),
                              CircleAvatar(
                                radius: 14,
                                backgroundColor: cs.primary,
                                child: const Icon(Icons.camera_alt,
                                    size: 14, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Name
                      Row(
                        children: [
                          Expanded(
                              child: _field(cs, 'First Name', _firstCtr,
                                  onChanged: (_) => setState(() {}))),
                          const SizedBox(width: 10),
                          Expanded(
                              child: _field(cs, 'Last Name', _lastCtr,
                                  onChanged: (_) => setState(() {}))),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Phone
                      TextFormField(
                        controller: _phoneCtr,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        onChanged: (_) => setState(() {}),
                        decoration: _deco(cs, 'Phone Number *')
                            .copyWith(prefixText: '+91 '),
                        validator: (v) => v == null || v.length != 10
                            ? 'Enter a valid 10-digit number'
                            : null,
                      ),
                      const SizedBox(height: 14),

                      // DOB
                      GestureDetector(
                        onTap: _pickDob,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color:
                                cs.surfaceContainerHigh.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                                color: cs.outline.withValues(alpha: 0.2)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.cake_outlined,
                                  size: 18,
                                  color: cs.onSurface.withValues(alpha: 0.5)),
                              const SizedBox(width: 10),
                              Text(
                                _dob != null
                                    ? formatDobWithAge(_dob!)
                                    : 'Date of Birth (optional)',
                                style: _dob != null
                                    ? theme.textTheme.bodyMedium
                                    : theme.textTheme.bodyMedium!.copyWith(
                                        color: cs.onSurface
                                            .withValues(alpha: 0.4)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Gender
                      Text('Gender (optional)',
                          style: theme.textTheme.labelMedium!.copyWith(
                              color: cs.onSurface.withValues(alpha: 0.5))),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: Gender.values.map((g) {
                          final sel = _gender == g;
                          return ChoiceChip(
                            label: Text(g.label),
                            selected: sel,
                            onSelected: (_) =>
                                setState(() => _gender = sel ? null : g),
                            selectedColor: cs.primary,
                            backgroundColor: Colors.transparent,
                            labelStyle: TextStyle(
                              color: sel ? cs.onPrimary : cs.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                            side: BorderSide(
                                color: sel
                                    ? cs.primary
                                    : cs.outline.withValues(alpha: 0.4)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),

                      // Showroom code
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _codeCtr,
                              textCapitalization: TextCapitalization.characters,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[A-Za-z0-9]')),
                                LengthLimitingTextInputFormatter(6),
                                _UpperCase(),
                              ],
                              onChanged: (_) => setState(() {}),
                              decoration:
                                  _deco(cs, 'Showroom Code *', hint: 'ABC123'),
                              validator: (v) => v == null || v.length != 6
                                  ? 'Enter the 6-character showroom code'
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Tooltip(
                            message:
                                'Ask your showroom owner for the 6-character showroom code.',
                            child: Icon(Icons.help_outline_rounded,
                                size: 20,
                                color: cs.onSurface.withValues(alpha: 0.4)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Employee ID
                      _field(cs, 'Employee ID (optional)', _empIdCtr,
                          validator: null),
                      const SizedBox(height: 12),

                      // Info banner
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFC107).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: const Color(0xFFFFC107)
                                  .withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.info_outline_rounded,
                                size: 15, color: Color(0xFFFFC107)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Your account will be linked to the showroom once the owner approves your request.',
                                style: theme.textTheme.labelSmall!.copyWith(
                                    color: const Color(0xFFFFC107),
                                    fontSize: 11),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _StepButton(
              label: 'Complete Setup',
              enabled: _canContinue && !_isLoading,
              onTap: _completeSetup,
              cs: cs,
              theme: theme,
            ),
          ],
        ),

        // Loading overlay
        if (_isLoading)
          Container(
            color: cs.surface.withValues(alpha: 0.92),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.directions_car_rounded,
                      size: 52, color: cs.primary),
                  const SizedBox(height: 20),
                  CircularProgressIndicator(color: cs.primary),
                  const SizedBox(height: 20),
                  Text('Setting up your account…',
                      style: theme.textTheme.bodyMedium!.copyWith(
                          color: cs.onSurface.withValues(alpha: 0.6))),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _field(
    ColorScheme cs,
    String label,
    TextEditingController ctr, {
    String? hint,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
  }) =>
      TextFormField(
        controller: ctr,
        onChanged: onChanged,
        textCapitalization: TextCapitalization.words,
        decoration: _deco(cs, label, hint: hint),
        validator: validator ??
            (v) => v == null || v.trim().isEmpty ? '$label is required' : null,
      );

  InputDecoration _deco(ColorScheme cs, String label, {String? hint}) =>
      InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: cs.surfaceContainerHigh.withValues(alpha: 0.4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: cs.outline.withValues(alpha: 0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: cs.primary, width: 1.5),
        ),
      );
}

class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.label,
    required this.enabled,
    required this.onTap,
    required this.cs,
    required this.theme,
  });
  final String label;
  final bool enabled;
  final VoidCallback onTap;
  final ColorScheme cs;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.fromLTRB(
            24, 12, 24, MediaQuery.of(context).padding.bottom + 12),
        decoration: BoxDecoration(
          color: cs.surface,
          border: Border(
              top: BorderSide(color: cs.outline.withValues(alpha: 0.12))),
        ),
        child: SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: enabled ? onTap : null,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              disabledBackgroundColor: cs.primary.withValues(alpha: 0.25),
            ),
            child: Text(label,
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: enabled
                      ? cs.onPrimary
                      : cs.onPrimary.withValues(alpha: 0.4),
                  fontWeight: FontWeight.w700,
                )),
          ),
        ),
      );
}

class _UpperCase extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue _, TextEditingValue n) =>
      n.copyWith(text: n.text.toUpperCase());
}

import 'package:autovault/core/utils/formatters.dart';
import 'package:autovault/data/models/user_model.dart';
import 'package:autovault/features/auth/providers/sign_up_provider.dart';
import 'package:autovault/features/shared/widgets/avatar_widget.dart';
import 'package:autovault/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupStep5OwnerPersonal extends ConsumerStatefulWidget {
  const SignupStep5OwnerPersonal({super.key});

  @override
  ConsumerState<SignupStep5OwnerPersonal> createState() =>
      _SignupStep5OwnerPersonalState();
}

class _SignupStep5OwnerPersonalState
    extends ConsumerState<SignupStep5OwnerPersonal> {
  final _formKey = GlobalKey<FormState>();
  final _firstCtr = TextEditingController();
  final _lastCtr = TextEditingController();
  final _phoneCtr = TextEditingController();
  Gender? _gender;
  DateTime? _dob;
  final bool _isLoading = false;

  bool get _canContinue =>
      _firstCtr.text.trim().isNotEmpty &&
      _lastCtr.text.trim().isNotEmpty &&
      _phoneCtr.text.length == 10;

  String get _fullName =>
      '${_firstCtr.text.trim()} ${_lastCtr.text.trim()}'.trim();

  @override
  void dispose() {
    _firstCtr.dispose();
    _lastCtr.dispose();
    _phoneCtr.dispose();
    super.dispose();
  }

  Future<void> _pickDob() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1985),
      firstDate: DateTime(1940),
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
                      Text('Almost there!',
                          style: theme.textTheme.headlineSmall!
                              .copyWith(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 4),
                      Text('Set up your personal profile',
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: cs.onSurface.withOpacity(0.5))),
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

                      // First + Last Name
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
                        decoration: _deco(cs, 'Phone Number')
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
                            color: cs.surfaceVariant.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(14),
                            border:
                                Border.all(color: cs.outline.withOpacity(0.2)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.cake_outlined,
                                  size: 18,
                                  color: cs.onSurface.withOpacity(0.5)),
                              const SizedBox(width: 10),
                              Text(
                                _dob != null
                                    ? formatDobWithAge(_dob!)
                                    : 'Date of Birth (optional)',
                                style: _dob != null
                                    ? theme.textTheme.bodyMedium
                                    : theme.textTheme.bodyMedium!.copyWith(
                                        color: cs.onSurface.withOpacity(0.4)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Gender
                      Text('Gender (optional)',
                          style: theme.textTheme.labelMedium!.copyWith(
                            color: cs.onSurface.withOpacity(0.5),
                          )),
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
                                  : cs.outline.withOpacity(0.4),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 28),

                      Center(
                        child: Text(
                          'Your showroom dashboard is ready to go 🚀',
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: cs.onSurface.withOpacity(0.35)),
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
            color: cs.surface.withOpacity(0.92),
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
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: cs.onSurface.withOpacity(0.6))),
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
    void Function(String)? onChanged,
  }) =>
      TextFormField(
        controller: ctr,
        onChanged: onChanged,
        textCapitalization: TextCapitalization.words,
        decoration: _deco(cs, label),
        validator: (v) =>
            v == null || v.trim().isEmpty ? '$label is required' : null,
      );

  InputDecoration _deco(ColorScheme cs, String label) => InputDecoration(
        labelText: label,
        filled: true,
        fillColor: cs.surfaceVariant.withOpacity(0.4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: cs.outline.withOpacity(0.2)),
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
          border: Border(top: BorderSide(color: cs.outline.withOpacity(0.12))),
        ),
        child: SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: enabled ? onTap : null,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              disabledBackgroundColor: cs.primary.withOpacity(0.25),
            ),
            child: Text(label,
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: enabled ? cs.onPrimary : cs.onPrimary.withOpacity(0.4),
                  fontWeight: FontWeight.w700,
                )),
          ),
        ),
      );
}

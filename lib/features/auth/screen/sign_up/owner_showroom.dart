import 'package:autovault/data/models/showroom_model.dart';
import 'package:autovault/features/auth/providers/sign_up_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _gstRegex =
    RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$');

class SignupStep4OwnerShowroom extends ConsumerStatefulWidget {
  const SignupStep4OwnerShowroom({super.key});

  @override
  ConsumerState<SignupStep4OwnerShowroom> createState() =>
      _SignupStep4OwnerShowroomState();
}

class _SignupStep4OwnerShowroomState
    extends ConsumerState<SignupStep4OwnerShowroom> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtr = TextEditingController();
  final _gstCtr = TextEditingController();
  final _phoneCtr = TextEditingController();
  final _emailCtr = TextEditingController();
  final _addr1Ctr = TextEditingController();
  final _addr2Ctr = TextEditingController();
  final _cityCtr = TextEditingController();
  final _pinCtr = TextEditingController();
  String? _state;

  bool get _canContinue => _nameCtr.text.trim().isNotEmpty;

  @override
  void dispose() {
    for (final c in [
      _nameCtr,
      _gstCtr,
      _phoneCtr,
      _emailCtr,
      _addr1Ctr,
      _addr2Ctr,
      _cityCtr,
      _pinCtr
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  void _continue() {
    if (!_formKey.currentState!.validate()) return;
    final data = ShowroomFormData(
      name: _nameCtr.text.trim(),
      gstNumber: _gstCtr.text.trim(),
      phone: '+91${_phoneCtr.text.trim()}',
      email: _emailCtr.text.trim(),
      address: '${_addr1Ctr.text.trim()} ${_addr2Ctr.text.trim()}'.trim(),
      city: _cityCtr.text.trim(),
      state: _state ?? '',
      pinCode: _pinCtr.text.trim(),
    );
    ref.read(signUpNotifierProvider.notifier).setShowroomData(data);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Set up your showroom',
                      style: theme.textTheme.headlineSmall!
                          .copyWith(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  Text('Tell us about the showroom you manage',
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: cs.onSurface.withOpacity(0.5))),
                  const SizedBox(height: 28),

                  // Logo picker stub
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: cs.surfaceVariant,
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: cs.outline.withOpacity(0.2)),
                          ),
                          child: Icon(Icons.storefront_rounded,
                              size: 36, color: cs.onSurface.withOpacity(0.3)),
                        ),
                        GestureDetector(
                          onTap: () => ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  content: Text(
                                      'Logo picker — wire image_picker here'))),
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: cs.primary,
                            child: const Icon(Icons.camera_alt,
                                size: 14, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Showroom name
                  _field(cs, 'Showroom Name *', _nameCtr,
                      hint: 'e.g. Sharma Motors',
                      onChanged: (_) => setState(() {})),
                  const SizedBox(height: 14),

                  // GST
                  TextFormField(
                    controller: _gstCtr,
                    textCapitalization: TextCapitalization.characters,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
                      LengthLimitingTextInputFormatter(15),
                      _UpperCaseFormatter(),
                    ],
                    decoration:
                        _deco(cs, 'GST Number', hint: '27AAPFU0939F1ZV'),
                    validator: (v) {
                      if (v == null || v.isEmpty) return null;
                      if (!_gstRegex.hasMatch(v)) {
                        return 'Enter a valid 15-character Indian GST number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),

                  // GST info banner
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFC107).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: const Color(0xFFFFC107).withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline_rounded,
                            size: 15, color: Color(0xFFFFC107)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Your GST number will appear on all generated receipts and invoices.',
                            style: theme.textTheme.labelSmall!.copyWith(
                                color: const Color(0xFFFFC107), fontSize: 11),
                          ),
                        ),
                      ],
                    ),
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
                    decoration: _deco(cs, 'Phone Number', hint: '9876543210')
                        .copyWith(prefixText: '+91 '),
                    validator: (v) {
                      if (v == null || v.isEmpty) return null;
                      if (v.length != 10) {
                        return 'Enter a valid 10-digit number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),

                  // Email
                  _field(cs, 'Email (optional)', _emailCtr,
                      hint: 'showroom@example.com',
                      keyboardType: TextInputType.emailAddress,
                      validator: null),
                  const SizedBox(height: 14),

                  // Address
                  _field(cs, 'Address Line 1', _addr1Ctr, hint: '14, MG Road'),
                  const SizedBox(height: 10),
                  _field(cs, 'Address Line 2 (optional)', _addr2Ctr,
                      hint: 'Near City Mall', validator: null),
                  const SizedBox(height: 14),

                  // City + PIN
                  Row(
                    children: [
                      Expanded(
                          child: _field(cs, 'City', _cityCtr, hint: 'Surat')),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _pinCtr,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(6),
                          ],
                          decoration: _deco(cs, 'PIN Code', hint: '395007'),
                          validator: (v) {
                            if (v == null || v.isEmpty) return null;
                            if (v.length != 6) return 'Enter 6-digit PIN';
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // State dropdown
                  DropdownButtonFormField<String>(
                    value: _state,
                    decoration: _deco(cs, 'State'),
                    items: indianStates
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (v) => setState(() => _state = v),
                  ),
                ],
              ),
            ),
          ),
        ),
        _StepButton(
          label: 'Continue',
          enabled: _canContinue,
          onTap: _continue,
          cs: cs,
          theme: theme,
        ),
      ],
    );
  }

  Widget _field(
    ColorScheme cs,
    String label,
    TextEditingController ctr, {
    String? hint,
    TextInputType? keyboardType,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
  }) =>
      TextFormField(
        controller: ctr,
        keyboardType: keyboardType,
        onChanged: onChanged,
        decoration: _deco(cs, label, hint: hint),
        validator: validator ??
            (v) => v == null || v.trim().isEmpty ? '$label is required' : null,
      );

  InputDecoration _deco(ColorScheme cs, String label, {String? hint}) =>
      InputDecoration(
        labelText: label,
        hintText: hint,
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

class _UpperCaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue _, TextEditingValue n) =>
      n.copyWith(text: n.text.toUpperCase());
}

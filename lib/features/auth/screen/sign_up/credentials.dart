import 'package:autovault/features/auth/providers/sign_up_provider.dart';
import 'package:autovault/features/auth/widgets/password_strength_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupStep1Credentials extends ConsumerStatefulWidget {
  const SignupStep1Credentials({super.key});

  @override
  ConsumerState<SignupStep1Credentials> createState() =>
      _SignupStep1CredentialsState();
}

class _SignupStep1CredentialsState
    extends ConsumerState<SignupStep1Credentials> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtr = TextEditingController();
  final _passCtr = TextEditingController();
  final _confirmCtr = TextEditingController();

  bool _obscurePass = true;
  bool _obscureConfirm = true;
  bool _agreedToTerms = false;
  String _password = '';
  String _confirmPass = '';

  bool get _emailValid =>
      _emailCtr.text.isNotEmpty && _emailCtr.text.contains('@');

  bool get _canContinue =>
      _emailValid &&
      _password.length >= 6 &&
      _password == _confirmPass &&
      _agreedToTerms;

  @override
  void dispose() {
    _emailCtr.dispose();
    _passCtr.dispose();
    _confirmCtr.dispose();
    super.dispose();
  }

  void _continue() {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please accept the Terms of Service to continue.')),
      );
      return;
    }
    ref
        .read(signUpNotifierProvider.notifier)
        .setCredentials(_emailCtr.text.trim(), _passCtr.text);
    ref.read(signUpNotifierProvider.notifier).verifyOtp();
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
                  Text('Create your account',
                      style: theme.textTheme.headlineSmall!
                          .copyWith(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  Text('Start with your login credentials',
                      style: theme.textTheme.bodyMedium!.copyWith(
                          color: cs.onSurface.withValues(alpha: 0.5))),
                  const SizedBox(height: 28),

                  // Email
                  TextFormField(
                    controller: _emailCtr,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onChanged: (_) => setState(() {}),
                    decoration: _deco(cs, 'Email address',
                        prefix: Icons.mail_outline_rounded,
                        suffix: _emailValid
                            ? const Icon(Icons.check_circle_rounded,
                                color: Color(0xFF4CAF50), size: 18)
                            : null),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Email is required';
                      if (!v.contains('@')) return 'Enter a valid email';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Password
                  TextFormField(
                    controller: _passCtr,
                    obscureText: _obscurePass,
                    textInputAction: TextInputAction.next,
                    onChanged: (v) => setState(() => _password = v),
                    decoration: _deco(cs, 'Password',
                        prefix: Icons.lock_outline_rounded,
                        suffix: IconButton(
                          icon: Icon(
                            _obscurePass
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 20,
                            color: cs.onSurface.withValues(alpha: 0.5),
                          ),
                          onPressed: () =>
                              setState(() => _obscurePass = !_obscurePass),
                        )),
                    validator: (v) {
                      if (v == null || v.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),

                  // Strength indicator — purely reactive to _password
                  PasswordStrengthIndicator(password: _password),
                  const SizedBox(height: 16),

                  // Confirm password
                  TextFormField(
                    controller: _confirmCtr,
                    obscureText: _obscureConfirm,
                    textInputAction: TextInputAction.done,
                    onChanged: (v) => setState(() => _confirmPass = v),
                    decoration: _deco(cs, 'Confirm Password',
                        prefix: Icons.lock_outline_rounded,
                        suffix: _confirmPass.isNotEmpty
                            ? Icon(
                                _confirmPass == _password
                                    ? Icons.check_circle_rounded
                                    : Icons.cancel_rounded,
                                size: 18,
                                color: _confirmPass == _password
                                    ? const Color(0xFF4CAF50)
                                    : cs.error,
                              )
                            : IconButton(
                                icon: Icon(
                                  _obscureConfirm
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  size: 20,
                                  color: cs.onSurface.withValues(alpha: 0.5),
                                ),
                                onPressed: () => setState(
                                    () => _obscureConfirm = !_obscureConfirm),
                              )),
                    validator: (v) {
                      if (v != _passCtr.text) return 'Passwords do not match';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Terms checkbox
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _agreedToTerms,
                        onChanged: (v) =>
                            setState(() => _agreedToTerms = v ?? false),
                        activeColor: cs.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: RichText(
                            text: TextSpan(
                              text: 'I agree to the ',
                              style: theme.textTheme.bodySmall!.copyWith(
                                  color: cs.onSurface.withValues(alpha: 0.6)),
                              children: [
                                WidgetSpan(
                                  child: GestureDetector(
                                    onTap: () => ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                            content: Text(
                                                'Terms of Service — placeholder'))),
                                    child: Text('Terms of Service',
                                        style: TextStyle(
                                          color: cs.primary,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        )),
                                  ),
                                ),
                                TextSpan(
                                    text: ' and ',
                                    style: theme.textTheme.bodySmall!.copyWith(
                                        color: cs.onSurface
                                            .withValues(alpha: 0.6))),
                                WidgetSpan(
                                  child: GestureDetector(
                                    onTap: () => ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                            content: Text(
                                                'Privacy Policy — placeholder'))),
                                    child: Text('Privacy Policy',
                                        style: TextStyle(
                                          color: cs.primary,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        // ── Bottom button ────────────────────────────────────────────────
        _BottomButton(
          label: 'Continue',
          enabled: _canContinue,
          onTap: _continue,
          cs: cs,
          theme: theme,
        ),
      ],
    );
  }

  InputDecoration _deco(ColorScheme cs, String label,
          {IconData? prefix, Widget? suffix}) =>
      InputDecoration(
        labelText: label,
        prefixIcon: prefix != null ? Icon(prefix, size: 20) : null,
        suffixIcon: suffix,
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

// ─── Shared bottom button used across all steps ───────────────────────────────

class _BottomButton extends StatelessWidget {
  const _BottomButton({
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

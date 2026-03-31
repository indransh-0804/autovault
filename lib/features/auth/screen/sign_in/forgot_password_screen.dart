import 'package:autovault/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtr = TextEditingController();
  bool _sent = false;

  @override
  void dispose() {
    _emailCtr.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();

    final ok = await ref
        .read(authNotifierProvider.notifier)
        .sendPasswordReset(_emailCtr.text.trim());

    if (ok && mounted) setState(() => _sent = true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isLoading = ref.watch(authNotifierProvider).isLoading;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: cs.surface,
        appBar: AppBar(
          backgroundColor: cs.surface,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => context.pop(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: _sent
              ? _SuccessView(email: _emailCtr.text.trim(), cs: cs, theme: theme)
              : _FormView(
                  formKey: _formKey,
                  emailCtr: _emailCtr,
                  isLoading: isLoading,
                  onSend: _send,
                  cs: cs,
                  theme: theme,
                ),
        ),
      ),
    );
  }
}

class _FormView extends StatelessWidget {
  const _FormView({
    required this.formKey,
    required this.emailCtr,
    required this.isLoading,
    required this.onSend,
    required this.cs,
    required this.theme,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController emailCtr;
  final bool isLoading;
  final VoidCallback onSend;
  final ColorScheme cs;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.lock_reset_rounded, size: 48, color: cs.primary),
            const SizedBox(height: 20),
            Text('Reset Password',
                style: theme.textTheme.headlineSmall!
                    .copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text(
              "Enter your registered email and we'll send you a reset link.",
              style: theme.textTheme.bodyMedium!
                  .copyWith(color: cs.onSurface.withOpacity(0.5)),
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: emailCtr,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email address',
                prefixIcon: const Icon(Icons.mail_outline_rounded, size: 20),
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
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Email is required';
                if (!v.contains('@')) return 'Enter a valid email';
                return null;
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: isLoading ? null : onSend,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: isLoading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: cs.onPrimary),
                      )
                    : Text('Send Reset Link',
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: cs.onPrimary,
                          fontWeight: FontWeight.w700,
                        )),
              ),
            ),
          ],
        ),
      );
}

class _SuccessView extends StatelessWidget {
  const _SuccessView(
      {required this.email, required this.cs, required this.theme});
  final String email;
  final ColorScheme cs;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.mark_email_read_rounded, size: 72, color: cs.primary),
          const SizedBox(height: 24),
          Text('Check your inbox',
              style: theme.textTheme.headlineSmall!
                  .copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "We've sent a reset link to\n",
              style: theme.textTheme.bodyMedium!
                  .copyWith(color: cs.onSurface.withOpacity(0.5)),
              children: [
                TextSpan(
                  text: email,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: cs.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => context.go('/signin'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                side: BorderSide(color: cs.primary.withOpacity(0.5)),
                foregroundColor: cs.primary,
              ),
              child: const Text('Back to Sign In',
                  style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      );
}

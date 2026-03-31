// features/auth/widgets/password_strength_indicator.dart

import 'package:flutter/material.dart';

// ─── Strength model ───────────────────────────────────────────────────────────

class PasswordStrength {
  final int score; // 0–4
  final bool hasLength;
  final bool hasUppercase;
  final bool hasNumber;
  final bool hasSpecial;

  const PasswordStrength({
    required this.score,
    required this.hasLength,
    required this.hasUppercase,
    required this.hasNumber,
    required this.hasSpecial,
  });

  static PasswordStrength evaluate(String password) {
    final hasLength    = password.length >= 8;
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasNumber    = password.contains(RegExp(r'[0-9]'));
    final hasSpecial   = password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));

    final score = [hasLength, hasUppercase, hasNumber, hasSpecial]
        .where((b) => b)
        .length;

    return PasswordStrength(
      score:        score,
      hasLength:    hasLength,
      hasUppercase: hasUppercase,
      hasNumber:    hasNumber,
      hasSpecial:   hasSpecial,
    );
  }

  String get label => switch (score) {
        0 || 1 => 'Weak',
        2      => 'Fair',
        3      => 'Good',
        _      => 'Strong',
      };

  Color get color => switch (score) {
        0 || 1 => const Color(0xFFF44336),
        2      => const Color(0xFFFFC107),
        3      => const Color(0xFF66BB6A),
        _      => const Color(0xFF4CAF50),
      };
}

// ─── Widget ───────────────────────────────────────────────────────────────────

class PasswordStrengthIndicator extends StatelessWidget {
  const PasswordStrengthIndicator({
    super.key,
    required this.password,
  });

  final String password;

  @override
  Widget build(BuildContext context) {
    final theme    = Theme.of(context);
    final cs       = theme.colorScheme;
    final strength = PasswordStrength.evaluate(password);

    if (password.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        // ── Segmented bar ──────────────────────────────────────────────
        Row(
          children: List.generate(4, (i) {
            final filled = i < strength.score;
            return Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 4,
                margin: EdgeInsets.only(right: i < 3 ? 4 : 0),
                decoration: BoxDecoration(
                  color: filled
                      ? strength.color
                      : cs.outline.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              strength.label,
              style: theme.textTheme.labelSmall!.copyWith(
                color: strength.color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // ── Criteria checklist ─────────────────────────────────────────
        _Criterion('At least 8 characters', strength.hasLength, theme, cs),
        _Criterion('Uppercase letter', strength.hasUppercase, theme, cs),
        _Criterion('Number', strength.hasNumber, theme, cs),
        _Criterion('Special character', strength.hasSpecial, theme, cs),
      ],
    );
  }
}

class _Criterion extends StatelessWidget {
  const _Criterion(this.label, this.met, this.theme, this.cs);
  final String label;
  final bool met;
  final ThemeData theme;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: Row(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                met ? Icons.check_circle_rounded : Icons.circle_outlined,
                key: ValueKey(met),
                size: 14,
                color: met
                    ? const Color(0xFF4CAF50)
                    : cs.onSurface.withOpacity(0.3),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: theme.textTheme.labelSmall!.copyWith(
                color: met
                    ? cs.onSurface.withOpacity(0.75)
                    : cs.onSurface.withOpacity(0.4),
              ),
            ),
          ],
        ),
      );
}

import 'package:autovault/data/models/user_model.dart';
import 'package:autovault/features/auth/providers/sign_up_provider.dart';
import 'package:autovault/features/auth/widgets/role_selection_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupStep3Role extends ConsumerWidget {
  const SignupStep3Role({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final signUp = ref.watch(signUpNotifierProvider);
    final notifier = ref.read(signUpNotifierProvider.notifier);
    final selected = signUp.selectedRole;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("What's your role?",
                    style: theme.textTheme.headlineSmall!
                        .copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text('This determines your access level in the app',
                    style: theme.textTheme.bodyMedium!
                        .copyWith(color: cs.onSurface.withOpacity(0.5))),
                const SizedBox(height: 32),

                // Owner card
                RoleSelectionCard(
                  icon: Icons.business_center_rounded,
                  title: 'Owner / Manager',
                  subtitle:
                      'Full access — manage inventory, staff, finances, and analytics',
                  isSelected: selected == UserRole.owner,
                  onTap: () => notifier.setRole(UserRole.owner),
                ),
                const SizedBox(height: 14),

                // Employee card
                RoleSelectionCard(
                  icon: Icons.badge_rounded,
                  title: 'Employee / Salesperson',
                  subtitle: 'Manage your customers, sales, and test drives',
                  isSelected: selected == UserRole.employee,
                  onTap: () => notifier.setRole(UserRole.employee),
                ),
                const SizedBox(height: 24),

                // Supplier footnote
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cs.surfaceVariant.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline_rounded,
                          size: 16, color: cs.onSurface.withOpacity(0.4)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Are you a supplier? Ask the showroom owner to add you.',
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: cs.onSurface.withOpacity(0.45)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Bottom button
        _StepButton(
          label: 'Continue',
          enabled: selected != null,
          onTap: notifier.goToNextAfterRole,
          cs: cs,
          theme: theme,
        ),
      ],
    );
  }
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

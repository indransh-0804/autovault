// features/auth/signup_wrapper_screen.dart

import 'package:autovault/features/auth/providers/sign_up_provider.dart';
import 'package:autovault/features/auth/screen/sign_up/credentials.dart';
import 'package:autovault/features/auth/screen/sign_up/role.dart';
import 'package:autovault/features/auth/screen/sign_up/employee_personal.dart';
import 'package:autovault/features/auth/screen/sign_up/owner_showroom.dart';
import 'package:autovault/features/auth/screen/sign_up/owner_personal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignupWrapperScreen extends ConsumerStatefulWidget {
  const SignupWrapperScreen({super.key});

  @override
  ConsumerState<SignupWrapperScreen> createState() =>
      _SignupWrapperScreenState();
}

class _SignupWrapperScreenState extends ConsumerState<SignupWrapperScreen> {
  Future<bool> _confirmDiscard() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Cancel Sign Up?'),
        content: const Text('Your progress will be lost.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Keep Going'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Discard'),
          ),
        ],
      ),
    );
    return confirmed ?? false;
  }

  Future<void> _handleBack(SignUpStep step, SignUpNotifier notifier) async {
    switch (step) {
      case SignUpStep.credentials:
        final discard = await _confirmDiscard();
        if (discard && mounted) {
          notifier.reset();
          context.go('/signin');
        }
      case SignUpStep.role:
        notifier.backToRole();
      case SignUpStep.ownerShowroom:
        notifier.backToRole();
      case SignUpStep.ownerPersonal:
        notifier.backToOwnerShowroom();
      case SignUpStep.employeePersonal:
        notifier.backToRole();
    }
  }

  Widget _buildStep(SignUpStep step, SignUpState state) => switch (step) {
        SignUpStep.credentials => const SignupStep1Credentials(),
        SignUpStep.role => const SignupStep3Role(),
        SignUpStep.ownerShowroom => const SignupStep4OwnerShowroom(),
        SignUpStep.ownerPersonal => const SignupStep5OwnerPersonal(),
        SignUpStep.employeePersonal => const SignupStep4EmployeePersonal(),
      };

  String? _stepAction(SignUpStep step) => switch (step) {
        SignUpStep.ownerShowroom => 'Skip for now',
        _ => null,
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final signUp = ref.watch(signUpNotifierProvider);
    final notifier = ref.read(signUpNotifierProvider.notifier);
    final step = signUp.currentStep;
    final progress = signUp.currentStep.progress;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _handleBack(step, notifier);
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: cs.surface,
          appBar: AppBar(
            backgroundColor: cs.surface,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () => _handleBack(step, notifier),
            ),
            title: Text('AutoVault',
                style: theme.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w800,
                  color: cs.primary,
                )),
            actions: [
              if (_stepAction(step) != null)
                TextButton(
                  onPressed: () => notifier.setShowroomData(null),
                  child: Text(_stepAction(step)!,
                      style: theme.textTheme.bodySmall!.copyWith(
                        color: cs.onSurface.withValues(alpha: 0.5),
                      )),
                ),
              const SizedBox(width: 8),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4),
              child: _AnimatedProgressBar(progress: progress, cs: cs),
            ),
          ),
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 320),
            transitionBuilder: (child, animation) => SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.08),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: FadeTransition(opacity: animation, child: child),
            ),
            child: KeyedSubtree(
              key: ValueKey(step),
              child: _buildStep(step, signUp),
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedProgressBar extends StatelessWidget {
  const _AnimatedProgressBar({required this.progress, required this.cs});
  final double progress;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (_, constraints) => Stack(
          children: [
            Container(
              height: 3,
              width: constraints.maxWidth,
              color: cs.outline.withValues(alpha: 0.12),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOutCubic,
              height: 3,
              width: constraints.maxWidth * progress,
              decoration: BoxDecoration(
                color: cs.primary,
                borderRadius:
                    const BorderRadius.horizontal(right: Radius.circular(2)),
              ),
            ),
          ],
        ),
      );
}

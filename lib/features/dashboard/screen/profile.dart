import 'package:autovault/data/models/user_model.dart';
import 'package:autovault/features/auth/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with SingleTickerProviderStateMixin {
  bool _isEditing = false;
  bool _isLoading = false;

  late AnimationController _animController;
  late Animation<double> _fadeIn;

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeIn = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _animController.forward();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _populateControllers(UserModel user) {
    if (_firstNameController.text.isEmpty && !_isEditing) {
      _firstNameController.text = user.firstName;
      _lastNameController.text = user.lastName;
      _phoneController.text = user.phone;
    }
  }

  Future<void> _saveProfile(UserModel user) async {
    setState(() => _isLoading = true);
    try {
      await FirebaseFirestore.instance.collection('users').doc(user.id).update({
        'firstName': _firstNameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'phone': _phoneController.text.trim(),
      });
      await ref.read(authNotifierProvider.notifier).refreshUser();

      if (mounted) {
        _showSnackBar('Profile updated successfully', success: true);
        setState(() => _isEditing = false);
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('Failed to update profile. Please try again.',
            success: false);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message, {required bool success}) {
    final cs = Theme.of(context).colorScheme;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              success ? Icons.check_circle_rounded : Icons.error_rounded,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 10),
            Text(message, style: const TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: success ? const Color(0xFF4CAF50) : cs.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    if (user == null) {
      return Scaffold(
        backgroundColor: cs.surface,
        body: Center(
          child: CircularProgressIndicator(color: cs.primary),
        ),
      );
    }

    _populateControllers(user);

    return Scaffold(
      backgroundColor: cs.surface,
      body: FadeTransition(
        opacity: _fadeIn,
        child: CustomScrollView(
          slivers: [
            // ── Hero SliverAppBar ────────────────────────────────────────
            SliverAppBar(
              expandedHeight: 260,
              pinned: true,
              backgroundColor: cs.surface,
              surfaceTintColor: Colors.transparent,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: _EditToggleButton(
                    isEditing: _isEditing,
                    cs: cs,
                    onTap: () {
                      setState(() {
                        _isEditing = !_isEditing;
                        if (!_isEditing) {
                          _firstNameController.text = user.firstName;
                          _lastNameController.text = user.lastName;
                          _phoneController.text = user.phone;
                        }
                      });
                    },
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: _ProfileHero(user: user, cs: cs, tt: tt),
              ),
            ),

            // ── Body ─────────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Role chip + join date row
                    _MetaRow(user: user, cs: cs, tt: tt),
                    const SizedBox(height: 28),

                    _SectionLabel(
                        label: 'Personal Information', cs: cs, tt: tt),
                    const SizedBox(height: 14),

                    _ProfileCard(
                      cs: cs,
                      children: [
                        _EditableTile(
                          icon: Icons.person_outline_rounded,
                          label: 'First Name',
                          value: user.firstName,
                          controller: _firstNameController,
                          isEditing: _isEditing,
                          cs: cs,
                          tt: tt,
                        ),
                        _CardDivider(cs: cs),
                        _EditableTile(
                          icon: Icons.person_outline_rounded,
                          label: 'Last Name',
                          value: user.lastName,
                          controller: _lastNameController,
                          isEditing: _isEditing,
                          cs: cs,
                          tt: tt,
                        ),
                        _CardDivider(cs: cs),
                        _EditableTile(
                          icon: Icons.phone_outlined,
                          label: 'Phone Number',
                          value: user.phone,
                          controller: _phoneController,
                          isEditing: _isEditing,
                          cs: cs,
                          tt: tt,
                          keyboardType: TextInputType.phone,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    _SectionLabel(label: 'Account Details', cs: cs, tt: tt),
                    const SizedBox(height: 14),

                    _ProfileCard(
                      cs: cs,
                      children: [
                        _InfoTile(
                          icon: Icons.email_outlined,
                          label: 'Email Address',
                          value: user.email,
                          cs: cs,
                          tt: tt,
                        ),
                        if (user.employeeId.isNotEmpty) ...[
                          _CardDivider(cs: cs),
                          _InfoTile(
                            icon: Icons.badge_outlined,
                            label: 'Employee ID',
                            value: user.employeeId,
                            cs: cs,
                            tt: tt,
                            monospace: true,
                          ),
                        ],
                        if (user.dateOfBirth != null) ...[
                          _CardDivider(cs: cs),
                          _InfoTile(
                            icon: Icons.cake_outlined,
                            label: 'Date of Birth',
                            value: DateFormat.yMMMd().format(user.dateOfBirth!),
                            cs: cs,
                            tt: tt,
                          ),
                        ],
                      ],
                    ),

                    const SizedBox(height: 36),

                    // Save / Sign Out row
                    if (_isEditing) ...[
                      _SaveButton(
                        isLoading: _isLoading,
                        cs: cs,
                        onTap: () => _saveProfile(user),
                      ),
                      const SizedBox(height: 12),
                    ],

                    _SignOutButton(cs: cs, tt: tt),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Profile Hero ──────────────────────────────────────────────────────────

class _ProfileHero extends StatelessWidget {
  const _ProfileHero({required this.user, required this.cs, required this.tt});
  final UserModel user;
  final ColorScheme cs;
  final TextTheme tt;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            cs.primary.withOpacity(0.18),
            cs.surface,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          // Subtle grid overlay
          Positioned.fill(
            child: CustomPaint(painter: _GridPainter(cs.primary)),
          ),
          // Left glow
          Positioned(
            left: -60,
            top: -30,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    cs.primary.withOpacity(0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Avatar
                _Avatar(user: user, cs: cs, tt: tt),
                const SizedBox(width: 20),
                // Name + role
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${user.firstName} ${user.lastName}'.trim(),
                        style: tt.headlineSmall?.copyWith(
                          color: cs.onSurface,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: cs.primary.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: cs.primary.withOpacity(0.35), width: 0.8),
                        ),
                        child: Text(
                          user.role.name.toUpperCase(),
                          style: tt.labelSmall?.copyWith(
                            color: cs.primary,
                            letterSpacing: 1.8,
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
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.user, required this.cs, required this.tt});
  final UserModel user;
  final ColorScheme cs;
  final TextTheme tt;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [cs.primary, cs.tertiary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: CircleAvatar(
        radius: 44,
        backgroundColor: cs.surfaceContainerHighest,
        backgroundImage: user.profilePhotoUrl.isNotEmpty
            ? NetworkImage(user.profilePhotoUrl)
            : null,
        child: user.profilePhotoUrl.isEmpty
            ? Text(
                user.firstName.isNotEmpty
                    ? user.firstName[0].toUpperCase()
                    : '?',
                style: tt.headlineMedium?.copyWith(
                  color: cs.primary,
                  fontWeight: FontWeight.w800,
                ),
              )
            : null,
      ),
    );
  }
}

// ── Meta Row ───────────────────────────────────────────────────────────────

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.user, required this.cs, required this.tt});
  final UserModel user;
  final ColorScheme cs;
  final TextTheme tt;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.verified_user_outlined, color: cs.primary, size: 14),
        const SizedBox(width: 6),
        Text(
          'Active Account',
          style: tt.labelSmall?.copyWith(color: cs.primary, letterSpacing: 0.5),
        ),
        const SizedBox(width: 16),
        Icon(Icons.circle, color: cs.outlineVariant, size: 4),
        const SizedBox(width: 16),
        Icon(Icons.access_time_rounded, color: cs.onSurfaceVariant, size: 14),
        const SizedBox(width: 6),
        Text(
          user.email.split('@').last,
          style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant),
        ),
      ],
    );
  }
}

// ── Section Label ─────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(
      {required this.label, required this.cs, required this.tt});
  final String label;
  final ColorScheme cs;
  final TextTheme tt;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 14,
          decoration: BoxDecoration(
            color: cs.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          label.toUpperCase(),
          style: tt.labelSmall?.copyWith(
            color: cs.onSurfaceVariant,
            letterSpacing: 1.8,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

// ── Profile Card ──────────────────────────────────────────────────────────

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.children, required this.cs});
  final List<Widget> children;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withOpacity(0.28),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outlineVariant.withOpacity(0.5)),
      ),
      child: Column(children: children),
    );
  }
}

class _CardDivider extends StatelessWidget {
  const _CardDivider({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 0.5,
      color: cs.outlineVariant.withOpacity(0.4),
      indent: 56,
    );
  }
}

// ── Editable Tile ─────────────────────────────────────────────────────────

class _EditableTile extends StatelessWidget {
  const _EditableTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.controller,
    required this.isEditing,
    required this.cs,
    required this.tt,
    this.keyboardType = TextInputType.text,
  });
  final IconData icon;
  final String label;
  final String value;
  final TextEditingController controller;
  final bool isEditing;
  final ColorScheme cs;
  final TextTheme tt;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: cs.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, color: cs.primary, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: isEditing
                ? TextFormField(
                    controller: controller,
                    keyboardType: keyboardType,
                    style: tt.bodyMedium?.copyWith(
                        color: cs.onSurface, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      labelText: label,
                      labelStyle:
                          TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: cs.outlineVariant, width: 0.8),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: cs.primary, width: 1.5),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 4),
                      isDense: true,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label,
                          style: tt.labelSmall
                              ?.copyWith(color: cs.onSurfaceVariant)),
                      const SizedBox(height: 3),
                      Text(
                        value.isEmpty ? 'Not provided' : value,
                        style: tt.bodyMedium?.copyWith(
                          color: value.isEmpty
                              ? cs.onSurfaceVariant
                              : cs.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
          ),
          if (isEditing)
            Icon(Icons.edit_rounded,
                color: cs.primary.withOpacity(0.5), size: 16),
        ],
      ),
    );
  }
}

// ── Info Tile ─────────────────────────────────────────────────────────────

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.cs,
    required this.tt,
    this.monospace = false,
  });
  final IconData icon;
  final String label;
  final String value;
  final ColorScheme cs;
  final TextTheme tt;
  final bool monospace;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: cs.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, color: cs.secondary, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant)),
                const SizedBox(height: 3),
                Text(
                  value.isEmpty ? 'Not provided' : value,
                  style: tt.bodyMedium?.copyWith(
                    color: cs.onSurface,
                    fontWeight: FontWeight.w500,
                    fontFamily: monospace ? 'monospace' : null,
                    letterSpacing: monospace ? 1.1 : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Buttons ───────────────────────────────────────────────────────────────

class _EditToggleButton extends StatelessWidget {
  const _EditToggleButton(
      {required this.isEditing, required this.cs, required this.onTap});
  final bool isEditing;
  final ColorScheme cs;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isEditing
              ? cs.error.withOpacity(0.12)
              : cs.primary.withOpacity(0.12),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isEditing
                ? cs.error.withOpacity(0.4)
                : cs.primary.withOpacity(0.4),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isEditing ? Icons.close_rounded : Icons.edit_rounded,
              color: isEditing ? cs.error : cs.primary,
              size: 15,
            ),
            const SizedBox(width: 6),
            Text(
              isEditing ? 'Cancel' : 'Edit',
              style: TextStyle(
                color: isEditing ? cs.error : cs.primary,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton(
      {required this.isLoading, required this.cs, required this.onTap});
  final bool isLoading;
  final ColorScheme cs;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [cs.primary, cs.primary.withOpacity(0.8)],
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: cs.primary.withOpacity(0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_rounded, color: cs.onPrimary, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Save Changes',
                      style: TextStyle(
                        color: cs.onPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _SignOutButton extends StatelessWidget {
  const _SignOutButton({required this.cs, required this.tt});
  final ColorScheme cs;
  final TextTheme tt;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: cs.error.withOpacity(0.35)),
          color: cs.error.withOpacity(0.06),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_rounded, color: cs.error, size: 18),
            const SizedBox(width: 10),
            Text(
              'Sign Out',
              style: tt.bodyMedium?.copyWith(
                color: cs.error,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Grid Painter ──────────────────────────────────────────────────────────

class _GridPainter extends CustomPainter {
  final Color color;
  _GridPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.035)
      ..strokeWidth = 1;

    const step = 32.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter old) => old.color != color;
}

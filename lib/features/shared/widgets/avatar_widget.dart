// shared/widgets/avatar_widget.dart

import 'package:flutter/material.dart';

/// A reusable initials avatar widget.
/// Generates a deterministic background color from [name] so the same
/// person always gets the same color across the entire app.
///
/// Usage:
///   AvatarWidget(name: 'Arjun Mehta', radius: 24)
///   AvatarWidget(name: 'Rohan Sharma', radius: 20, imageUrl: customer.photoUrl)
class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key,
    required this.name,
    this.radius = 24,
    this.imageUrl,
    this.fontSize,
  });

  final String name;
  final double radius;
  final String? imageUrl;
  final double? fontSize;

  // ── Deterministic color from name ─────────────────────────────────────────

  static const _palette = <Color>[
    Color(0xFFE53935), // red
    Color(0xFF8E24AA), // purple
    Color(0xFF1E88E5), // blue
    Color(0xFF00ACC1), // cyan
    Color(0xFF43A047), // green
    Color(0xFFF4511E), // deep orange
    Color(0xFF6D4C41), // brown
    Color(0xFF00897B), // teal
    Color(0xFF3949AB), // indigo
    Color(0xFFF6BF26), // yellow (dark enough)
  ];

  Color _bgColor(String name) {
    if (name.isEmpty) return _palette[0];
    final hash = name.codeUnits.fold(0, (prev, c) => prev + c);
    return _palette[hash % _palette.length];
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final bg       = _bgColor(name);
    final initials = _initials(name);
    final textSize = fontSize ?? radius * 0.75;

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(imageUrl!),
        backgroundColor: bg,
        onBackgroundImageError: (_, __) {},
        child: null,
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: bg,
      child: Text(
        initials,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: textSize,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

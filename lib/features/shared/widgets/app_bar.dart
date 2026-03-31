import 'package:autovault/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String greeting;
  final String subtitle;
  final String initials;

  const DashboardAppBar({
    super.key,
    required this.greeting,
    required this.subtitle,
    required this.initials,
  });

  @override
  Size get preferredSize => Size.fromHeight(SizeConfig.h(80));

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(color: cs.surface),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.w(16),
        vertical: SizeConfig.h(8),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Container(
              width: SizeConfig.w(40),
              height: SizeConfig.w(40),
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(SizeConfig.w(12)),
              ),
              child: Center(
                child: Text(
                  initials,
                  style: tt.labelLarge?.copyWith(
                    color: cs.onPrimaryContainer,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            SizedBox(width: SizeConfig.w(12)),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    greeting,
                    style: tt.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: cs.onSurface,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: tt.labelSmall?.copyWith(
                      color: cs.onSurfaceVariant.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.person_rounded,
                    color: cs.onSurfaceVariant,
                    size: SizeConfig.w(24),
                  ),
                  onPressed: () => context.push("/profile"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

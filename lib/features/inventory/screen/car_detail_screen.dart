import 'package:autovault/data/models/car_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

final _inrFmt = NumberFormat.currency(
  locale: 'en_IN',
  symbol: '₹',
  decimalDigits: 0,
);

class CarDetailScreen extends StatefulWidget {
  const CarDetailScreen({super.key, required this.car});
  final CarModel car;

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final car = widget.car;

    // Derive status color
    final statusColor = _statusColor(car.status, cs);

    return Scaffold(
      backgroundColor: cs.surface,
      body: CustomScrollView(
        slivers: [
          // ── Hero SliverAppBar ──────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            backgroundColor: cs.surface,
            surfaceTintColor: Colors.transparent,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: _GlassButton(
                onTap: () => context.pop(),
                child: Icon(Icons.arrow_back_rounded,
                    color: cs.onSurface, size: 20),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: _GlassButton(
                  onTap: () {},
                  child: Icon(Icons.more_vert_rounded,
                      color: cs.onSurface, size: 20),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: _HeroPanel(car: car, cs: cs, tt: tt),
            ),
          ),

          // ── Content ────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeIn,
              child: SlideTransition(
                position: _slideUp,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 48),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Price + status row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Selling Price',
                                  style: tt.labelSmall?.copyWith(
                                    color: cs.onSurfaceVariant,
                                    letterSpacing: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _inrFmt.format(car.sellingPrice),
                                  style: tt.headlineMedium?.copyWith(
                                    color: cs.primary,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _StatusBadge(
                              label: car.status.name.toUpperCase(),
                              color: statusColor),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Divider with label
                      _SectionLabel(label: 'Vehicle Details', cs: cs, tt: tt),
                      const SizedBox(height: 16),

                      // Detail grid
                      _DetailGrid(car: car, cs: cs, tt: tt),

                      const SizedBox(height: 32),
                      _SectionLabel(label: 'Identification', cs: cs, tt: tt),
                      const SizedBox(height: 16),

                      _VinCard(vin: car.vin, cs: cs, tt: tt),

                      const SizedBox(height: 32),
                      _SectionLabel(label: 'Financials', cs: cs, tt: tt),
                      const SizedBox(height: 16),
                      _FinancialCard(car: car, cs: cs, tt: tt),

                      const SizedBox(height: 40),

                      // CTA
                      _PrimaryButton(
                        label: 'Create Purchase',
                        icon: Icons.receipt_long_rounded,
                        cs: cs,
                        onTap: () {},
                      ),
                      const SizedBox(height: 12),
                      _SecondaryButton(
                        label: 'Schedule Test Drive',
                        icon: Icons.directions_car_rounded,
                        cs: cs,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _statusColor(dynamic status, ColorScheme cs) {
    // Adjust based on your CarStatus enum values
    final name = status?.name?.toString().toLowerCase() ?? '';
    if (name.contains('available')) return const Color(0xFF4CAF50);
    if (name.contains('sold')) return const Color(0xFFEF5350);
    if (name.contains('reserved')) return cs.primary;
    return cs.onSurfaceVariant;
  }
}

// ── Hero Panel ─────────────────────────────────────────────────────────────

class _HeroPanel extends StatelessWidget {
  const _HeroPanel({required this.car, required this.cs, required this.tt});
  final CarModel car;
  final ColorScheme cs;
  final TextTheme tt;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            cs.surface,
            cs.surfaceContainerHighest.withOpacity(0.6),
            cs.primary.withOpacity(0.08),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned.fill(
            child: CustomPaint(painter: _GridPainter(cs.primary)),
          ),
          // Glow orb
          Positioned(
            right: -40,
            top: 20,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    cs.primary.withOpacity(0.12),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 100, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Make badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: cs.primary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: cs.primary.withOpacity(0.4), width: 0.8),
                  ),
                  child: Text(
                    car.make.toUpperCase(),
                    style: tt.labelSmall?.copyWith(
                      color: cs.primary,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  car.model,
                  style: tt.displaySmall?.copyWith(
                    color: cs.onSurface,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${car.year}  ·  ${car.color ?? ""}  ·  ${car.fuelType?.name ?? ""}',
                  style: tt.bodyMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          // Big car icon centered
          Positioned(
            right: 24,
            bottom: 60,
            child: Icon(
              Icons.directions_car_rounded,
              size: 100,
              color: cs.primary.withOpacity(0.15),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Detail Grid ────────────────────────────────────────────────────────────

class _DetailGrid extends StatelessWidget {
  const _DetailGrid({required this.car, required this.cs, required this.tt});
  final CarModel car;
  final ColorScheme cs;
  final TextTheme tt;

  @override
  Widget build(BuildContext context) {
    final items = [
      _GridItem(
          icon: Icons.calendar_today_rounded,
          label: 'Year',
          value: '${car.year}'),
      _GridItem(
          icon: Icons.palette_rounded, label: 'Color', value: car.color ?? '—'),
      _GridItem(
          icon: Icons.local_gas_station_rounded,
          label: 'Fuel',
          value: car.fuelType?.name ?? '—'),
      _GridItem(
          icon: Icons.settings_rounded,
          label: 'Trans.',
          value: car.transmission?.name ?? '—'),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.1,
      children:
          items.map((item) => _GridTile(item: item, cs: cs, tt: tt)).toList(),
    );
  }
}

class _GridItem {
  final IconData icon;
  final String label;
  final String value;
  const _GridItem(
      {required this.icon, required this.label, required this.value});
}

class _GridTile extends StatelessWidget {
  const _GridTile({required this.item, required this.cs, required this.tt});
  final _GridItem item;
  final ColorScheme cs;
  final TextTheme tt;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.outlineVariant.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: cs.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(item.icon, color: cs.primary, size: 16),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(item.label,
                    style: tt.labelSmall
                        ?.copyWith(color: cs.onSurfaceVariant, fontSize: 10)),
                const SizedBox(height: 2),
                Text(item.value,
                    style: tt.bodySmall?.copyWith(
                      color: cs.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── VIN Card ───────────────────────────────────────────────────────────────

class _VinCard extends StatelessWidget {
  const _VinCard({required this.vin, required this.cs, required this.tt});
  final String vin;
  final ColorScheme cs;
  final TextTheme tt;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.outlineVariant.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Icon(Icons.qr_code_rounded, color: cs.primary, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('VIN',
                    style: tt.labelSmall?.copyWith(
                        color: cs.onSurfaceVariant, letterSpacing: 1.4)),
                const SizedBox(height: 4),
                Text(vin,
                    style: tt.bodyMedium?.copyWith(
                      color: cs.onSurface,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'monospace',
                      letterSpacing: 1.2,
                    )),
              ],
            ),
          ),
          IconButton(
            icon:
                Icon(Icons.copy_rounded, color: cs.onSurfaceVariant, size: 18),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

// ── Financial Card ─────────────────────────────────────────────────────────

class _FinancialCard extends StatelessWidget {
  const _FinancialCard({required this.car, required this.cs, required this.tt});
  final CarModel car;
  final ColorScheme cs;
  final TextTheme tt;

  @override
  Widget build(BuildContext context) {
    final margin = (car.sellingPrice - (car.purchasePrice ?? 0));
    final marginPct = (car.purchasePrice != null && car.purchasePrice! > 0)
        ? (margin / car.purchasePrice! * 100)
        : 0.0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            cs.primary.withOpacity(0.12),
            cs.primary.withOpacity(0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.primary.withOpacity(0.25)),
      ),
      child: Column(
        children: [
          _FinRow(
            label: 'Purchase Price',
            value: _inrFmt.format(car.purchasePrice ?? 0),
            cs: cs,
            tt: tt,
          ),
          const SizedBox(height: 12),
          _FinRow(
            label: 'Selling Price',
            value: _inrFmt.format(car.sellingPrice),
            cs: cs,
            tt: tt,
            highlight: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: cs.primary.withOpacity(0.2)),
          ),
          _FinRow(
            label: 'Gross Margin',
            value:
                '${_inrFmt.format(margin)}  (${marginPct.toStringAsFixed(1)}%)',
            cs: cs,
            tt: tt,
            color:
                margin >= 0 ? const Color(0xFF4CAF50) : const Color(0xFFEF5350),
          ),
        ],
      ),
    );
  }
}

class _FinRow extends StatelessWidget {
  const _FinRow(
      {required this.label,
      required this.value,
      required this.cs,
      required this.tt,
      this.highlight = false,
      this.color});
  final String label;
  final String value;
  final ColorScheme cs;
  final TextTheme tt;
  final bool highlight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
        Text(value,
            style: tt.bodyMedium?.copyWith(
              color: color ?? (highlight ? cs.primary : cs.onSurface),
              fontWeight: highlight ? FontWeight.w700 : FontWeight.w500,
            )),
      ],
    );
  }
}

// ── Shared Widgets ─────────────────────────────────────────────────────────

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
          height: 16,
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

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2)),
        ],
      ),
    );
  }
}

class _GlassButton extends StatelessWidget {
  const _GlassButton({required this.child, required this.onTap});
  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest.withOpacity(0.6),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cs.outlineVariant.withOpacity(0.5)),
        ),
        child: Center(child: child),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton(
      {required this.label,
      required this.icon,
      required this.cs,
      required this.onTap});
  final String label;
  final IconData icon;
  final ColorScheme cs;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: cs.onPrimary, size: 20),
            const SizedBox(width: 10),
            Text(label,
                style: TextStyle(
                  color: cs.onPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  letterSpacing: 0.3,
                )),
          ],
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton(
      {required this.label,
      required this.icon,
      required this.cs,
      required this.onTap});
  final String label;
  final IconData icon;
  final ColorScheme cs;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: cs.outlineVariant),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: cs.onSurface, size: 20),
            const SizedBox(width: 10),
            Text(label,
                style: TextStyle(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  letterSpacing: 0.3,
                )),
          ],
        ),
      ),
    );
  }
}

// ── Grid Painter ───────────────────────────────────────────────────────────

class _GridPainter extends CustomPainter {
  final Color color;
  _GridPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.04)
      ..strokeWidth = 1;

    const step = 36.0;
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

import 'package:autovault/core/theme/theme.dart';
import 'package:autovault/core/utils/size_config.dart';
import 'package:autovault/features/auth/providers/auth_provider.dart';
import 'package:autovault/features/shared/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:autovault/data/mock/mock_data.dart';
import 'package:autovault/features/dashboard/providers/dashboard_provider.dart';
import 'package:autovault/features/dashboard/widgets/glass_card.dart';
import 'package:autovault/features/dashboard/widgets/kpi_card.dart';
import 'package:autovault/features/dashboard/widgets/sales_chart.dart';
import 'package:autovault/features/dashboard/widgets/inventory_tile.dart';
import 'package:autovault/features/dashboard/widgets/transaction_item.dart';
import 'package:autovault/features/dashboard/widgets/test_drive_card.dart';
import 'package:autovault/features/dashboard/widgets/loan_overview_bar.dart';
import 'package:autovault/features/dashboard/widgets/section_title.dart';

class OwnerDashboardScreen extends ConsumerWidget {
  const OwnerDashboardScreen({super.key});

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final user = ref.watch(currentUserProvider);
    final kpis = ref.watch(kpiMetricsProvider);
    final inventory = ref.watch(inventoryStatusProvider);
    final transactions = ref.watch(recentTransactionsProvider);
    final loans = ref.watch(loanOverviewProvider);
    final testDrives = ref.watch(upcomingTestDrivesProvider);
    final sales = ref.watch(monthlySalesProvider);
    final initial = _initials(user!.fullName);

    final gradients = [
      AppColors.revenueGradient,
      AppColors.salesGradient,
      AppColors.loansGradient,
      AppColors.testDriveGradient,
    ];

    return Scaffold(
      appBar: DashboardAppBar(
        greeting: 'Good Morning, ${user.firstName}',
        subtitle: DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
        initials: initial,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: cs.surface,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.w(8),
              vertical: SizeConfig.h(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── KPI Cards ──
                FadeInDown(
                  duration: const Duration(milliseconds: 600),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(8)),
                    child: SectionTitle(
                        title: 'Performance Overview', trailing: 'This Month'),
                  ),
                ),
                FadeInLeft(
                  duration: const Duration(milliseconds: 700),
                  child: SizedBox(
                    height: SizeConfig.h(160),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding:
                          EdgeInsets.symmetric(horizontal: SizeConfig.w(8)),
                      itemCount: kpis.length,
                      separatorBuilder: (_, __) =>
                          SizedBox(width: SizeConfig.w(12)),
                      itemBuilder: (context, index) => KpiCard(
                          metric: kpis[index], gradient: gradients[index]),
                    ),
                  ),
                ),

                SizedBox(height: SizeConfig.h(24)),

                // ── Sales Chart ──
                FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  delay: const Duration(milliseconds: 100),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionTitle(title: 'Sales Overview', trailing: '2026'),
                        GlassCard(
                          child: Column(children: [
                            Row(children: [
                              Container(
                                width: SizeConfig.w(8),
                                height: SizeConfig.w(8),
                                decoration: BoxDecoration(
                                    color: cs.primary, shape: BoxShape.circle),
                              ),
                              SizedBox(width: SizeConfig.w(8)),
                              Text('Cars Sold',
                                  style: tt.labelSmall
                                      ?.copyWith(color: cs.onSurfaceVariant)),
                            ]),
                            SizedBox(height: SizeConfig.h(16)),
                            SalesChart(data: sales),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: SizeConfig.h(24)),

                // ── Inventory Status ──
                FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  delay: const Duration(milliseconds: 200),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionTitle(
                          title: 'Inventory Status',
                          trailing: "View All",
                          onTrailingTap: () => context.push('/inventory'),
                        ),
                        Row(children: [
                          InventoryTile(
                              label: 'Available',
                              count: inventory.available,
                              total: inventory.total,
                              color: cs.tertiary,
                              icon: Icons.check_circle_outline_rounded),
                          SizedBox(width: SizeConfig.w(8)),
                          InventoryTile(
                              label: 'Reserved',
                              count: inventory.reserved,
                              total: inventory.total,
                              color: cs.primary,
                              icon: Icons.bookmark_outline_rounded),
                          SizedBox(width: SizeConfig.w(8)),
                          InventoryTile(
                              label: 'Sold',
                              count: inventory.sold,
                              total: inventory.total,
                              color: cs.tertiary,
                              icon: Icons.sell_outlined),
                        ]),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: SizeConfig.h(24)),

                // ── Recent Transactions ──
                FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  delay: const Duration(milliseconds: 300),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionTitle(title: 'Recent Transactions'),
                        ...transactions
                            .map((t) => TransactionItem(transaction: t)),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: SizeConfig.h(24)),

                // ── Loan Overview ──
                FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  delay: const Duration(milliseconds: 400),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionTitle(title: 'Loan Repayment Overview'),
                        LoanOverviewBar(data: loans),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: SizeConfig.h(24)),

                // ── Test Drives ──
                FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  delay: const Duration(milliseconds: 500),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionTitle(
                          title: 'Upcoming Test Drives',
                          trailing: "View All",
                          onTrailingTap: () => context.push("/test-drives"),
                        ),
                        ...testDrives.asMap().entries.map(
                              (e) => TestDriveCard(
                                  schedule: e.value,
                                  isLast: e.key == testDrives.length - 1),
                            ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:autovault/core/utils/size_config.dart';
import 'package:autovault/features/auth/providers/auth_provider.dart';
import 'package:autovault/features/dashboard/widgets/customer_tile.dart';
import 'package:autovault/features/dashboard/widgets/pending_tasks_card.dart';
import 'package:autovault/features/dashboard/widgets/shift_tracker_card.dart';
import 'package:autovault/features/shared/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:autovault/data/mock/employee_mock_data.dart';
import 'package:autovault/features/dashboard/providers/dashboard_provider.dart';
import 'package:autovault/features/dashboard/widgets/glass_card.dart';
import 'package:autovault/features/dashboard/widgets/sales_chart.dart';
import 'package:autovault/features/dashboard/widgets/inventory_tile.dart';
import 'package:autovault/features/dashboard/widgets/transaction_item.dart';
import 'package:autovault/features/dashboard/widgets/test_drive_card.dart';
import 'package:autovault/features/dashboard/widgets/loan_overview_bar.dart';
import 'package:autovault/features/dashboard/widgets/section_title.dart';
import 'package:autovault/features/dashboard/widgets/quick_action_button.dart';

class EmployeeDashboardScreen extends ConsumerWidget {
  const EmployeeDashboardScreen({super.key});

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
    final sales = ref.watch(mySalesChartProvider);
    final customers = ref.watch(myCustomersProvider);
    final testDrives = ref.watch(myTestDrivesProvider);
    final recentSales = ref.watch(myRecentSalesProvider);
    final user = ref.watch(currentUserProvider);
    final initial = _initials(user!.fullName);

    final salesRemaining =
        EmployeeMockData.monthlyTarget - EmployeeMockData.currentSalesCount;

    return Scaffold(
      appBar: DashboardAppBar(
        greeting: 'Hey, ${user.firstName}',
        subtitle:
            '${EmployeeMockData.employeeTitle} · ${DateFormat('d MMM yyyy').format(DateTime.now())}',
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
                // ── Shift Tracker ──
                FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  delay: const Duration(milliseconds: 700),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionTitle(title: 'Quick Actions'),
                        SizedBox(height: SizeConfig.h(12)),
                        FadeInDown(
                          duration: const Duration(milliseconds: 600),
                          child: const ShiftTrackerCard(),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: SizeConfig.h(24)),
                FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  delay: const Duration(milliseconds: 200),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionTitle(
                            title: 'My Sales This Month', trailing: 'Weekly'),
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
                            SizedBox(height: SizeConfig.h(12)),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.w(12),
                                vertical: SizeConfig.h(8),
                              ),
                              decoration: BoxDecoration(
                                color: cs.primary.withValues(alpha: 0.08),
                                borderRadius:
                                    BorderRadius.circular(SizeConfig.w(8)),
                                border: Border.all(
                                    color: cs.primary.withValues(alpha: 0.15)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.emoji_events_rounded,
                                      color: cs.primary,
                                      size: SizeConfig.w(16)),
                                  SizedBox(width: SizeConfig.w(8)),
                                  RichText(
                                    text: TextSpan(
                                      style: tt.labelSmall?.copyWith(
                                          color: cs.onSurfaceVariant),
                                      children: [
                                        TextSpan(
                                          text: '$salesRemaining sales ',
                                          style: TextStyle(
                                              color: cs.primary,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        const TextSpan(
                                            text:
                                                'away from your monthly target!'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: SizeConfig.h(24)),

                // ── Pending Tasks ──
                FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  delay: const Duration(milliseconds: 300),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionTitle(title: "Today's Tasks"),
                        const PendingTasksCard(),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: SizeConfig.h(24)),

                // ── My Customers ──
                FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  delay: const Duration(milliseconds: 400),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionTitle(
                          title: 'My Assigned Customers',
                          trailing: "View All",
                          onTrailingTap: () => context.push("/customers"),
                        ),
                        ...customers.map(
                            (c) => CustomerTile(customer: c, onTap: () {})),
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
                          title: 'My Upcoming Test Drives',
                          trailing: 'View All',
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

                SizedBox(height: SizeConfig.h(24)),

                // ── Recent Sales ──
                FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  delay: const Duration(milliseconds: 600),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionTitle(title: 'My Recent Sales'),
                        ...recentSales
                            .map((t) => TransactionItem(transaction: t)),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: SizeConfig.h(24)),

                SizedBox(height: SizeConfig.h(24)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

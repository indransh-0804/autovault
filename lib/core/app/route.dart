/// Application routing configuration using GoRouter.
///
/// This file defines the complete navigation structure for AutoVault with:
/// - **Auth-aware redirects**: Unauthenticated users → sign-in, authenticated → dashboard
/// - **Role-based navigation**: Owners and employees have different dashboard routes
/// - **Nested routes**: Parent/child route relationships for detail screens
/// - **Custom transitions**: Slide animations for customer detail screens
/// - **Type-safe navigation**: Route parameters with compile-time safety
///
/// ## Route Structure
///
/// ### Authentication Routes (public)
/// - `/signin` - Email/password sign-in
/// - `/signup` - Multi-step registration flow
/// - `/forgot-password` - Password reset flow
///
/// ### Dashboard Routes (protected)
/// - `/owner_dashboard` - Owner/manager dashboard with full access
/// - `/employee_dashboard` - Employee dashboard with scoped access
/// - `/profile` - User profile management
///
/// ### Feature Routes (protected)
/// - `/inventory` - Car and parts inventory management
///   - `/inventory/car/:carId` - Individual car details
/// - `/customers` - Customer relationship management
///   - `/customers/:id` - Customer detail with interaction history
/// - `/purchases/new` - Create new vehicle purchase
/// - `/purchases/:id/edit` - Edit existing purchase
/// - `/test-drives` - Test drive scheduler (calendar/timeline/list views)
///   - `/test-drives/new` - Schedule new test drive
///   - `/test-drives/:id` - Test drive details
///
/// ## Navigation Guards
///
/// The router uses GoRouter's `redirect` callback to enforce authentication:
/// 1. Unauthenticated users on protected routes → redirected to `/signin`
/// 2. Authenticated users on auth routes → redirected to role-based dashboard
/// 3. Dashboard routing uses `UserRole.dashboardRoute` extension
///
/// ## Usage
///
/// The router is exposed as a Riverpod provider for reactive navigation:
/// ```dart
/// final router = ref.watch(goRouterProvider);
/// ```
///
/// Navigate using context extensions:
/// ```dart
/// context.go('/customers');
/// context.goNamed('customer-detail', pathParameters: {'id': customerId}, extra: customer);
/// ```
library;

import 'package:autovault/data/models/car_model.dart';
import 'package:autovault/data/models/customer_model.dart';
import 'package:autovault/data/models/user_model.dart';
import 'package:autovault/features/auth/screen/sign_in/forgot_password_screen.dart';
import 'package:autovault/features/auth/screen/sign_in/sign_in_screen.dart';
import 'package:autovault/features/auth/screen/sign_up/signup_screen.dart';
import 'package:autovault/features/customers/screen/customer_detail_screen.dart';
import 'package:autovault/features/customers/screen/customers_list_screen.dart';
import 'package:autovault/features/dashboard/screen/dashboard_screen.dart';
import 'package:autovault/features/dashboard/screen/employee_dashboard_screen.dart';
import 'package:autovault/features/dashboard/screen/profile.dart';
import 'package:autovault/features/inventory/screen/car_detail_screen.dart';
import 'package:autovault/features/inventory/screen/inventory_screen.dart';
import 'package:autovault/features/purchase/screen/purchase_form_screen.dart';
import 'package:autovault/features/auth/providers/auth_provider.dart';
import 'package:autovault/features/test_drive/screen/test_drive_detail_screen.dart';
import 'package:autovault/features/test_drive/screen/test_drives_screen.dart';
import 'package:autovault/features/test_drive/widgets/add_edit_test_drive_sheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'route.g.dart';

/// Provides the application's GoRouter instance with auth-aware navigation.
///
/// This provider creates and configures the router, watching [authNotifierProvider]
/// to trigger re-evaluation when authentication state changes. This enables
/// automatic redirects when users sign in/out.
///
/// The router rebuilds when:
/// - User signs in (redirect from auth routes to dashboard)
/// - User signs out (redirect from protected routes to sign-in)
/// - User role changes (redirect to appropriate dashboard)
///
/// Returns a configured [GoRouter] instance ready for use with MaterialApp.router.
@riverpod
GoRouter goRouter(GoRouterRef ref) {
  // Watch auth state to rebuild router on auth changes
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: '/signin',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isAuth = authState.isAuthenticated;
      final location = state.uri.toString();
      final isAuthRoute = location.startsWith('/signin') ||
          location.startsWith('/signup') ||
          location.startsWith('/forgot-password');

      // Guard: Unauthenticated users trying to access protected routes
      if (!isAuth && !isAuthRoute) return '/signin';

      // Guard: Authenticated users trying to access auth routes (sign-in/sign-up)
      // Redirect them to their role-appropriate dashboard
      if (isAuth && isAuthRoute) {
        return authState.currentUser?.role.dashboardRoute ?? '/owner_dashboard';
      }

      // No redirect needed
      return null;
    },
    routes: [
      // ────────────────────────────────────────────────────────────────────────
      // Authentication Routes
      // ────────────────────────────────────────────────────────────────────────

      /// Sign-in screen: Email/password authentication.
      GoRoute(
        path: '/signin',
        name: 'signin',
        builder: (_, __) => const SignInScreen(),
      ),

      /// Sign-up screen: Multi-step registration (credentials → OTP → role → profile).
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (_, __) => const SignupWrapperScreen(),
      ),

      /// Forgot password screen: Email-based password reset.
      GoRoute(
        path: '/forgot-password',
        name: 'forgot-password',
        builder: (_, __) => const ForgotPasswordScreen(),
      ),

      // ────────────────────────────────────────────────────────────────────────
      // Dashboard Routes (Role-Based)
      // ────────────────────────────────────────────────────────────────────────

      /// Owner dashboard: Full analytics, KPIs, sales charts, loan overview.
      GoRoute(
        path: '/owner_dashboard',
        name: 'owner-dashboard',
        builder: (_, __) => const OwnerDashboardScreen(),
      ),

      /// Employee dashboard: Personal KPIs, shift tracker, assigned customers.
      GoRoute(
        path: '/employee_dashboard',
        name: 'employee-dashboard',
        builder: (_, __) => const EmployeeDashboardScreen(),
      ),

      /// Profile screen: User profile viewing and editing.
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (_, __) => const ProfileScreen(),
      ),

      // ────────────────────────────────────────────────────────────────────────
      // Inventory Routes
      // ────────────────────────────────────────────────────────────────────────

      /// Inventory screen: Tabbed view of cars and parts.
      GoRoute(
        path: '/inventory',
        name: 'inventory',
        builder: (_, __) => const InventoryScreen(),
        routes: [
          /// Car detail screen: Full car information, image gallery, edit options.
          ///
          /// Requires [CarModel] passed via `extra` parameter.
          GoRoute(
            path: 'car/:carId',
            name: 'car-detail',
            builder: (_, state) {
              final car = state.extra as CarModel?;
              return CarDetailScreen(car: car!);
            },
          ),
        ],
      ),

      // ────────────────────────────────────────────────────────────────────────
      // Customer Routes
      // ────────────────────────────────────────────────────────────────────────

      /// Customers list screen: Searchable, filterable CRM list.
      GoRoute(
        path: '/customers',
        name: 'customers',
        builder: (_, __) => const CustomersListScreen(),
        routes: [
          /// Customer detail screen: Full profile, interaction timeline, purchases, loans.
          ///
          /// Uses custom slide transition animation from right to left.
          /// Requires [CustomerModel] passed via `extra` parameter.
          GoRoute(
            path: ':id',
            name: 'customer-detail',
            pageBuilder: (_, state) {
              final customer = state.extra as CustomerModel;
              return CustomTransitionPage(
                key: state.pageKey,
                child: CustomerDetailScreen(customer: customer),
                transitionsBuilder: (_, animation, __, child) =>
                    SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                      parent: animation, curve: Curves.easeInOutCubic)),
                  child: child,
                ),
              );
            },
          ),
        ],
      ),

      // ────────────────────────────────────────────────────────────────────────
      // Purchase Routes
      // ────────────────────────────────────────────────────────────────────────

      /// New purchase form: 4-step purchase flow (customer → car → details → loan).
      GoRoute(
        path: '/purchases/new',
        name: 'new-purchase',
        builder: (context, state) => const PurchaseFormScreen(),
      ),

      /// Edit purchase form: Modify existing purchase details.
      GoRoute(
        path: '/purchases/:id/edit',
        name: 'edit-purchase',
        builder: (context, state) => const PurchaseFormScreen(),
      ),

      // ────────────────────────────────────────────────────────────────────────
      // Test Drive Routes
      // ────────────────────────────────────────────────────────────────────────

      /// Test drives screen: Calendar/timeline/list views for test drive scheduling.
      GoRoute(
        path: '/test-drives',
        name: 'test-drives',
        builder: (_, __) => const TestDrivesScreen(),
      ),

      /// New test drive form: Schedule a test drive with customer/car/time selection.
      ///
      /// Supports optional prefill data via `extra` map with keys:
      /// - `customerId`: Pre-selected customer ID
      /// - `customerName`: Pre-selected customer name
      /// - `customerPhone`: Pre-selected customer phone
      /// - `lockCustomer`: If true, customer selector is disabled
      GoRoute(
        path: '/test-drives/new',
        name: 'new-test-drive',
        builder: (context, state) {
          final extras = state.extra as Map<String, dynamic>?;
          return Scaffold(
            body: AddEditTestDriveSheet(
              prefill: extras != null
                  ? TestDrivePrefill(
                      customerId: extras['customerId'] as String?,
                      customerName: extras['customerName'] as String?,
                      customerPhone: extras['customerPhone'] as String?,
                      lockCustomer: extras['lockCustomer'] as bool? ?? false,
                    )
                  : null,
            ),
          );
        },
      ),

      /// Test drive detail screen: View/edit test drive with status tracking.
      ///
      /// Shows activity log, status timeline, and completion actions.
      GoRoute(
        path: '/test-drives/:id',
        name: 'test-drive-detail',
        builder: (_, state) => TestDriveDetailScreen(
          testDriveId: state.pathParameters['id']!,
        ),
      ),
    ],
  );
}

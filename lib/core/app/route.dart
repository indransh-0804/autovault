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

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: '/employee_dashboard',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isAuth = authState.isAuthenticated;
      final location = state.uri.toString();
      final isAuthRoute = location.startsWith('/signin') ||
          location.startsWith('/signup') ||
          location.startsWith('/forgot-password');

      // Unauthenticated → sign in
      if (!isAuth && !isAuthRoute) return '/signin';

      // Authenticated → dashboard
      if (isAuth && isAuthRoute) {
        return authState.currentUser?.role.dashboardRoute ?? '/owner_dashboard';
      }
      return null;
    },
    routes: [
      // Auth
      GoRoute(
        path: '/signin',
        name: 'signin',
        builder: (_, __) => const SignInScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (_, __) => const SignupWrapperScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgot-password',
        builder: (_, __) => const ForgotPasswordScreen(),
      ),

      // Dashboards
      GoRoute(
        path: '/owner_dashboard',
        name: 'owner-dashboard',
        builder: (_, __) => const OwnerDashboardScreen(),
      ),
      GoRoute(
        path: '/employee_dashboard',
        name: 'employee-dashboard',
        builder: (_, __) => const EmployeeDashboardScreen(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (_, __) => const ProfileScreen(),
      ),

      // Inventory
      GoRoute(
        path: '/inventory',
        name: 'inventory',
        builder: (_, __) => const InventoryScreen(),
        routes: [
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

      // Customers
      GoRoute(
        path: '/customers',
        name: 'customers',
        builder: (_, __) => const CustomersListScreen(),
        routes: [
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

      // Purchases
      GoRoute(
        path: '/purchases/new',
        name: 'new-purchase',
        builder: (context, state) => const PurchaseFormScreen(),
      ),
      GoRoute(
        path: '/purchases/:id/edit',
        name: 'edit-purchase',
        builder: (context, state) => const PurchaseFormScreen(),
      ),

      // Test Drive
      GoRoute(
        path: '/test-drives',
        name: 'test-drives',
        builder: (_, __) => const TestDrivesScreen(),
      ),
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

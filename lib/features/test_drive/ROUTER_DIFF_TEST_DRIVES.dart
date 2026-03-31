// ROUTER_DIFF_TEST_DRIVES.dart
//
// Add these imports to app_router.dart:
//
//   import 'package:automobile/features/test_drives/test_drives_screen.dart';
//   import 'package:automobile/features/test_drives/test_drive_detail_screen.dart';
//   import 'package:automobile/features/test_drives/widgets/add_edit_test_drive_sheet.dart';
//
// Add these routes inside the GoRouter routes list:
//
//   GoRoute(
//     path: '/test-drives',
//     name: 'test-drives',
//     builder: (_, __) => const TestDrivesScreen(),
//   ),
//   GoRoute(
//     path: '/test-drives/new',
//     name: 'new-test-drive',
//     builder: (context, state) {
//       final extras = state.extra as Map<String, dynamic>?;
//       return Scaffold(
//         body: AddEditTestDriveSheet(
//           prefill: extras != null
//               ? TestDrivePrefill(
//                   customerId:    extras['customerId'] as String?,
//                   customerName:  extras['customerName'] as String?,
//                   customerPhone: extras['customerPhone'] as String?,
//                   lockCustomer:  extras['lockCustomer'] as bool? ?? false,
//                 )
//               : null,
//         ),
//       );
//       // Better: call context.push('/test-drives') then show the sheet.
//       // Or open the sheet directly from TestDrivesScreen on arrival.
//     },
//   ),
//   GoRoute(
//     path: '/test-drives/:id',
//     name: 'test-drive-detail',
//     builder: (_, state) => TestDriveDetailScreen(
//       testDriveId: state.pathParameters['id']!,
//     ),
//   ),
//
// ─── Customer Detail "Schedule One" button ────────────────────────────────────
//
// In customer_detail_screen.dart, replace the SnackBar in the "Schedule One"
// onAction with:
//
//   onAction: () => context.push('/test-drives/new', extra: {
//     'customerId':    customer.id,
//     'customerName':  customer.fullName,
//     'customerPhone': customer.phone,
//     'lockCustomer':  true,
//   }),
//
// ─── Bottom nav ───────────────────────────────────────────────────────────────
//
// Test Drives can live in the "More" tab (index 4) or replace it. If using
// a bottom nav item, add to the switch in your dashboard's ref.listen:
//
//   case 4: context.go('/test-drives'); break;
//
// ─── Purchase Form prefill from Convert to Sale ───────────────────────────────
//
// In purchase_form_screen.dart, read the extras in initState:
//
//   @override
//   void initState() {
//     super.initState();
//     _pageCtrl = PageController();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       // Reset first
//       ref.read(purchaseFormNotifierProvider.notifier).reset();
//
//       // Then apply prefill if coming from Convert to Sale
//       final extras = GoRouterState.of(context).extra as Map<String, dynamic>?;
//       if (extras != null) {
//         final customerId = extras['prefillCustomerId'] as String?;
//         final carId      = extras['prefillCarId'] as String?;
//
//         if (customerId != null) {
//           // Find from allCustomersProvider and select
//           final customer = ref.read(customerByIdProvider(customerId));
//           if (customer != null) {
//             ref.read(purchaseFormNotifierProvider.notifier).selectCustomer(customer);
//           }
//         }
//         if (carId != null) {
//           // Find from carsNotifierProvider and select
//           final car = ref.read(carsNotifierProvider)
//               .where((c) => c.id == carId).firstOrNull;
//           if (car != null) {
//             ref.read(purchaseFormNotifierProvider.notifier).selectCar(car);
//           }
//         }
//       }
//     });
//   }

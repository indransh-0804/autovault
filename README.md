# AutoVault
### Car Showroom Management System — Android Application

<br>

> A comprehensive, role-based Android application built with Flutter for managing every aspect of a car showroom — from inventory and customers to test drives, purchases, and financing.

<br>



## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Architecture](#architecture)
- [Directory Structure](#directory-structure)
- [User Roles](#user-roles)
- [Screens & Modules](#screens--modules)
- [Data Models](#data-models)
- [Getting Started](#getting-started)
- [Environment Setup](#environment-setup)
- [Build & Run](#build--run)
- [Conventions](#conventions)
- [Roadmap](#roadmap)



## Overview

AutoVault is a production-grade Flutter application designed for car showroom businesses. It provides a unified platform for showroom owners, sales employees, and suppliers — each with a tailored experience and role-scoped access. The app covers the complete sales lifecycle: from logging a walk-in customer and scheduling a test drive, all the way through to generating a receipt and setting up a loan repayment plan.

The application is built for Android, follows a feature-first clean architecture, and uses Firebase as its backend with Hive for offline caching.



## Tech Stack

| Layer | Technology |
|||
| **Framework** | Flutter 3.x (Dart) |
| **State Management** | Riverpod (`riverpod_annotation` + code generation) |
| **Navigation** | GoRouter (reactive auth-aware routing) |
| **Backend** | Firebase (Auth, Firestore, Storage, Cloud Functions) |
| **Local Cache** | Hive |
| **PDF Generation** | `pdf` + `printing` packages |
| **Charts** | `fl_chart` |
| **Models** | Freezed + `json_serializable` |
| **Image Handling** | `flutter_image_compress` |
| **Utilities** | `intl` (INR currency + date formatting), `url_launcher` |



## Architecture

AutoVault follows a **feature-first clean architecture** with a Repository pattern to allow seamless switching between mock data and live Firestore without changing feature-level code.

```
UI Layer (Screens & Widgets)
        ↕  watches / notifies
State Layer (Riverpod Providers)
        ↕  calls
Repository Layer (CarsRepository, CustomersRepository, etc.)
        ↕  reads/writes
Data Layer (Firebase Firestore + Hive Cache)
```

Key architectural decisions:

- **Riverpod with `@riverpod` codegen** — all providers use annotation-based generation for type safety and consistency. No `ChangeNotifier`, no `setState` in business logic.
- **GoRouter as a `@riverpod` provider** — the router itself is a provider, making auth-based redirects reactive and automatic.
- **Freezed models** — all data models are immutable with `copyWith`, `==`, and `fromJson/toJson` auto-generated.
- **Repository pattern** — a `useMockData` flag in each repository switches between local mock data and live Firestore, enabling development without a live backend.
- **Role-based navigation guards** — GoRouter's `redirect` callback reads `authProvider` to enforce role-appropriate routing at the navigation level, not just the UI level.



## Directory Structure

```
lib
├── core
│   ├── app
│   │   ├── autovault.dart
│   │   └── route.dart
│   ├── firebase
│   │   └── firebase_options.dart
│   ├── theme
│   │   ├── font.dart
│   │   └── theme.dart
│   ├── utils
│   │   ├── app_constants.dart
│   │   ├── formatters.dart
│   │   └── size_config.dart
│   └── autovault.dart
├── data
│   ├── mock
│   │   ├── customer_mock_data.dart
│   │   ├── employee_mock_data.dart
│   │   ├── inventory_mock_data.dart
│   │   ├── mock_data.dart
│   │   └── test_drives_mock_data.dart
│   └── models
│       ├── add_on_model.dart
│       ├── car_model.dart
│       ├── customer_model.dart
│       ├── dashboard_models.dart
│       ├── interaction_model.dart
│       ├── loan_model.dart
│       ├── part_model.dart
│       ├── purchase_model.dart
│       ├── repayment_entry_model.dart
│       ├── shift_model.dart
│       ├── showroom_model.dart
│       ├── task_model.dart
│       ├── test_drive_activity_model.dart
│       ├── test_drive_model.dart
│       └── user_model.dart
├── features
│   ├── auth
│   │   ├── providers
│   │   │   ├── auth_provider.dart
│   │   │   └── sign_up_provider.dart
│   │   ├── screen
│   │   │   ├── sign_in
│   │   │   │   ├── forgot_password_screen.dart
│   │   │   │   └── sign_in_screen.dart
│   │   │   └── sign_up
│   │   │       ├── credentials.dart
│   │   │       ├── employee_personal.dart
│   │   │       ├── owner_personal.dart
│   │   │       ├── owner_showroom.dart
│   │   │       ├── role.dart
│   │   │       └── signup_screen.dart
│   │   └── widgets
│   │       ├── otp_input_row.dart
│   │       ├── password_strength_indicator.dart
│   │       └── role_selection_card.dart
│   ├── customers
│   │   ├── providers
│   │   │   └── customers_provider.dart
│   │   ├── screen
│   │   │   ├── customer_detail_screen.dart
│   │   │   └── customers_list_screen.dart
│   │   └── widgets
│   │       ├── add_edit_customer_sheet.dart
│   │       ├── customer_card.dart
│   │       ├── interaction_timeline.dart
│   │       └── loan_summary_card.dart
│   ├── dashboard
│   │   ├── providers
│   │   │   └── dashboard_provider.dart
│   │   ├── screen
│   │   │   ├── dashboard_screen.dart
│   │   │   ├── employee_dashboard_screen.dart
│   │   │   └── profile.dart
│   │   └── widgets
│   │       ├── customer_tile.dart
│   │       ├── glass_card.dart
│   │       ├── inventory_tile.dart
│   │       ├── kpi_card.dart
│   │       ├── loan_overview_bar.dart
│   │       ├── pending_tasks_card.dart
│   │       ├── quick_action_button.dart
│   │       ├── sales_chart.dart
│   │       ├── section_title.dart
│   │       ├── shift_tracker_card.dart
│   │       ├── test_drive_card.dart
│   │       └── transaction_item.dart
│   ├── inventory
│   │   ├── providers
│   │   │   ├── cars_provider.dart
│   │   │   └── parts_provider.dart
│   │   ├── screen
│   │   │   ├── car_detail_screen.dart
│   │   │   └── inventory_screen.dart
│   │   └── widgets
│   │       ├── add_edit_car_sheet.dart
│   │       ├── add_edit_part_sheet.dart
│   │       ├── car_card.dart
│   │       └── part_card.dart
│   ├── purchase
│   │   ├── providers
│   │   │   ├── purchase_form_provider.dart
│   │   │   └── purchases_provider.dart
│   │   ├── screen
│   │   │   └── purchase_form_screen.dart
│   │   └── widgets
│   │       ├── car_selector.dart
│   │       ├── customer_selector.dart
│   │       ├── loan_config_step.dart
│   │       ├── price_breakdown_panel.dart
│   │       ├── repayment_schedule_table.dart
│   │       ├── review_confirm_step.dart
│   │       ├── sale_details_step.dart
│   │       └── step_indicator.dart
│   ├── shared
│   │   └── widgets
│   │       ├── app_bar.dart
│   │       ├── avatar_widget.dart
│   │       └── section_header.dart
│   └── test_drive
│       ├── providers
│       │   ├── test_drives_provider.dart
│       │   └── test_drives_view_provider.dart
│       ├── screen
│       │   ├── test_drive_detail_screen.dart
│       │   └── test_drives_screen.dart
│       └── widgets
│           ├── add_edit_test_drive_sheet.dart
│           ├── calendar_widget.dart
│           ├── test_drive_card.dart
│           └── timeline_view.dart
└── main.dart
```

## User Roles

### Owner / Admin
Full access to all modules. Can manage employees, view all analytics, approve loans, and configure showroom settings. The Owner is the first user created — they register the showroom during onboarding and generate the 6-character **Showroom Code** that employees use to join.

### Employee / Salesperson
Scoped access to their own customers, sales, and test drives. Can create purchases and generate receipts. Cannot access global financials, other employees' data, or admin controls. Tracks attendance via the built-in shift tracker.


## Screens & Modules

### Authentication
Multi-step onboarding flow that branches by role.

- **Sign In** — Email/password login with role-based redirect on success
- **Forgot Password** — Email reset link flow
- **Sign Up — Step 1:** Credentials (email, password with live strength indicator)
- **Sign Up — Step 2:** Email OTP verification (6-box input with paste support)
- **Sign Up — Step 3:** Role selection (Owner or Employee)
- **Sign Up — Step 4a (Owner):** Showroom registration (name, GST, address) with skip option
- **Sign Up — Step 5a (Owner):** Personal profile setup
- **Sign Up — Step 4b (Employee):** Personal profile + Showroom Code entry

### Dashboards
- **Owner Dashboard** — KPI cards, sales chart, inventory status, recent transactions, loan overview, upcoming test drives, quick actions
- **Employee Dashboard** — Shift tracker (live timer, start/end with summary sheet), personal KPIs, sales chart with target indicator, assigned customers, upcoming drives, pending tasks, quick actions

### Inventory
Tabbed screen with Cars and Parts.

- **Cars Tab** — Searchable, filterable car listing (Available / Reserved / Sold / New / Used). Car cards with image, specs, price, and status badge. Add/Edit car via bottom sheet with image picker, full spec fields, and inline validation. Owner-only long-press menu for status changes and deletion.
- **Parts Tab** — Parts listing with stock level indicators. Low-stock sticky banner. Add/Edit part form with supplier linkage and reorder level. Out of stock and low stock visual warnings.

### Customers
Full CRM module.

- **Customer List** — Searchable, filterable by lead status (Hot Lead / Follow-up / Converted / Inactive). Sortable by recency, name, and purchase count. Initials-based deterministic color avatars.
- **Customer Detail** — Collapsing SliverAppBar header with quick-contact actions. Info card, lead status journey stepper, interaction timeline, purchase history, active loan summary, scheduled test drives.
- **Add/Edit Customer Sheet** — Full form with Indian phone validation, assigned employee picker (Owner only), and lead status selector.

### Purchase Form
The core transactional flow — a 4-step guided form with a custom animated stepper.

- **Step 1:** Customer selector with inline new customer creation
- **Step 2:** Car selector (available cars only) with real-time preview card
- **Step 3:** Sale details — add-ons, discount (flat or %), payment method (Full / Loan / Part Payment), live price breakdown panel with GST at 28%
- **Step 4 (conditional):** Loan configuration — interest rate, term, EMI calculator, repayment schedule preview table, guarantor section
- **Review & Confirm:** Read-only summary with terms checkbox and final submission. On confirm, triggers car status update, customer record update, and (if loan) stub loan creation.

### Test Drive Scheduler
Three-view scheduler for managing test drives across the sales pipeline.

- **Calendar View** — Custom GridView calendar with dot indicators per day. Tap a day to see that day's drives in a sliding bottom panel.
- **Timeline View** — Vertical timeline grouped by day with color-coded status spine. Auto-scrolls to today.
- **List View** — Filterable list by status. Searchable by customer or car.
- **Test Drive Detail** — Status banner with pulse animation, core details, activity log, and context-sensitive action buttons. Completed drives show a **"Convert to Sale"** button that pre-fills the Purchase Form.
- **Add/Edit Sheet** — Customer and car pickers, date/time selector, duration, employee assignment with availability check, real-time conflict detection.


## Data Models

| Model | Key Fields |
|||
| `UserModel` | id, email, firstName, lastName, phone, role, showroomId |
| `ShowroomModel` | id, name, gstNumber, address, city, state, ownerId, showroomCode |
| `CarModel` | id, make, model, year, vin, condition, fuelType, status, purchasePrice, sellingPrice |
| `PartModel` | id, name, partNumber, category, supplierId, quantity, reorderLevel, unitPrice |
| `CustomerModel` | id, firstName, lastName, phone, leadStatus, assignedEmployeeId, purchaseIds, loanIds |
| `InteractionModel` | id, customerId, type, note, timestamp |
| `PurchaseModel` | id, customerId, carId, addOns, discountType, subtotal, gstAmount, totalAmount, paymentMethod, loanId |
| `AddOnModel` | id, name, price, isCustom |
| `LoanModel` | id, purchaseId, principalAmount, interestRate, termMonths, emiAmount, repaymentSchedule |
| `RepaymentEntryModel` | month, dueDate, emiAmount, principalComponent, interestComponent, remainingBalance, isPaid |
| `TestDriveModel` | id, customerId, carId, assignedEmployeeId, scheduledAt, duration, status, activityLog, convertedToPurchaseId |
| `TestDriveActivityModel` | id, timestamp, description, type |
| `ShiftModel` | isActive, startTime, endTime, elapsedDuration |


## Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- Android Studio or VS Code with Flutter extension
- Firebase project with Android app registered
- Java 17+ (for Gradle builds)

### Clone the Repository

```bash
git clone https://github.com/your-org/automobile.git
cd automobile
```

### Install Dependencies

```bash
flutter pub get
```

### Run Code Generation

This project uses `build_runner` for Riverpod codegen, Freezed models, and `json_serializable`. Run this after cloning and after any model/provider changes:

```bash
dart run build_runner build --delete-conflicting-outputs
```

For continuous generation during development:

```bash
dart run build_runner watch --delete-conflicting-outputs
```



## Conventions

### Currency & Formatting
All monetary values are displayed in **Indian Rupees (₹)** using `intl.NumberFormat`:
```dart
// core/utils/formatters.dart
final currencyFormatter = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
```

### GST
The default GST rate for automobiles in India is **28%**, defined as a constant:
```dart
// core/constants/app_constants.dart
const double kGstRate = 0.28;
```

### Phone Numbers
All phone numbers use the **+91** prefix (India) and are validated as 10-digit numbers.

### Dates
All dates use the shared `DateFormat` utility from `core/utils/formatters.dart` (e.g. `"12 Mar 2024"`). Never use `DateTime.toString()` directly in the UI.

### Provider Naming
Providers follow the `@riverpod` codegen naming convention — the generated provider name matches the function/class name with a `Provider` suffix:
```dart
@riverpod
class CarsNotifier extends _$CarsNotifier { ... }
// → generated as: carsNotifierProvider
```

### File Naming
All files use `snake_case`. All classes use `PascalCase`. Feature folders mirror the navigation structure.


## License

This project is proprietary software developed for a private client. All rights reserved.


<br>

<p align="center">Built with Flutter 💙 — Designed for India's automotive retail market</p>

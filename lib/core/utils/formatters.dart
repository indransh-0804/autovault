/// Date and currency formatters for consistent display formatting.
///
/// This file provides utility formatters for displaying dates and monetary
/// values according to Indian conventions:
/// - Dates in "dd MMM yyyy" format (e.g., "12 Mar 2024")
/// - Currency in Indian Rupees (₹) with proper locale formatting
/// - Age calculations from date of birth
///
/// All formatters use the `intl` package for internationalization support.
library;

import 'package:intl/intl.dart';

/// Date formatter producing "12 Mar 2024" format.
///
/// Uses day-month-year order with abbreviated month names. This format
/// is consistent across all date displays in the app (customer DOB,
/// transaction dates, test drive schedules, etc.).
///
/// Example: `dateFormatter.format(DateTime.now())` → "02 Apr 2026"
final dateFormatter = DateFormat('dd MMM yyyy');

/// Formats a date of birth with calculated age appended.
///
/// Converts a [DateTime] to a human-readable string showing both the
/// formatted date and the person's current age in years.
///
/// Example: For a DOB of March 12, 1990:
/// Returns: "12 Mar 1990 (36 yrs)"
///
/// Used in customer and employee profile displays to show age context
/// alongside the birth date.
///
/// [dob] - The date of birth to format.
/// Returns formatted string with date and age.
String formatDobWithAge(DateTime dob) {
  final age = _calculateAge(dob);
  return '${dateFormatter.format(dob)} ($age yrs)';
}

/// Calculates age in years from a date of birth.
///
/// Accounts for partial years by checking if the person's birthday has
/// occurred yet in the current year. If the birthday hasn't occurred,
/// subtracts one year from the age calculation.
///
/// [dob] - The date of birth.
/// Returns age in complete years.
int _calculateAge(DateTime dob) {
  final now = DateTime.now();
  int age = now.year - dob.year;
  // Check if birthday hasn't occurred yet this year
  if (now.month < dob.month ||
      (now.month == dob.month && now.day < dob.day)) {
    age--;
  }
  return age;
}

/// Currency formatter for Indian Rupees (₹).
///
/// Formats numbers according to Indian locale conventions:
/// - Uses ₹ symbol
/// - Indian numbering system (lakhs, crores)
/// - No decimal places (whole rupees only)
///
/// Example: `inrFormatter.format(850000)` → "₹8,50,000"
///
/// Used throughout the app for:
/// - Car prices (purchase price, selling price)
/// - Loan amounts (principal, EMI, total)
/// - Transaction values
/// - Dashboard KPIs
final inrFormatter = NumberFormat.currency(
  locale: 'en_IN',
  symbol: '₹',
  decimalDigits: 0,
);

/// Month-year formatter producing "Mar 2024" format.
///
/// Used in charts, timelines, and aggregated reports where full dates
/// are too verbose. Common in:
/// - Sales trend charts
/// - Loan repayment schedules
/// - Monthly performance reports
///
/// Example: `monthYearFormatter.format(DateTime.now())` → "Apr 2026"
final monthYearFormatter = DateFormat('MMM yyyy');

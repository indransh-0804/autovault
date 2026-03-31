// core/utils/formatters.dart

import 'package:intl/intl.dart';

/// "12 Mar 2024"
final dateFormatter = DateFormat('dd MMM yyyy');

/// "12 Mar 2024 (34 yrs)"
String formatDobWithAge(DateTime dob) {
  final age = _calculateAge(dob);
  return '${dateFormatter.format(dob)} ($age yrs)';
}

int _calculateAge(DateTime dob) {
  final now = DateTime.now();
  int age = now.year - dob.year;
  if (now.month < dob.month ||
      (now.month == dob.month && now.day < dob.day)) {
    age--;
  }
  return age;
}

/// "₹8,50,000"
final inrFormatter = NumberFormat.currency(
  locale: 'en_IN',
  symbol: '₹',
  decimalDigits: 0,
);

/// "Mar 2024"
final monthYearFormatter = DateFormat('MMM yyyy');

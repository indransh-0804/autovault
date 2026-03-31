class AppConstants {
  AppConstants._();

  /// GST rate for automobiles in India (28%)
  static const double automobileGstRate = 0.28;

  /// Default loan interest rate (% per annum)
  static const double defaultInterestRate = 9.5;

  /// Default loan processing fee (₹)
  static const double defaultProcessingFee = 5000;

  /// Common loan term options (months)
  static const List<int> loanTermOptions = [12, 24, 36, 48, 60, 84];

  /// Default loan term (months)
  static const int defaultLoanTermMonths = 36;

  /// Max images per car listing
  static const int maxCarImages = 6;

  /// App name
  static const String appName = 'AutoMobile';
}

/// Application-wide constants used throughout the AutoVault app.
///
/// This file contains business rules, defaults, and configuration values
/// specific to the car showroom domain in India, including:
/// - GST rates for automobile sales
/// - Loan calculation defaults
/// - Image upload limits
/// - Application metadata
library;

/// Central repository for application constants.
///
/// All values are compile-time constants to ensure type safety and
/// enable compiler optimizations. Values are based on Indian automobile
/// industry standards and business requirements.
class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  /// GST rate for automobiles in India (28%).
  ///
  /// As per Indian tax law, automobiles are taxed at 28% GST.
  /// This rate is applied to the subtotal before calculating the final
  /// invoice amount in the purchase flow.
  static const double automobileGstRate = 0.28;

  /// Default loan interest rate (9.5% per annum).
  ///
  /// This is the default interest rate pre-filled in the loan calculator
  /// during the purchase flow. Users can override this value based on
  /// their financing arrangements.
  static const double defaultInterestRate = 9.5;

  /// Default loan processing fee (₹5,000).
  ///
  /// One-time processing fee added to the loan principal. This is a
  /// standard charge for administrative and documentation costs.
  static const double defaultProcessingFee = 5000;

  /// Common loan term options in months.
  ///
  /// Standard auto loan durations offered to customers: 1 year (12 months),
  /// 2 years (24 months), 3 years (36 months), 4 years (48 months),
  /// 5 years (60 months), and 7 years (84 months).
  static const List<int> loanTermOptions = [12, 24, 36, 48, 60, 84];

  /// Default loan term duration (36 months = 3 years).
  ///
  /// This is the most common auto loan duration and is pre-selected
  /// in the loan configuration step of the purchase form.
  static const int defaultLoanTermMonths = 36;

  /// Maximum number of images allowed per car listing.
  ///
  /// Limits image uploads to prevent excessive storage usage and
  /// ensure reasonable page load times. Covers: front, rear, sides,
  /// interior, and dashboard views.
  static const int maxCarImages = 6;

  /// Application display name.
  ///
  /// Used in app bar titles, splash screens, and system UI.
  static const String appName = 'AutoMobile';
}

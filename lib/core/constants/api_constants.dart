class ApiConstants {
  static const String baseUrl = 'http://32.236.14.31/api';

  static String get login => '$baseUrl/login';
  static String get register => '$baseUrl/register';
  static String get logout => '$baseUrl/logout';
  static String get profile => '$baseUrl/profile';

  static String get destinations => '$baseUrl/destinations';
  static String get tourPackages => '$baseUrl/tour-packages';
  static String get vehicles => '$baseUrl/vehicles';
  static String get agents => '$baseUrl/agents';

  static String get createBooking => '$baseUrl/bookings';
  static String get myBookings => '$baseUrl/my-bookings';

  // ✅ Tambahan baru untuk payment QRIS
  static String bookingPayment(String bookingCode) =>
      '$baseUrl/bookings/$bookingCode/payment';
  static String confirmPayment(String bookingCode) =>
      '$baseUrl/bookings/$bookingCode/confirm-payment';
}

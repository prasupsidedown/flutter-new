class ApiConstants {
  // ==================== Gemini ====================
  static const String geminiApiKey = String.fromEnvironment('GEMINI_API_KEY');
  static const String geminiModel = 'gemini-2.5-flash';

  // ==================== Laravel API ====================
  static const String baseUrl = 'http://10.0.2.2:8000/api'; // emulator Android
  // static const String baseUrl = 'http://localhost:8000/api'; // iOS simulator

  static const String login = '$baseUrl/login';
  static const String register = '$baseUrl/register';
  static const String logout = '$baseUrl/logout';
  static const String agen = '$baseUrl/agen';
  static const String search = '$baseUrl/search';
}

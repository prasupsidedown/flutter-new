import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/api_constants.dart';
import '../../domain/entities/entities.dart';

abstract class TravelRepository {
  Future<Map<String, dynamic>> login(String email, String password);
  Future<Map<String, dynamic>> register(
      String name, String email, String password, String phone);
  Future<void> logout();
  Future<String?> getToken();
  Future<Map<String, dynamic>> getUserProfile();
  Future<List<Destination>> fetchDestinations();
  Future<List<Tour>> fetchTourPackages();
  Future<List<Vehicle>> fetchVehicles();
  Future<List<Agent>> fetchAgents();
  Future<Map<String, dynamic>> createBooking(Map<String, dynamic> data);
  Future<List<TripHistory>> fetchMyBookings();
  Future<Map<String, dynamic>> getPaymentData(String bookingCode); // ← BARU
  Future<Map<String, dynamic>> confirmPayment(String bookingCode); // ← BARU
  List<Destination> getPopularDestinations();
  List<Tour> getFeaturedTours();
  List<Agent> getVerifiedAgents();
  List<TripHistory> getTripHistory();
}

class TravelRepositoryImpl implements TravelRepository {
  final bool _isWeb = kIsWeb;
  final _secureStorage = const FlutterSecureStorage();

  Future<SharedPreferences> _getPrefs() async =>
      await SharedPreferences.getInstance();

  Future<void> _saveToken(String token) async {
    if (_isWeb) {
      final prefs = await _getPrefs();
      await prefs.setString('token', token);
    } else {
      await _secureStorage.write(key: 'token', value: token);
    }
  }

  @override
  Future<String?> getToken() async {
    if (_isWeb) {
      final prefs = await _getPrefs();
      return prefs.getString('token');
    } else {
      return await _secureStorage.read(key: 'token');
    }
  }

  Future<void> _deleteToken() async {
    if (_isWeb) {
      final prefs = await _getPrefs();
      await prefs.remove('token');
    } else {
      await _secureStorage.delete(key: 'token');
    }
  }

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final res = await http.post(
        Uri.parse(ApiConstants.login),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      debugPrint('LOGIN STATUS: ${res.statusCode}');
      debugPrint('LOGIN BODY: ${res.body}');

      final data = jsonDecode(res.body);

      if (res.statusCode == 200 && data['success'] == true) {
        await _saveToken(data['data']['token']);
        return {'success': true, 'user': User.fromJson(data['data']['user'])};
      }
      return {'success': false, 'message': data['message'] ?? 'Login gagal'};
    } catch (e) {
      debugPrint('LOGIN ERROR: $e');
      return {'success': false, 'message': 'Tidak dapat terhubung ke server'};
    }
  }

  @override
  Future<Map<String, dynamic>> register(
      String name, String email, String password, String phone) async {
    try {
      final res = await http.post(
        Uri.parse(ApiConstants.register),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'phone': phone
        }),
      );

      final data = jsonDecode(res.body);

      if (res.statusCode == 201 && data['success'] == true) {
        await _saveToken(data['data']['token']);
        return {'success': true, 'user': User.fromJson(data['data']['user'])};
      }
      return {'success': false, 'message': data['message'] ?? 'Register gagal'};
    } catch (e) {
      return {'success': false, 'message': 'Tidak dapat terhubung ke server'};
    }
  }

  @override
  Future<void> logout() async {
    try {
      final token = await getToken();
      if (token != null) {
        await http.post(
          Uri.parse(ApiConstants.logout),
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json'
          },
        );
      }
    } catch (_) {
    } finally {
      await _deleteToken();
    }
  }

  @override
  Future<Map<String, dynamic>> getUserProfile() async {
    try {
      final token = await getToken();
      if (token == null) {
        return {'success': false, 'message': 'Token tidak ditemukan'};
      }

      final res = await http.get(
        Uri.parse(ApiConstants.profile),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json'
        },
      );

      final data = jsonDecode(res.body);
      if (res.statusCode == 200 && data['success'] == true) {
        return {'success': true, 'user': User.fromJson(data['data'])};
      }
      return {
        'success': false,
        'message': data['message'] ?? 'Gagal ambil profil'
      };
    } catch (e) {
      return {'success': false, 'message': 'Tidak dapat terhubung ke server'};
    }
  }

  @override
  Future<List<Destination>> fetchDestinations() async {
    try {
      final res = await http.get(Uri.parse(ApiConstants.destinations),
          headers: {'Accept': 'application/json'});
      debugPrint('DESTINATIONS STATUS: ${res.statusCode}');
      debugPrint('DESTINATIONS BODY: ${res.body}');
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final List destinations = data['data']['data'];
        debugPrint('DESTINATIONS COUNT: ${destinations.length}');
        return destinations.map((e) => Destination.fromJson(e)).toList();
      }
      return getPopularDestinations();
    } catch (e) {
      debugPrint('DESTINATIONS ERROR: $e');
      return getPopularDestinations();
    }
  }

  @override
  Future<List<Tour>> fetchTourPackages() async {
    try {
      final res = await http.get(Uri.parse(ApiConstants.tourPackages),
          headers: {'Accept': 'application/json'});
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final List packages = data['data']['data'];
        return packages.map((e) => Tour.fromJson(e)).toList();
      }
      return getFeaturedTours();
    } catch (e) {
      return getFeaturedTours();
    }
  }

  @override
  Future<List<Vehicle>> fetchVehicles() async {
    try {
      final res = await http.get(Uri.parse(ApiConstants.vehicles),
          headers: {'Accept': 'application/json'});
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final List vehicles = data['data']['data'];
        return vehicles.map((e) => Vehicle.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<Agent>> fetchAgents() async {
    try {
      final res = await http.get(Uri.parse(ApiConstants.agents),
          headers: {'Accept': 'application/json'});
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final List agents = data['data']['data'];
        return agents.map((e) => Agent.fromJson(e)).toList();
      }
      return getVerifiedAgents();
    } catch (e) {
      return getVerifiedAgents();
    }
  }

  @override
  Future<Map<String, dynamic>> createBooking(Map<String, dynamic> data) async {
    try {
      final token = await getToken();
      if (token == null) {
        return {'success': false, 'message': 'Silakan login terlebih dahulu'};
      }

      final res = await http.post(
        Uri.parse(ApiConstants.createBooking),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(data),
      );

      final responseData = jsonDecode(res.body);
      if (res.statusCode == 201 && responseData['success'] == true) {
        return {
          'success': true,
          'message': responseData['message'],
          'data': responseData['data']
        };
      }
      return {
        'success': false,
        'message': responseData['message'] ?? 'Booking gagal'
      };
    } catch (e) {
      return {'success': false, 'message': 'Tidak dapat terhubung ke server'};
    }
  }

  @override
  Future<List<TripHistory>> fetchMyBookings() async {
    try {
      final token = await getToken();
      if (token == null) return getTripHistory();

      final res = await http.get(
        Uri.parse(ApiConstants.myBookings),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json'
        },
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final List bookings = data['data']['data'];
        return bookings.map((e) => TripHistory.fromJson(e)).toList();
      }
      return getTripHistory();
    } catch (e) {
      return getTripHistory();
    }
  }

  // ─── BARU: Ambil data pembayaran QRIS berdasarkan booking code ──────────────
  @override
  Future<Map<String, dynamic>> getPaymentData(String bookingCode) async {
    try {
      final token = await getToken();
      if (token == null) {
        return {'success': false, 'message': 'Silakan login terlebih dahulu'};
      }

      final res = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/bookings/$bookingCode/payment'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      debugPrint('GET PAYMENT STATUS: ${res.statusCode}');
      debugPrint('GET PAYMENT BODY: ${res.body}');

      final data = jsonDecode(res.body);
      if (res.statusCode == 200 && data['success'] == true) {
        return {'success': true, 'data': data['data']};
      }
      return {
        'success': false,
        'message': data['message'] ?? 'Gagal memuat data pembayaran'
      };
    } catch (e) {
      debugPrint('GET PAYMENT ERROR: $e');
      return {'success': false, 'message': 'Tidak dapat terhubung ke server'};
    }
  }

  // ─── BARU: Konfirmasi pembayaran sudah dilakukan ─────────────────────────────
  @override
  Future<Map<String, dynamic>> confirmPayment(String bookingCode) async {
    try {
      final token = await getToken();
      if (token == null) {
        return {'success': false, 'message': 'Silakan login terlebih dahulu'};
      }

      final res = await http.post(
        Uri.parse(
            '${ApiConstants.baseUrl}/bookings/$bookingCode/confirm-payment'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      debugPrint('CONFIRM PAYMENT STATUS: ${res.statusCode}');
      debugPrint('CONFIRM PAYMENT BODY: ${res.body}');

      final data = jsonDecode(res.body);
      if (res.statusCode == 200 && data['success'] == true) {
        return {'success': true, 'message': data['message']};
      }
      return {
        'success': false,
        'message': data['message'] ?? 'Konfirmasi pembayaran gagal'
      };
    } catch (e) {
      debugPrint('CONFIRM PAYMENT ERROR: $e');
      return {'success': false, 'message': 'Tidak dapat terhubung ke server'};
    }
  }

  @override
  List<Destination> getPopularDestinations() => [
        Destination(
            id: 1,
            name: 'Raja Ampat',
            location: 'Papua Barat',
            rating: 4.9,
            category: 'Alam'),
        Destination(
            id: 2,
            name: 'Labuan Bajo',
            location: 'NTT',
            rating: 4.8,
            category: 'Petualangan'),
        Destination(
            id: 3,
            name: 'Borobudur',
            location: 'Jawa Tengah',
            rating: 4.7,
            category: 'Budaya'),
        Destination(
            id: 4,
            name: 'Danau Toba',
            location: 'Sumatera Utara',
            rating: 4.6,
            category: 'Alam'),
      ];

  @override
  List<Tour> getFeaturedTours() => [
        Tour(
            id: 1,
            title: '3D2N Raja Ampat Adventure',
            location: 'Raja Ampat',
            province: 'Papua Barat',
            price: 'Rp 3.200.000',
            duration: '3 Hari 2 Malam',
            capacity: '12 Peserta',
            rating: 4.9,
            category: 'Alam'),
        Tour(
            id: 2,
            title: 'Komodo Island Explorer',
            location: 'Labuan Bajo',
            province: 'NTT',
            price: 'Rp 2.500.000',
            duration: '2 Hari 1 Malam',
            capacity: '8 Peserta',
            rating: 4.8,
            category: 'Petualangan'),
      ];

  @override
  List<Agent> getVerifiedAgents() => [
        Agent(
            id: '1',
            name: 'Nusa Indah Travel',
            location: 'Bali',
            rating: 4.9,
            totalTours: 42,
            specialty: 'Budaya & Alam',
            isVerified: true,
            isTopPick: true),
      ];

  @override
  List<TripHistory> getTripHistory() => [];
}

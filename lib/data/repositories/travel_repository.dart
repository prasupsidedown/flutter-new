import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/constants/api_constants.dart';
import '../../domain/entities/entities.dart';

abstract class TravelRepository {
  List<Tour> getFeaturedTours();
  List<Destination> getPopularDestinations();
  List<Agent> getVerifiedAgents();
  List<TripHistory> getTripHistory();
  UserProfile getUserProfile();

  // API methods
  Future<Map<String, dynamic>> login(String email, String password);
  Future<Map<String, dynamic>> register(
      String name, String email, String password);
  Future<void> logout();
  Future<String?> getToken();
  Future<List<Agent>> fetchAgentsFromApi();
}

class TravelRepositoryImpl implements TravelRepository {
  final _storage = const FlutterSecureStorage();

  // ==================== Token Management ====================

  Future<void> _saveToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  @override
  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

  Future<void> _deleteToken() async {
    await _storage.delete(key: 'token');
  }

  // ==================== Auth API ====================

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final res = await http.post(
        Uri.parse(ApiConstants.login),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        await _saveToken(data['token']);
        return {'success': true, 'user': User.fromJson(data['user'])};
      }

      return {'success': false, 'message': data['message'] ?? 'Login gagal'};
    } catch (e) {
      return {'success': false, 'message': 'Tidak dapat terhubung ke server'};
    }
  }

  @override
  Future<Map<String, dynamic>> register(
      String name, String email, String password) async {
    try {
      final res = await http.post(
        Uri.parse(ApiConstants.register),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': password,
        }),
      );

      final data = jsonDecode(res.body);

      if (res.statusCode == 201) {
        await _saveToken(data['token']);
        return {'success': true, 'user': User.fromJson(data['user'])};
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
      await http.post(
        Uri.parse(ApiConstants.logout),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
    } catch (_) {
      // tetap hapus token meski request gagal
    } finally {
      await _deleteToken();
    }
  }

  // ==================== Agent API ====================

  @override
  Future<List<Agent>> fetchAgentsFromApi() async {
    try {
      final token = await getToken();
      final res = await http.get(
        Uri.parse(ApiConstants.agen),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body)['data'] as List;
        return data.map((e) => Agent.fromJson(e)).toList();
      }

      return getVerifiedAgents(); // fallback ke dummy
    } catch (e) {
      return getVerifiedAgents(); // fallback ke dummy
    }
  }

  // ==================== Dummy Data (tetap ada) ====================

  @override
  List<Tour> getFeaturedTours() => [
        const Tour(
          id: '1',
          title: '3D2N Raja Ampat Adventure',
          location: 'Raja Ampat',
          province: 'Papua Barat',
          price: 'Rp 3.200.000',
          duration: '3 Hari 2 Malam',
          capacity: '12 Peserta',
          rating: 4.9,
          category: 'Alam',
        ),
        const Tour(
          id: '2',
          title: 'Komodo Island Explorer',
          location: 'Labuan Bajo',
          province: 'NTT',
          price: 'Rp 2.500.000',
          duration: '2 Hari 1 Malam',
          capacity: '8 Peserta',
          rating: 4.8,
          category: 'Petualangan',
        ),
        const Tour(
          id: '3',
          title: 'Bali Heritage Trail',
          location: 'Bali',
          province: 'Bali',
          price: 'Rp 1.800.000',
          duration: '1 Hari',
          capacity: '20 Peserta',
          rating: 4.7,
          category: 'Budaya',
        ),
      ];

  @override
  List<Destination> getPopularDestinations() => [
        const Destination(
            id: '1',
            name: 'Raja Ampat',
            location: 'Papua Barat',
            rating: 4.9,
            category: 'Alam'),
        const Destination(
            id: '2',
            name: 'Labuan Bajo',
            location: 'NTT',
            rating: 4.8,
            category: 'Petualangan'),
        const Destination(
            id: '3',
            name: 'Borobudur',
            location: 'Jawa Tengah',
            rating: 4.7,
            category: 'Budaya'),
        const Destination(
            id: '4',
            name: 'Danau Toba',
            location: 'Sumatera Utara',
            rating: 4.6,
            category: 'Alam'),
      ];

  @override
  List<Agent> getVerifiedAgents() => [
        const Agent(
            id: '1',
            name: 'Nusa Indah Travel',
            location: 'Bali, Indonesia',
            rating: 4.9,
            totalTours: 42,
            specialty: 'Budaya & Alam',
            isVerified: true,
            isTopPick: true),
        const Agent(
            id: '2',
            name: 'Raja Explorer',
            location: 'Raja Ampat, Papua',
            rating: 4.8,
            totalTours: 18,
            specialty: 'Diving & Snorkeling',
            isVerified: true,
            isTopPick: false),
        const Agent(
            id: '3',
            name: 'Jawa Tengah Heritage',
            location: 'Yogyakarta, Jawa',
            rating: 4.7,
            totalTours: 31,
            specialty: 'Sejarah & Kuliner',
            isVerified: true,
            isTopPick: false),
        const Agent(
            id: '4',
            name: 'Lombok Surf & Trek',
            location: 'Lombok, NTB',
            rating: 4.6,
            totalTours: 24,
            specialty: 'Surfing & Hiking',
            isVerified: false,
            isTopPick: false),
      ];

  @override
  List<TripHistory> getTripHistory() => [
        const TripHistory(
            id: '1',
            tourName: '3D2N Raja Ampat Adventure',
            agentName: 'Raja Explorer',
            dateRange: '12–14 Jan 2024',
            price: 'Rp 3.200.000',
            status: TripStatus.completed),
        const TripHistory(
            id: '2',
            tourName: 'Komodo Island Explorer',
            agentName: 'Nusa Indah Travel',
            dateRange: '5–6 Mar 2024',
            price: 'Rp 2.500.000',
            status: TripStatus.active),
        const TripHistory(
            id: '3',
            tourName: 'Bali Heritage Trail',
            agentName: 'Nusa Indah Travel',
            dateRange: '20 Feb 2024',
            price: 'Rp 1.800.000',
            status: TripStatus.completed),
        const TripHistory(
            id: '4',
            tourName: 'Lombok Surf & Trek',
            agentName: 'Lombok Surf & Trek',
            dateRange: '28 Jan 2024',
            price: 'Rp 1.500.000',
            status: TripStatus.cancelled),
      ];

  @override
  UserProfile getUserProfile() => const UserProfile(
        name: 'Budi Santoso',
        email: 'budi.santoso@email.com',
        totalTrips: 8,
        totalDestinations: 3,
        points: '1.2k',
        membershipLevel: 'Penjelajah Premium',
      );
}

class Tour {
  final String id;
  final String title;
  final String location;
  final String province;
  final String price;
  final String duration;
  final String capacity;
  final double rating;
  final String category;

  const Tour({
    required this.id,
    required this.title,
    required this.location,
    required this.province,
    required this.price,
    required this.duration,
    required this.capacity,
    required this.rating,
    required this.category,
  });

  factory Tour.fromJson(Map<String, dynamic> json) {
    return Tour(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      location: json['location'] ?? '',
      province: json['province'] ?? '',
      price: json['price'].toString(),
      duration: json['duration'] ?? '',
      capacity: json['capacity'].toString(),
      rating: (json['rating'] ?? 0).toDouble(),
      category: json['category'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'location': location,
        'province': province,
        'price': price,
        'duration': duration,
        'capacity': capacity,
        'rating': rating,
        'category': category,
      };
}

class Destination {
  final String id;
  final String name;
  final String location;
  final double rating;
  final String category;

  const Destination({
    required this.id,
    required this.name,
    required this.location,
    required this.rating,
    required this.category,
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      category: json['category'] ?? '',
    );
  }
}

class Agent {
  final String id;
  final String name;
  final String location;
  final double rating;
  final int totalTours;
  final String specialty;
  final bool isVerified;
  final bool isTopPick;

  const Agent({
    required this.id,
    required this.name,
    required this.location,
    required this.rating,
    required this.totalTours,
    required this.specialty,
    required this.isVerified,
    required this.isTopPick,
  });

  factory Agent.fromJson(Map<String, dynamic> json) {
    return Agent(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      totalTours: json['total_tours'] ?? 0,
      specialty: json['specialty'] ?? '',
      isVerified: json['is_verified'] ?? false,
      isTopPick: json['is_top_pick'] ?? false,
    );
  }
}

class TripHistory {
  final String id;
  final String tourName;
  final String agentName;
  final String dateRange;
  final String price;
  final TripStatus status;

  const TripHistory({
    required this.id,
    required this.tourName,
    required this.agentName,
    required this.dateRange,
    required this.price,
    required this.status,
  });

  factory TripHistory.fromJson(Map<String, dynamic> json) {
    return TripHistory(
      id: json['id'].toString(),
      tourName: json['tour_name'] ?? '',
      agentName: json['agent_name'] ?? '',
      dateRange: json['date_range'] ?? '',
      price: json['price'].toString(),
      status: TripStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => TripStatus.active,
      ),
    );
  }
}

enum TripStatus { active, completed, cancelled }

class UserProfile {
  final String name;
  final String email;
  final int totalTrips;
  final int totalDestinations;
  final String points;
  final String membershipLevel;

  const UserProfile({
    required this.name,
    required this.email,
    required this.totalTrips,
    required this.totalDestinations,
    required this.points,
    required this.membershipLevel,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      totalTrips: json['total_trips'] ?? 0,
      totalDestinations: json['total_destinations'] ?? 0,
      points: json['points'].toString(),
      membershipLevel: json['membership_level'] ?? 'Silver',
    );
  }
}

// Tambahan: User untuk Auth
class User {
  final int id;
  final String name;
  final String email;

  const User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }
}

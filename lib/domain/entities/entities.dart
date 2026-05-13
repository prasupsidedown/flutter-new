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
}

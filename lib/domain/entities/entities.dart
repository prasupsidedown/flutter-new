// ==================== User ====================
class User {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final bool isActive;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.isActive = true,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      isActive: json['is_active'] == 1 || json['is_active'] == true,
    );
  }
}

// ==================== Destination ====================
class Destination {
  final int id;
  final String name;
  final String location;
  final double rating;
  final String category;
  final String? province;
  final String? city;
  final String? imageUrl;

  Destination({
    required this.id,
    required this.name,
    required this.location,
    required this.rating,
    required this.category,
    this.province,
    this.city,
    this.imageUrl,
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      location: json['location'] ?? json['city'] ?? '',
      rating: (json['rating'] ?? 4.5).toDouble(),
      category: json['category'] is Map
          ? (json['category']['name'] ?? 'Wisata')
          : (json['category'] ?? 'Wisata'),
      province: json['province'],
      city: json['city'],
      imageUrl: json['images'] != null && (json['images'] as List).isNotEmpty
          ? json['images'][0]['image_url']
          : null,
    );
  }
}

// ==================== Tour / Package ====================
class Tour {
  final int id;
  final String title;
  final String location;
  final String province;
  final String price;
  final String duration;
  final String capacity;
  final double rating;
  final String category;

  Tour({
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
    final destination = json['destination'] is Map ? json['destination'] : null;

    return Tour(
      id: json['id'] ?? 0,
      title: json['name'] ?? '',
      location: destination?['location'] ??
          destination?['city'] ??
          json['location'] ??
          '',
      province: destination?['province'] ?? json['province'] ?? '',
      price:
          'Rp ${(json['price'] ?? 0).toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}',
      duration: json['duration'] ?? '1 Hari',
      capacity: '${json['quota'] ?? 0} Peserta',
      rating: (json['rating'] ?? 4.5).toDouble(),
      category: json['category'] is Map
          ? (json['category']['name'] ?? 'Wisata')
          : (destination?['category'] is Map
              ? (destination!['category']['name'] ?? 'Wisata')
              : (json['category'] ?? 'Wisata')),
    );
  }
}

// ==================== Vehicle ====================
class Vehicle {
  final int id;
  final String name;
  final String type;
  final int capacity;
  final int priceWithDriver;
  final int priceWithoutDriver;
  final String status;
  final List<dynamic> routes;
  final String? photoUrl;

  Vehicle({
    required this.id,
    required this.name,
    required this.type,
    required this.capacity,
    required this.priceWithDriver,
    required this.priceWithoutDriver,
    required this.status,
    required this.routes,
    this.photoUrl,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      capacity: json['capacity'] ?? 0,
      priceWithDriver: json['price_with_driver'] ?? 0,
      priceWithoutDriver: json['price_without_driver'] ?? 0,
      status: json['status'] ?? 'available',
      routes: json['routes'] ?? [],
      photoUrl: json['photo_url'],
    );
  }
}

// ==================== Agent ====================
class Agent {
  final String id;
  final String name;
  final String location;
  final double rating;
  final int totalTours;
  final String specialty;
  final bool isVerified;
  final bool isTopPick;

  Agent({
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
      name: json['agency_name'] ?? '',
      location: '${json['city'] ?? ''}, ${json['province'] ?? ''}',
      rating: double.tryParse(json['rating']?.toString() ?? '0') ?? 0,
      totalTours: json['total_trips'] ?? 0,
      specialty: json['description'] ?? 'Travel',
      isVerified: json['status'] == 'active',
      isTopPick: (json['rating'] ?? 0) > 4.5,
    );
  }
}

// ==================== Trip History ====================
enum TripStatus { active, completed, cancelled }

class TripHistory {
  final String id;
  final String tourName;
  final String agentName;
  final String dateRange;
  final String price;
  final TripStatus status;

  TripHistory({
    required this.id,
    required this.tourName,
    required this.agentName,
    required this.dateRange,
    required this.price,
    required this.status,
  });

  factory TripHistory.fromJson(Map<String, dynamic> json) {
    String statusStr = json['payment_status'] ?? 'pending';
    TripStatus status;
    if (statusStr == 'paid') {
      status = TripStatus.completed;
    } else if (statusStr == 'expired') {
      status = TripStatus.cancelled;
    } else {
      status = TripStatus.active;
    }

    return TripHistory(
      id: json['booking_code'] ?? '',
      tourName: json['tourPackage']?['name'] ??
          json['vehicle']?['name'] ??
          'Perjalanan',
      agentName: json['agent']?['agency_name'] ?? 'Agen',
      dateRange: json['travel_date'] ?? '',
      price:
          'Rp ${(json['total_price'] ?? 0).toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}',
      status: status,
    );
  }
}

// ==================== Booking ====================
class BookingHistory {
  final String bookingCode;
  final String bookingType;
  final String customerName;
  final int totalPrice;
  final String paymentStatus;
  final String travelDate;

  BookingHistory({
    required this.bookingCode,
    required this.bookingType,
    required this.customerName,
    required this.totalPrice,
    required this.paymentStatus,
    required this.travelDate,
  });

  factory BookingHistory.fromJson(Map<String, dynamic> json) {
    return BookingHistory(
      bookingCode: json['booking_code'] ?? '',
      bookingType: json['booking_type'] ?? '',
      customerName: json['customer_name'] ?? '',
      totalPrice: json['total_price'] ?? 0,
      paymentStatus: json['payment_status'] ?? '',
      travelDate: json['travel_date'] ?? '',
    );
  }
}

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../data/repositories/travel_repository.dart';
import '../../domain/entities/entities.dart';
import '../widgets/shared_widgets.dart';
import 'vehicle_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'Pantai';
  final _repo = TravelRepositoryImpl();

  List<Destination> _allDestinations = [];
  List<Tour> _tours = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final destinations = await _repo.fetchDestinations();
    final tours = await _repo.fetchTourPackages();
    setState(() {
      _allDestinations = destinations;
      _tours = tours;
      _isLoading = false;
    });
  }

  List<Destination> _getFilteredDestinations() {
    if (_selectedCategory == 'Lainnya') return _allDestinations;
    return _allDestinations
        .where((dest) => dest.category == _selectedCategory)
        .toList();
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredDestinations = _getFilteredDestinations();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MobiAppBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeroBanner(onExplore: () {}),
                  const SizedBox(height: 20),
                  _SearchBar(),
                  const SizedBox(height: 20),
                  _CategoryRow(
                    selectedCategory: _selectedCategory,
                    onCategorySelected: _onCategorySelected,
                  ),
                  const SizedBox(height: 28),
                  SectionHeader(
                    title: 'Destinasi Populer',
                    actionLabel: 'Lihat Semua',
                    onAction: () {},
                  ),
                  const SizedBox(height: 14),
                  _DestinationList(destinations: filteredDestinations),
                  const SizedBox(height: 28),
                  SectionHeader(
                    title: 'Tur Terpilih',
                    actionLabel: 'Lihat Semua',
                    onAction: () {},
                  ),
                  const SizedBox(height: 14),
                  _TourList(tours: _tours),
                  const SizedBox(height: 24),
                  _PromoCard(),
                  const SizedBox(height: 90),
                ],
              ),
            ),
      bottomNavigationBar: const MobiBottomNav(currentIndex: 0),
    );
  }
}

// ─── Hero Banner ───────────────────────────────────────────────────────────

class _HeroBanner extends StatelessWidget {
  final VoidCallback onExplore;
  const _HeroBanner({required this.onExplore});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Container(
        width: double.infinity,
        height: 220,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF122A22), Color(0xFF1E3D32), Color(0xFF2A5244)],
            stops: [0.0, 0.5, 1.0],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1A3328).withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Decorative pattern
            Positioned(
              right: -40,
              top: -40,
              child: _decorCircle(200, 0.07),
            ),
            Positioned(
              right: 60,
              bottom: -50,
              child: _decorCircle(130, 0.05),
            ),
            Positioned(
              left: -30,
              bottom: -30,
              child: _decorCircle(140, 0.04),
            ),
            // Floating badge top right
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFD4A44C).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFFD4A44C).withValues(alpha: 0.4),
                    width: 1,
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: Color(0xFFD4A44C), size: 12),
                    SizedBox(width: 4),
                    Text(
                      '4.9 Rating',
                      style: TextStyle(
                        color: Color(0xFFD4A44C),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF7B5E2A).withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFD4A44C).withValues(alpha: 0.4),
                      ),
                    ),
                    child: const Text(
                      '🌿 Eksplorasi Nusantara',
                      style: TextStyle(
                        color: Color(0xFFD4A44C),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Temukan\nDestinasi Impian',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.15,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '500+ destinasi menakjubkan menunggumu',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: onExplore,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF9B7A35), Color(0xFF7B5E2A)],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color:
                                const Color(0xFF7B5E2A).withValues(alpha: 0.5),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Jelajahi Sekarang',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.2,
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward,
                              color: Colors.white, size: 15),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _decorCircle(double size, double opacity) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: opacity),
        ),
      );
}

// ─── Search Bar ────────────────────────────────────────────────────────────

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, AppRoutes.search),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: 14),
              Icon(Icons.search, color: AppColors.textMuted, size: 20),
              const SizedBox(width: 10),
              Text(
                'Cari destinasi, tur, atau agen...',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.all(7),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.tune, color: Colors.white, size: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Category Row ──────────────────────────────────────────────────────────

class _CategoryRow extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const _CategoryRow({
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  final _categories = const [
    _Category(Icons.beach_access_outlined, 'Pantai'),
    _Category(Icons.landscape_outlined, 'Gunung'),
    _Category(Icons.account_balance_outlined, 'Budaya'),
    _Category(Icons.restaurant_outlined, 'Kuliner'),
    _Category(Icons.waves_outlined, 'Diving'),
    _Category(Icons.more_horiz, 'Lainnya'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) {
          final cat = _categories[i];
          final isSelected = selectedCategory == cat.label;
          return GestureDetector(
            onTap: () => onCategorySelected(cat.label),
            child: Column(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isSelected
                            ? AppColors.primary.withValues(alpha: 0.2)
                            : Colors.black.withValues(alpha: 0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(
                    cat.icon,
                    color: isSelected ? Colors.white : AppColors.accent,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  cat.label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Category {
  final IconData icon;
  final String label;
  const _Category(this.icon, this.label);
}

// ─── Destination Cards ────────────────────────────────────────────────────

class _DestinationList extends StatelessWidget {
  final List<Destination> destinations;
  const _DestinationList({required this.destinations});

  @override
  Widget build(BuildContext context) {
    if (destinations.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.explore_off_outlined,
                size: 64,
                color: AppColors.textMuted.withValues(alpha: 0.4),
              ),
              const SizedBox(height: 12),
              Text(
                'Belum ada destinasi untuk kategori ini',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Coba kategori lainnya',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textMuted.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      height: 200,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: destinations.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) => _DestCard(dest: destinations[i]),
      ),
    );
  }
}

class _DestCard extends StatelessWidget {
  final Destination dest;
  const _DestCard({required this.dest});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.vehicleDetail,
        arguments: VehicleDetailArgs(
          title: dest.name,
          subtitle: dest.location,
          rating: dest.rating,
          price: 'Rp 1.500.000',
          duration: '1–3 Hari',
          capacity: '12 Peserta',
          imageUrl: _imageForDestination(dest.name),
          category: dest.category,
        ),
      ),
      child: Container(
        width: 155,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image area
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: SizedBox(
                height: 118,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      _imageForDestination(dest.name),
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: _gradientForCategory(dest.category),
                          ),
                        ),
                        child: Icon(
                          _iconForCategory(dest.category),
                          color: Colors.white.withValues(alpha: 0.4),
                          size: 52,
                        ),
                      ),
                    ),
                    // dark overlay agar teks terbaca
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.35),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.35),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.15),
                            width: 0.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star,
                                color: Color(0xFFFFCC47), size: 11),
                            const SizedBox(width: 3),
                            Text(
                              dest.rating.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          dest.category,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dest.name,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          size: 11,
                          color: AppColors.accent.withValues(alpha: 0.7)),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          dest.location,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textMuted,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _imageForDestination(String name) {
    switch (name) {
      case 'Raja Ampat':
        return 'https://images.unsplash.com/photo-1516690561799-46d8f74f9abf?w=400&q=80';
      case 'Labuan Bajo':
        return 'https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=400&q=80';
      case 'Borobudur':
        return 'https://images.unsplash.com/photo-1596402184320-417e7178b2cd?w=400&q=80';
      case 'Danau Toba':
        return 'https://images.unsplash.com/photo-1573790387438-4da905039392?w=400&q=80';
      default:
        return 'https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=400&q=80';
    }
  }

  List<Color> _gradientForCategory(String cat) {
    switch (cat) {
      case 'Alam':
        return [const Color(0xFF1A3328), const Color(0xFF2D5C48)];
      case 'Petualangan':
        return [const Color(0xFF1A2E3A), const Color(0xFF2D4A5A)];
      case 'Budaya':
        return [const Color(0xFF3A2A1A), const Color(0xFF5C4A2D)];
      default:
        return [const Color(0xFF2A1A3A), const Color(0xFF4A2D5A)];
    }
  }

  IconData _iconForCategory(String cat) {
    switch (cat) {
      case 'Alam':
        return Icons.landscape_outlined;
      case 'Petualangan':
        return Icons.explore_outlined;
      case 'Budaya':
        return Icons.account_balance_outlined;
      default:
        return Icons.place_outlined;
    }
  }
}

// ─── Tour List ────────────────────────────────────────────────────────────

class _TourList extends StatelessWidget {
  final List<Tour> tours;
  const _TourList({required this.tours});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: tours
            .map((t) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _TourCard(tour: t),
                ))
            .toList(),
      ),
    );
  }
}

class _TourCard extends StatelessWidget {
  final Tour tour;
  const _TourCard({required this.tour});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.vehicleDetail,
        arguments: VehicleDetailArgs(
          title: tour.title,
          subtitle: '${tour.location}, ${tour.province}',
          rating: tour.rating,
          price: tour.price,
          duration: tour.duration,
          capacity: tour.capacity,
          imageUrl: _imageForTour(tour.title),
          category: tour.category,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: SizedBox(
                  width: 72,
                  height: 72,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        _imageForTour(tour.title),
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF1E3D32), Color(0xFF2A5244)],
                            ),
                          ),
                          child: const Icon(Icons.tour_outlined,
                              color: Colors.white, size: 32),
                        ),
                      ),
                      Container(
                        color: Colors.black.withValues(alpha: 0.15),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFFD4A44C).withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.white, size: 8),
                              const SizedBox(width: 2),
                              Text(
                                tour.rating.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tour.title,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _InfoChip(Icons.access_time_outlined, tour.duration),
                        const SizedBox(width: 12),
                        _InfoChip(Icons.people_outline, tour.capacity),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Mulai dari',
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.textMuted,
                              ),
                            ),
                            Text(
                              tour.price,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: AppColors.accent,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 7),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Pesan',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _imageForTour(String title) {
    if (title.contains('Raja Ampat')) {
      return 'https://images.unsplash.com/photo-1516690561799-46d8f74f9abf?w=200&q=80';
    } else if (title.contains('Komodo')) {
      return 'https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=200&q=80';
    } else if (title.contains('Bali')) {
      return 'https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=200&q=80';
    }
    return 'https://images.unsplash.com/photo-1596402184320-417e7178b2cd?w=200&q=80';
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoChip(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 12, color: AppColors.textMuted),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
        ),
      ],
    );
  }
}

// ─── Promo Card ────────────────────────────────────────────────────────────

class _PromoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF8A6A30), Color(0xFF5C4018)],
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7B5E2A).withValues(alpha: 0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                        width: 0.5,
                      ),
                    ),
                    child: const Text(
                      'PROMO SPESIAL',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Hemat 30% untuk\nPaket Tur Perdana',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      height: 1.25,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Berlaku hingga 31 Des 2024',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.65),
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 14),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 9),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Text(
                        'Klaim Sekarang →',
                        style: TextStyle(
                          color: Color(0xFF7B5E2A),
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.local_offer_outlined,
                color: Colors.white,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

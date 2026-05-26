import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_routes.dart';
import 'booking_screen.dart';

class VehicleSpec {
  final String label;
  final String value;
  const VehicleSpec(this.label, this.value);
}

class VehicleFacility {
  final IconData icon;
  final String label;
  const VehicleFacility(this.icon, this.label);
}

class VehicleSchedule {
  final String fromCity;
  final String fromTime;
  final String fromTerminal;
  final String toCity;
  final String toTime;
  final String toTerminal;
  final String travelTime;
  const VehicleSchedule({
    required this.fromCity,
    required this.fromTime,
    required this.fromTerminal,
    required this.toCity,
    required this.toTime,
    required this.toTerminal,
    required this.travelTime,
  });
}

class VehicleDetailArgs {
  final String title;
  final String subtitle;
  final double rating;
  final String price;
  final String duration;
  final String capacity;
  final String imageUrl;
  final String category;
  final List<VehicleSpec> specs;
  final List<VehicleFacility> facilities;
  final VehicleSchedule? schedule;

  const VehicleDetailArgs({
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.price,
    required this.duration,
    required this.capacity,
    required this.imageUrl,
    required this.category,
    this.specs = const [],
    this.facilities = const [],
    this.schedule,
  });
}

class VehicleDetailScreen extends StatelessWidget {
  const VehicleDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Terima argument dari Navigator; fallback ke data default kalau null
    final args =
        ModalRoute.of(context)?.settings.arguments as VehicleDetailArgs?;
    final data = args ??
        const VehicleDetailArgs(
          title: 'Bus Executive Class',
          subtitle: 'Surabaya • Jakarta',
          rating: 4.8,
          price: 'Rp 350.000',
          duration: '8 Jam',
          capacity: '40 Kursi',
          imageUrl: '',
          category: 'Transportasi',
        );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _HeroSection(data: data),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        _InfoCard(data: data),
                        const SizedBox(height: 14),
                        _SpecsCard(specs: data.specs),
                        const SizedBox(height: 14),
                        _FacilitiesCard(facilities: data.facilities),
                        const SizedBox(height: 14),
                        if (data.schedule != null)
                          _ScheduleCard(schedule: data.schedule!),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _BottomBar(price: data.price, fullData: data),
        ],
      ),
    );
  }
}

// ─── Hero Section ──────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  final VehicleDetailArgs data;
  const _HeroSection({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF5F0E8), Color(0xFFEDE6D4)],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned(
              right: -40,
              top: 20,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.border.withValues(alpha: 0.5),
                ),
              ),
            ),
            Positioned(
              left: -30,
              bottom: -30,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.border.withValues(alpha: 0.4),
                ),
              ),
            ),
            // Top navigation
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.arrow_back_ios_new,
                          color: AppColors.primary, size: 16),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.share_outlined,
                          color: AppColors.primary, size: 18),
                    ),
                  ),
                ],
              ),
            ),
            // Hero image / icon
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: data.imageUrl.isNotEmpty
                          ? Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  data.imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => _fallbackIcon(),
                                ),
                                Container(
                                  color: Colors.black.withValues(alpha: 0.2),
                                ),
                              ],
                            )
                          : _fallbackIcon(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.accentLight,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(
                      data.category,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.accent,
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

  Widget _fallbackIcon() => Container(
        color: AppColors.primary,
        child:
            const Icon(Icons.explore_outlined, color: Colors.white, size: 60),
      );
}

// ─── Info Card ─────────────────────────────────────────────────────────────

class _InfoCard extends StatelessWidget {
  final VehicleDetailArgs data;
  const _InfoCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            size: 14, color: AppColors.textMuted),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            data.subtitle,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E8),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: const Color(0xFFFFD878).withValues(alpha: 0.5)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        color: Color(0xFFFFB800), size: 16),
                    const SizedBox(width: 4),
                    Text(
                      data.rating.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF8A6A00),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(height: 1, color: AppColors.border),
          const SizedBox(height: 14),
          Row(
            children: [
              _QuickStat(Icons.access_time_outlined, data.duration, 'Durasi'),
              _divider(),
              _QuickStat(Icons.event_seat_outlined, data.capacity, 'Kapasitas'),
              _divider(),
              const _QuickStat(Icons.wifi_outlined, 'WiFi', 'Fasilitas'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _divider() => Container(
        width: 1,
        height: 36,
        color: AppColors.border,
        margin: const EdgeInsets.symmetric(horizontal: 16),
      );
}

class _QuickStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  const _QuickStat(this.icon, this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(height: 4),
          Text(value,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary)),
          Text(label,
              style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
        ],
      ),
    );
  }
}

// ─── Specs Card ─────────────────────────────────────────────────────────────

class _SpecsCard extends StatelessWidget {
  final List<VehicleSpec> specs;
  const _SpecsCard({required this.specs});

  @override
  Widget build(BuildContext context) {
    if (specs.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.settings_outlined,
                    color: AppColors.primary, size: 17),
              ),
              const SizedBox(width: 10),
              const Text('Spesifikasi',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary)),
            ],
          ),
          const SizedBox(height: 14),
          ...specs.map((s) => _SpecRow(label: s.label, value: s.value)),
        ],
      ),
    );
  }
}

class _SpecRow extends StatelessWidget {
  final String label;
  final String value;
  const _SpecRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(label,
                style:
                    const TextStyle(fontSize: 13, color: AppColors.textMuted)),
          ),
          Container(width: 1, height: 14, color: AppColors.border),
          const SizedBox(width: 14),
          Text(value,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}

// ─── Facilities Card ────────────────────────────────────────────────────────

class _FacilitiesCard extends StatelessWidget {
  final List<VehicleFacility> facilities;
  const _FacilitiesCard({required this.facilities});

  @override
  Widget build(BuildContext context) {
    // Jika tidak ada data dari parent, gunakan default facilities
    final displayFacilities = facilities.isEmpty
        ? const [
            VehicleFacility(Icons.ac_unit_outlined, 'Full AC'),
            VehicleFacility(Icons.wifi_outlined, 'WiFi'),
            VehicleFacility(Icons.wc_outlined, 'Toilet'),
            VehicleFacility(Icons.power_outlined, 'Charging'),
            VehicleFacility(Icons.food_bank_outlined, 'Snack Box'),
            VehicleFacility(Icons.luggage_outlined, 'Bagasi'),
          ]
        : facilities;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.star_outline_rounded,
                    color: AppColors.primary, size: 17),
              ),
              const SizedBox(width: 10),
              const Text('Fasilitas',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary)),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: displayFacilities
                .map((f) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 7),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.15)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(f.icon, size: 14, color: AppColors.primary),
                          const SizedBox(width: 6),
                          Text(f.label,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary)),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

// ─── Schedule Card ──────────────────────────────────────────────────────────

class _ScheduleCard extends StatelessWidget {
  final VehicleSchedule schedule;
  const _ScheduleCard({required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E3D32), Color(0xFF2A5244)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Jadwal Keberangkatan',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
          const SizedBox(height: 14),
          Row(
            children: [
              _TimeBlock(
                schedule.fromCity,
                schedule.fromTime,
                schedule.fromTerminal,
                isLeft: true,
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 1.5,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0.2),
                            Colors.white.withValues(alpha: 0.6),
                            Colors.white.withValues(alpha: 0.2),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        schedule.travelTime,
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.white.withValues(alpha: 0.8),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              _TimeBlock(
                schedule.toCity,
                schedule.toTime,
                schedule.toTerminal,
                isLeft: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimeBlock extends StatelessWidget {
  final String city;
  final String time;
  final String terminal;
  final bool isLeft;
  const _TimeBlock(this.city, this.time, this.terminal, {required this.isLeft});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(city,
            style: TextStyle(
                fontSize: 11,
                color: Colors.white.withValues(alpha: 0.65),
                fontWeight: FontWeight.w500)),
        Text(time,
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.5)),
        Text(terminal,
            style: TextStyle(
                fontSize: 10, color: Colors.white.withValues(alpha: 0.55)),
            textAlign: isLeft ? TextAlign.left : TextAlign.right),
      ],
    );
  }
}

// ─── Bottom Bar ─────────────────────────────────────────────────────────────

class _BottomBar extends StatelessWidget {
  final String price;
  final VehicleDetailArgs? fullData;
  const _BottomBar({required this.price, this.fullData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 28),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(top: BorderSide(color: AppColors.border)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Harga/kursi',
                  style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
              Text(price,
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.accent,
                      letterSpacing: -0.5)),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: GestureDetector(
              onTap: () {
                final d = fullData;
                if (d != null) {
                  Navigator.of(context).pushNamed(
                    AppRoutes.booking,
                    arguments: BookingArgs(
                      title: d.title,
                      subtitle: d.subtitle,
                      price: d.price,
                      duration: d.duration,
                      capacity: d.capacity,
                      imageUrl: d.imageUrl,
                      category: d.category,
                    ),
                  );
                }
              },
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Color(0xFF9B7A35), Color(0xFF7B5E2A)]),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7B5E2A).withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text('Pesan Sekarang',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

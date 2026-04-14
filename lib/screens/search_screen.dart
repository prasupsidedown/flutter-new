import 'package:flutter/material.dart';
import '../app_theme.dart';

/// Screen 3 — Pencarian & Hasil Kendaraan
/// Berdasarkan Body-2.svg: header pencarian, daftar item dengan panah kanan,
/// filter chip, card hasil pencarian.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int _selectedFilter = 0;
  final _filters = ['Semua', 'Bus', 'Travel', 'Kereta', 'Pesawat'];

  final _results = [
    {
      'title': 'Bus Executive Hino',
      'route': 'Surabaya → Jakarta',
      'time': '07.00 - 17.00',
      'price': 'Rp 350.000',
      'rating': '4.8',
      'seats': '12',
      'type': 'Bus',
    },
    {
      'title': 'Travel Premium Door-to-Door',
      'route': 'Surabaya → Malang',
      'time': '08.00 - 11.00',
      'price': 'Rp 150.000',
      'rating': '4.9',
      'seats': '4',
      'type': 'Travel',
    },
    {
      'title': 'Kereta Eksekutif Argo',
      'route': 'Surabaya → Yogyakarta',
      'time': '09.00 - 14.30',
      'price': 'Rp 280.000',
      'rating': '4.7',
      'seats': '24',
      'type': 'Kereta',
    },
    {
      'title': 'Bus Patas AC Sumber Kencono',
      'route': 'Surabaya → Solo',
      'time': '06.30 - 10.30',
      'price': 'Rp 75.000',
      'rating': '4.5',
      'seats': '18',
      'type': 'Bus',
    },
    {
      'title': 'Travel Resmi Cipaganti',
      'route': 'Surabaya → Bandung',
      'time': '20.00 - 07.00',
      'price': 'Rp 320.000',
      'rating': '4.6',
      'seats': '6',
      'type': 'Travel',
    },
  ];

  List<Map<String, String>> get _filtered {
    if (_selectedFilter == 0) return _results.cast<Map<String, String>>();
    return _results
        .where((r) => r['type'] == _filters[_selectedFilter])
        .toList()
        .cast<Map<String, String>>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildSearchBar(),
            _buildFilterChips(),
            _buildResultHeader(),
            Expanded(child: _buildResultList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          const Text(
            'Cari Kendaraan',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.tune, color: AppColors.primary, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppColors.textMuted, size: 20),
          const SizedBox(width: 10),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Surabaya → Jakarta, 25 Jan',
                hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 14),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text('Cari', style: TextStyle(color: Colors.white, fontSize: 13)),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final selected = _selectedFilter == i;
          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: selected ? AppColors.accent : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selected ? AppColors.accent : AppColors.cardBorder,
                ),
              ),
              child: Text(
                _filters[i],
                style: TextStyle(
                  color: selected ? Colors.white : AppColors.textSecondary,
                  fontSize: 13,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildResultHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Row(
        children: [
          Text(
            '${_filtered.length} hasil ditemukan',
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          const Icon(Icons.sort, color: AppColors.textSecondary, size: 18),
          const SizedBox(width: 4),
          const Text('Urutkan', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildResultList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: _filtered.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, i) => _buildResultCard(_filtered[i], context),
    );
  }

  Widget _buildResultCard(Map<String, String> item, BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/detail'),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.directions_bus, color: AppColors.primary, size: 28),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title']!,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      const Icon(Icons.route_outlined, size: 12, color: AppColors.textMuted),
                      const SizedBox(width: 2),
                      Text(
                        item['route']!,
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item['time']!,
                    style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.accentLight.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          item['price']!,
                          style: const TextStyle(
                            color: AppColors.accent,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.star, size: 12, color: AppColors.accentLight),
                      const SizedBox(width: 2),
                      Text(
                        item['rating']!,
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                      ),
                      const Spacer(),
                      Text(
                        '${item['seats']} kursi',
                        style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}

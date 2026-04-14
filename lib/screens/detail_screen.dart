import 'package:flutter/material.dart';
import '../app_theme.dart';

/// Screen 2 — Detail Kendaraan / Produk
/// Berdasarkan Body-1.svg: gambar besar di atas, card info, konten deskripsi
/// dalam latar hijau gelap, tombol aksi hijau di bawah.
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                _buildSliverAppBar(context),
                SliverToBoxAdapter(child: _buildContent(context)),
              ],
            ),
          ),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 240,
      pinned: true,
      backgroundColor: AppColors.background,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
              ),
            ],
          ),
          child: const Icon(Icons.arrow_back, color: AppColors.primary, size: 20),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.share_outlined, color: AppColors.primary, size: 20),
            onPressed: () {},
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: AppColors.surface,
          child: const Center(
            child: Icon(Icons.directions_bus, size: 120, color: AppColors.primary),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoCard(),
        const SizedBox(height: 16),
        _buildSpecCard(),
        const SizedBox(height: 16),
        _buildDarkSection(),
        const SizedBox(height: 16),
        _buildSmallCards(context),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bus Executive Class',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 14, color: AppColors.textSecondary),
                        const SizedBox(width: 2),
                        const Text(
                          'Surabaya → Jakarta',
                          style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.accentLight.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: AppColors.accent, size: 14),
                    SizedBox(width: 4),
                    Text(
                      '4.8',
                      style: TextStyle(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.cardBorder),
          const SizedBox(height: 12),
          Row(
            children: [
              _infoChip(Icons.access_time_outlined, '8 Jam'),
              const SizedBox(width: 12),
              _infoChip(Icons.event_seat_outlined, '40 Kursi'),
              const SizedBox(width: 12),
              _infoChip(Icons.wifi_outlined, 'WiFi'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoChip(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.primary),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildSpecCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Spesifikasi',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          _specRow('Armada', 'Hino RN 285'),
          _specRow('Kelas', 'Executive'),
          _specRow('AC', 'Double Blower'),
          _specRow('Toilet', 'Tersedia'),
          _specRow('Kursi', 'Reclining 160°'),
          Container(
            margin: const EdgeInsets.only(top: 12),
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: AppColors.surface,
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.7,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Kenyamanan 70%',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _specRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDarkSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Deskripsi Perjalanan',
            style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          const Text(
            'Bus Executive Class dengan fasilitas lengkap untuk perjalanan nyaman Surabaya–Jakarta. Dilengkapi kursi reclining, AC ganda, WiFi, dan stopover di rest area. Sopir berpengalaman dengan rekam jejak keselamatan terbaik.',
            style: TextStyle(color: Color(0xFF809C8D), fontSize: 13, height: 1.6),
          ),
          const SizedBox(height: 16),
          // mini tags inside dark card
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ['Aman', 'Nyaman', 'Tepat Waktu', 'Bersih'].map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Text(
                  tag,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallCards(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(child: _smallCard('Jadwal Berangkat', '07.00 WIB', Icons.schedule)),
          const SizedBox(width: 12),
          Expanded(child: _smallCard('Jadwal Tiba', '17.00 WIB', Icons.flag_outlined)),
        ],
      ),
    );
  }

  Widget _smallCard(String label, String value, IconData icon) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.accent, size: 20),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Harga/kursi',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
              const SizedBox(height: 2),
              const Text(
                'Rp 350.000',
                style: TextStyle(
                  color: AppColors.accent,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/booking'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    'Pesan Sekarang',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

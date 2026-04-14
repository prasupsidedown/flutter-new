import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav.dart';

class HomeMainScreen extends StatelessWidget {
  const HomeMainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F3),
      appBar: const MobiAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero card with dark green background
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D4A3E),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  children: [
                    // Decorative circle
                    Positioned(
                      right: -20,
                      top: -20,
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.05),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xFF7B5E2A).withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color:
                                      const Color(0xFF7B5E2A).withOpacity(0.4)),
                            ),
                            child: const Text(
                              '🌿 Eksplorasi Nusantara',
                              style: TextStyle(
                                  color: Color(0xFFD4A44C),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Temukan\nDestinasi Impian',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF7B5E2A),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                            ),
                            child: const Text('Jelajahi Sekarang',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Category icons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildCategoryItem(Icons.beach_access_outlined, 'Pantai'),
                  _buildCategoryItem(Icons.landscape_outlined, 'Pegunungan'),
                  _buildCategoryItem(Icons.account_balance_outlined, 'Budaya'),
                  _buildCategoryItem(Icons.restaurant_outlined, 'Kuliner'),
                  _buildCategoryItem(Icons.more_horiz, 'Lainnya'),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Populer section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Destinasi Populer',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A1A)),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Lihat Semua',
                        style:
                            TextStyle(color: Color(0xFF7B5E2A), fontSize: 13)),
                  ),
                ],
              ),
            ),

            // Horizontal destination cards
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildDestCard('Raja Ampat', 'Papua Barat', '4.9', '★'),
                  _buildDestCard('Labuan Bajo', 'NTT', '4.8', '★'),
                  _buildDestCard('Borobudur', 'Jawa Tengah', '4.7', '★'),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Tur Terpilih section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tur Terpilih',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A1A)),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Lihat Semua',
                        style:
                            TextStyle(color: Color(0xFF7B5E2A), fontSize: 13)),
                  ),
                ],
              ),
            ),

            // Tour list cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildTourCard(context, '3D2N Raja Ampat Adventure',
                      'Rp 3.200.000', '3 Hari 2 Malam', '12 Peserta'),
                  const SizedBox(height: 12),
                  _buildTourCard(context, 'Komodo Island Explorer',
                      'Rp 2.500.000', '2 Hari 1 Malam', '8 Peserta'),
                  const SizedBox(height: 12),
                  _buildTourCard(context, 'Bali Heritage Trail', 'Rp 1.800.000',
                      '1 Hari', '20 Peserta'),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: const MobiBottomNav(currentIndex: 0),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE8DFC8), width: 1),
          ),
          child: Icon(icon, color: const Color(0xFF7B5E2A), size: 22),
        ),
        const SizedBox(height: 6),
        Text(label,
            style: const TextStyle(fontSize: 11, color: Color(0xFF5A5A4A))),
      ],
    );
  }

  Widget _buildDestCard(
      String name, String location, String rating, String star) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8DFC8), width: 1),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 110,
            decoration: BoxDecoration(
              color: const Color(0xFF2D4A3E).withOpacity(0.15),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            child: const Center(
                child: Icon(Icons.landscape_outlined,
                    color: Color(0xFF2D4A3E), size: 40)),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A))),
                const SizedBox(height: 3),
                Text(location,
                    style: const TextStyle(
                        fontSize: 11, color: Color(0xFF9E9E8E))),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(star,
                        style: const TextStyle(
                            fontSize: 11, color: Color(0xFFD4A44C))),
                    const SizedBox(width: 3),
                    Text(rating,
                        style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A1A1A))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTourCard(BuildContext context, String title, String price,
      String duration, String capacity) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8DFC8), width: 1),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xFF2D4A3E).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.tour_outlined,
                color: Color(0xFF2D4A3E), size: 30),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A))),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.access_time,
                        size: 12, color: Color(0xFF9E9E8E)),
                    const SizedBox(width: 4),
                    Text(duration,
                        style: const TextStyle(
                            fontSize: 12, color: Color(0xFF9E9E8E))),
                    const SizedBox(width: 10),
                    const Icon(Icons.people_outline,
                        size: 12, color: Color(0xFF9E9E8E)),
                    const SizedBox(width: 4),
                    Text(capacity,
                        style: const TextStyle(
                            fontSize: 12, color: Color(0xFF9E9E8E))),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(price,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF7B5E2A))),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/agent'),
                      child: const Text('Pesan →',
                          style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF7B5E2A),
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

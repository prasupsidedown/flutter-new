import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class Screen6 extends StatelessWidget {
  const Screen6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF9F1),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF1A3328),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Detail Produk',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A3328),
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.favorite_border,
                    color: Color(0xFF1A3328),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.share_outlined,
                    color: Color(0xFF1A3328),
                    size: 24,
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Hero Image
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      height: 260,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A3328),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Icon(
                              Icons.spa_outlined,
                              color: Colors.white.withOpacity(0.3),
                              size: 100,
                            ),
                          ),
                          Positioned(
                            top: 16,
                            left: 16,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF805600),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Terlaris',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Product Info
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
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
                                      'Bayangan Mineral SPF 30',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF1A3328),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'Perlindungan & Perawatan',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF809C8D),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  const Text(
                                    'Rp 245.000',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1A3328),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Color(0xFFFFB800),
                                        size: 14,
                                      ),
                                      const SizedBox(width: 3),
                                      const Text(
                                        '4.8 (2.1k)',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF424844),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Volume variants
                          const Text(
                            'Pilih Ukuran',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A3328),
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildVariantRow(),
                          const SizedBox(height: 24),

                          // Description
                          const Text(
                            'Deskripsi Produk',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A3328),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Formula mineral kami dirancang khusus untuk melindungi kulit dari paparan sinar UV-A dan UV-B sekaligus memberikan nutrisi yang dibutuhkan kulit. Cocok untuk semua jenis kulit, termasuk kulit sensitif.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF424844),
                              height: 1.7,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Key Ingredients
                          const Text(
                            'Bahan Utama',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A3328),
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildIngredients(),
                          const SizedBox(height: 24),

                          // Reviews
                          _buildReviewsSection(),
                          const SizedBox(height: 24),

                          // Location/GiganCity section
                          _buildLocationCard(context),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom CTA + Nav
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Add to cart bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            color: const Color(0xFFFEF9F1),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF1A3328),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Color(0xFF1A3328),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/screen8'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A3328),
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Tambah ke Keranjang',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const MobiBottomNav(currentIndex: 1),
        ],
      ),
    );
  }

  Widget _buildVariantRow() {
    final variants = ['30ml', '50ml', '100ml'];
    return Row(
      children: variants.map((v) {
        final isSelected = v == '50ml';
        return Container(
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF1A3328) : Colors.transparent,
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF1A3328)
                  : const Color(0xFFD0DDD5),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            v,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF424844),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildIngredients() {
    final ingredients = [
      {'name': 'Zinc Oxide', 'benefit': 'SPF alami'},
      {'name': 'Niacinamide', 'benefit': 'Pencerah kulit'},
      {'name': 'Hyaluronic Acid', 'benefit': 'Hidrasi'},
    ];
    return Row(
      children: ingredients.map((i) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1A3328).withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  i['name']!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A3328),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  i['benefit']!,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF809C8D),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Ulasan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A3328),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Lihat Semua',
                style: TextStyle(color: Color(0xFF809C8D)),
              ),
            ),
          ],
        ),
        _buildReviewCard(
          'Sari W.',
          '5',
          'Produknya bagus banget! Kulit jadi lebih lembab dan cerah.',
        ),
        _buildReviewCard(
          'Dinda M.',
          '4',
          'Teksturnya ringan, cepat meresap. Suka banget.',
        ),
      ],
    );
  }

  Widget _buildReviewCard(String name, String rating, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1A3328).withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: const Color(0xFF1A3328).withOpacity(0.1),
                child: Text(
                  name[0],
                  style: const TextStyle(
                    color: Color(0xFF1A3328),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A3328),
                ),
              ),
              const Spacer(),
              Row(
                children: List.generate(
                  int.parse(rating),
                  (_) => const Icon(
                    Icons.star,
                    color: Color(0xFFFFB800),
                    size: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF424844),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/screen7'),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A3328),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'GiganCity - Jakarta Selatan',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Tersedia di toko terdekat',
                    style: TextStyle(color: Color(0xFF809C8D), fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }
}

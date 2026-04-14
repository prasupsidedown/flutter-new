import 'package:flutter/material.dart';

class Screen5 extends StatelessWidget {
  const Screen5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF9F1),
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.arrow_back, color: Color(0xFF1A3328), size: 24),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Pembayang',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A3328),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF1A3328),
                    ),
                    child: const Icon(Icons.person, color: Colors.white, size: 18),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category tabs
                    _buildCategoryTabs(),
                    const SizedBox(height: 24),

                    // Section title
                    const Text(
                      'Rekomendasi',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A3328),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Product cards
                    _buildProductCard(
                      context,
                      title: 'Bayangan Mineral SPF 30',
                      subtitle: 'Perlindungan & Perawatan',
                      price: 'Rp 245.000',
                      rating: '4.8',
                      tag: 'Terlaris',
                      tagColor: const Color(0xFF1A3328),
                    ),
                    const SizedBox(height: 16),
                    _buildProductCard(
                      context,
                      title: 'Serum Vitamin C 20%',
                      subtitle: 'Pencerahan & Anti-Aging',
                      price: 'Rp 189.000',
                      rating: '4.6',
                      tag: 'Baru',
                      tagColor: const Color(0xFF805600),
                    ),
                    const SizedBox(height: 16),
                    _buildProductCard(
                      context,
                      title: 'Moisturizer Hyaluronic Acid',
                      subtitle: 'Hidrasi & Kelembaban',
                      price: 'Rp 165.000',
                      rating: '4.7',
                      tag: 'Promo',
                      tagColor: const Color(0xFF2E6B4F),
                    ),
                    const SizedBox(height: 16),
                    _buildProductCard(
                      context,
                      title: 'Toner Niacinamide 10%',
                      subtitle: 'Pori-pori & Tekstur',
                      price: 'Rp 135.000',
                      rating: '4.5',
                      tag: '',
                      tagColor: Colors.transparent,
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context, currentIndex: 0),
    );
  }

  Widget _buildCategoryTabs() {
    final tabs = ['Semua', 'Wajah', 'Tubuh', 'Rambut', 'Bibir'];
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = index == 0;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF1A3328) : const Color(0xFFE8EDE9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              tabs[index],
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF424844),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String price,
    required String rating,
    required String tag,
    required Color tagColor,
  }) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/screen6'),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1A3328).withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image placeholder
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFF1A3328).withOpacity(0.08),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              child: const Icon(Icons.spa_outlined, color: Color(0xFF1A3328), size: 36),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (tag.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        margin: const EdgeInsets.only(bottom: 6),
                        decoration: BoxDecoration(
                          color: tagColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(
                            color: tagColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A3328),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF809C8D),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A3328),
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.star, color: Color(0xFFFFB800), size: 14),
                        const SizedBox(width: 3),
                        Text(
                          rating,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF424844),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildBottomBar(BuildContext context, {required int currentIndex}) {
  final items = [
    {'icon': Icons.home_outlined, 'label': 'Beranda', 'route': '/screen5'},
    {'icon': Icons.search_outlined, 'label': 'Cari', 'route': '/screen6'},
    {'icon': Icons.favorite_border, 'label': 'Favorit', 'route': '/screen7'},
    {'icon': Icons.shopping_bag_outlined, 'label': 'Keranjang', 'route': '/screen8'},
    {'icon': Icons.person_outline, 'label': 'Profil', 'route': '/screen9'},
  ];

  return Container(
    height: 80,
    decoration: BoxDecoration(
      color: const Color(0xFF1A3328),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(28),
        topRight: Radius.circular(28),
      ),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF1A3328).withOpacity(0.3),
          blurRadius: 20,
          offset: const Offset(0, -4),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(items.length, (index) {
        final isActive = index == currentIndex;
        return GestureDetector(
          onTap: () {
            if (!isActive) {
              Navigator.pushNamed(context, items[index]['route'] as String);
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                items[index]['icon'] as IconData,
                color: isActive ? Colors.white : Colors.white.withOpacity(0.4),
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                items[index]['label'] as String,
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.white.withOpacity(0.4),
                  fontSize: 10,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              if (isActive)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        );
      }),
    ),
  );
}

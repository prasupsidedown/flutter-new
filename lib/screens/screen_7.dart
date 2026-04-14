import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class Screen7 extends StatelessWidget {
  const Screen7({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF9F1),
      body: Column(
        children: [
          // Dark Header
          Container(
            color: const Color(0xFF1A3328),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                  bottom: 24,
                  top: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'Temukan Toko',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.filter_list,
                          color: Colors.white,
                          size: 24,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Location header
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Color(0xFF809C8D),
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'GiganCity, Jakarta Selatan',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Search bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            color: Color(0xFF809C8D),
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: TextField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Cari lokasi toko...',
                                hintStyle: TextStyle(
                                  color: Color(0xFF809C8D),
                                  fontSize: 14,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Map placeholder
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A3328).withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.map_outlined,
                            color: Color(0xFF1A3328),
                            size: 48,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Peta Lokasi',
                            style: TextStyle(color: Color(0xFF809C8D)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'Toko Terdekat',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A3328),
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildStoreCard(
                    context,
                    name: 'GiganCity Jakarta Selatan',
                    address: 'Jl. TB Simatupang No. 17, Jakarta',
                    distance: '1.2 km',
                    status: 'Buka',
                    statusColor: const Color(0xFF2E6B4F),
                    hours: '09:00 - 22:00',
                    isHighlighted: true,
                  ),
                  const SizedBox(height: 12),
                  _buildStoreCard(
                    context,
                    name: 'GiganCity Pondok Indah',
                    address: 'Jl. Metro Pondok Indah, Jakarta',
                    distance: '3.5 km',
                    status: 'Buka',
                    statusColor: const Color(0xFF2E6B4F),
                    hours: '10:00 - 22:00',
                    isHighlighted: false,
                  ),
                  const SizedBox(height: 12),
                  _buildStoreCard(
                    context,
                    name: 'GiganCity Senayan City',
                    address: 'Jl. Asia Afrika Lot 19, Jakarta',
                    distance: '5.1 km',
                    status: 'Tutup',
                    statusColor: const Color(0xFFE53E3E),
                    hours: '10:00 - 22:00',
                    isHighlighted: false,
                  ),
                  const SizedBox(height: 12),
                  _buildStoreCard(
                    context,
                    name: 'GiganCity Grand Indonesia',
                    address: 'Jl. MH Thamrin No. 1, Jakarta',
                    distance: '8.3 km',
                    status: 'Buka',
                    statusColor: const Color(0xFF2E6B4F),
                    hours: '10:00 - 22:00',
                    isHighlighted: false,
                  ),
                  const SizedBox(height: 12),
                  _buildStoreCard(
                    context,
                    name: 'GiganCity Kelapa Gading',
                    address: 'Jl. Boulevard Barat Raya, Jakarta',
                    distance: '11.7 km',
                    status: 'Buka',
                    statusColor: const Color(0xFF2E6B4F),
                    hours: '09:00 - 21:00',
                    isHighlighted: false,
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const MobiBottomNav(currentIndex: 2),
    );
  }

  Widget _buildStoreCard(
    BuildContext context, {
    required String name,
    required String address,
    required String distance,
    required String status,
    required Color statusColor,
    required String hours,
    required bool isHighlighted,
  }) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/screen8'),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isHighlighted ? const Color(0xFF1A3328) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: isHighlighted
              ? null
              : Border.all(color: const Color(0xFFE8EDE9), width: 1),
          boxShadow: [
            BoxShadow(
              color: const Color(
                0xFF1A3328,
              ).withOpacity(isHighlighted ? 0.12 : 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color:
                        (isHighlighted ? Colors.white : const Color(0xFF1A3328))
                            .withOpacity(isHighlighted ? 0.15 : 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.store_outlined,
                    color: isHighlighted
                        ? Colors.white
                        : const Color(0xFF1A3328),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: isHighlighted
                              ? Colors.white
                              : const Color(0xFF1A3328),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        address,
                        style: TextStyle(
                          fontSize: 12,
                          color: isHighlighted
                              ? Colors.white.withOpacity(0.6)
                              : const Color(0xFF809C8D),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Divider(
              color: isHighlighted
                  ? Colors.white.withOpacity(0.1)
                  : const Color(0xFFE8EDE9),
              height: 1,
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: isHighlighted
                      ? Colors.white.withOpacity(0.6)
                      : const Color(0xFF809C8D),
                  size: 14,
                ),
                const SizedBox(width: 6),
                Text(
                  hours,
                  style: TextStyle(
                    fontSize: 12,
                    color: isHighlighted
                        ? Colors.white.withOpacity(0.6)
                        : const Color(0xFF809C8D),
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.directions_outlined,
                  color: isHighlighted ? Colors.white : const Color(0xFF1A3328),
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  distance,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isHighlighted
                        ? Colors.white
                        : const Color(0xFF1A3328),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

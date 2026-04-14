import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav.dart';

class AgentScreen extends StatelessWidget {
  const AgentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F3),
      appBar: const MobiAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header banner
            Container(
              width: double.infinity,
              color: const Color(0xFF2D4A3E),
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mitra Agen MobiTravel',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Temukan agen terpercaya untuk perjalanan terbaik Anda.',
                    style: TextStyle(fontSize: 13, color: Color(0xFF9EC2B0), height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  // Search bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Color(0xFF9EC2B0), size: 18),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: TextField(
                            style: TextStyle(color: Colors.white, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: 'Cari agen atau destinasi...',
                              hintStyle: TextStyle(color: Color(0xFF9EC2B0), fontSize: 14),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Register as agent CTA
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0EBE0),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE8DFC8)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xFF7B5E2A),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.star, color: Colors.white, size: 18),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Daftarkan Usaha Tur Anda',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF1A1A1A)),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Jangkau ribuan penjelajah setiap hari.',
                            style: TextStyle(fontSize: 12, color: Color(0xFF5A5A4A)),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, color: Color(0xFF7B5E2A), size: 14),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Agent list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                'Agen Terverifikasi',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF1A1A1A)),
              ),
            ),
            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildAgentCard(
                    context,
                    name: 'Nusa Indah Travel',
                    location: 'Bali, Indonesia',
                    rating: '4.9',
                    tours: '42 Tur',
                    specialty: 'Budaya & Alam',
                    isVerified: true,
                    isTopPick: true,
                  ),
                  const SizedBox(height: 12),
                  _buildAgentCard(
                    context,
                    name: 'Raja Explorer',
                    location: 'Raja Ampat, Papua',
                    rating: '4.8',
                    tours: '18 Tur',
                    specialty: 'Diving & Snorkeling',
                    isVerified: true,
                    isTopPick: false,
                  ),
                  const SizedBox(height: 12),
                  _buildAgentCard(
                    context,
                    name: 'Jawa Tengah Heritage',
                    location: 'Yogyakarta, Jawa',
                    rating: '4.7',
                    tours: '31 Tur',
                    specialty: 'Sejarah & Kuliner',
                    isVerified: true,
                    isTopPick: false,
                  ),
                  const SizedBox(height: 12),
                  _buildAgentCard(
                    context,
                    name: 'Lombok Surf & Trek',
                    location: 'Lombok, NTB',
                    rating: '4.6',
                    tours: '24 Tur',
                    specialty: 'Surfing & Hiking',
                    isVerified: false,
                    isTopPick: false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: const MobiBottomNav(currentIndex: 1),
    );
  }

  Widget _buildAgentCard(
    BuildContext context, {
    required String name,
    required String location,
    required String rating,
    required String tours,
    required String specialty,
    required bool isVerified,
    required bool isTopPick,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8DFC8)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D4A3E).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.store_outlined, color: Color(0xFF2D4A3E), size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF1A1A1A))),
                        if (isVerified) ...[
                          const SizedBox(width: 6),
                          const Icon(Icons.verified, color: Color(0xFF7B5E2A), size: 14),
                        ],
                        if (isTopPick) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD4A44C).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text('Top Pick', style: TextStyle(fontSize: 10, color: Color(0xFF7B5E2A), fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 12, color: Color(0xFF9E9E8E)),
                        const SizedBox(width: 3),
                        Text(location, style: const TextStyle(fontSize: 12, color: Color(0xFF9E9E8E))),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const Text('⭐', style: TextStyle(fontSize: 13)),
                      const SizedBox(width: 3),
                      Text(rating, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF1A1A1A))),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(tours, style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E8E))),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0EBE0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(specialty, style: const TextStyle(fontSize: 12, color: Color(0xFF7B5E2A))),
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: () => Navigator.pushNamed(context, '/history'),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF7B5E2A)),
                  foregroundColor: const Color(0xFF7B5E2A),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('Lihat Tur', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int _selectedFilter = 0;
  final List<String> _filters = ['Semua', 'Aktif', 'Selesai', 'Dibatalkan'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F3),
      appBar: const MobiAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Riwayat Perjalanan',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Color(0xFF1A1A1A)),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Semua petualangan Anda tercatat di sini.',
                  style: TextStyle(fontSize: 13, color: Color(0xFF9E9E8E)),
                ),
                const SizedBox(height: 16),
                // Filter chips
                SizedBox(
                  height: 36,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _filters.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final isSelected = index == _selectedFilter;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedFilter = index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF2D4A3E) : const Color(0xFFF0EBE0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _filters[index],
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: isSelected ? Colors.white : const Color(0xFF5A5A4A),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(height: 1, color: Color(0xFFE8DFC8)),
              ],
            ),
          ),

          // History items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildHistoryItem(
                  context,
                  tourName: '3D2N Raja Ampat Adventure',
                  agentName: 'Raja Explorer',
                  date: '12–14 Jan 2024',
                  price: 'Rp 3.200.000',
                  status: 'Selesai',
                  statusColor: const Color(0xFF2D8A4E),
                  statusBg: const Color(0xFFE8F5EE),
                ),
                const SizedBox(height: 12),
                _buildHistoryItem(
                  context,
                  tourName: 'Komodo Island Explorer',
                  agentName: 'Nusa Indah Travel',
                  date: '5–6 Mar 2024',
                  price: 'Rp 2.500.000',
                  status: 'Aktif',
                  statusColor: const Color(0xFF7B5E2A),
                  statusBg: const Color(0xFFF5EBD8),
                ),
                const SizedBox(height: 12),
                _buildHistoryItem(
                  context,
                  tourName: 'Bali Heritage Trail',
                  agentName: 'Nusa Indah Travel',
                  date: '20 Feb 2024',
                  price: 'Rp 1.800.000',
                  status: 'Selesai',
                  statusColor: const Color(0xFF2D8A4E),
                  statusBg: const Color(0xFFE8F5EE),
                ),
                const SizedBox(height: 12),
                _buildHistoryItem(
                  context,
                  tourName: 'Lombok Surf & Trek',
                  agentName: 'Lombok Surf & Trek',
                  date: '28 Jan 2024',
                  price: 'Rp 1.500.000',
                  status: 'Dibatalkan',
                  statusColor: const Color(0xFFB94A3A),
                  statusBg: const Color(0xFFFAECEA),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const MobiBottomNav(currentIndex: 2),
    );
  }

  Widget _buildHistoryItem(
    BuildContext context, {
    required String tourName,
    required String agentName,
    required String date,
    required String price,
    required String status,
    required Color statusColor,
    required Color statusBg,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: statusColor),
                ),
              ),
              const Spacer(),
              Text(date, style: const TextStyle(fontSize: 12, color: Color(0xFF9E9E8E))),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D4A3E).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.tour_outlined, color: Color(0xFF2D4A3E), size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tourName, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1A1A1A))),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Icon(Icons.store_outlined, size: 12, color: Color(0xFF9E9E8E)),
                        const SizedBox(width: 4),
                        Text(agentName, style: const TextStyle(fontSize: 12, color: Color(0xFF9E9E8E))),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFE8DFC8)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Pembayaran', style: TextStyle(fontSize: 11, color: Color(0xFF9E9E8E))),
                  const SizedBox(height: 2),
                  Text(price, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF7B5E2A))),
                ],
              ),
              if (status == 'Selesai')
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF7B5E2A)),
                    foregroundColor: const Color(0xFF7B5E2A),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text('Pesan Lagi', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                )
              else if (status == 'Aktif')
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/account'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D4A3E),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text('Detail', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

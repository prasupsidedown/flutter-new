import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class Screen9 extends StatelessWidget {
  const Screen9({super.key});

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
                    'Profil Saya',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A3328),
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.settings_outlined,
                    color: Color(0xFF1A3328),
                    size: 24,
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    // Profile Hero Card
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A3328),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          // Avatar + info
                          Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 72,
                                    height: 72,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withOpacity(0.15),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.3),
                                        width: 2,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 36,
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      width: 22,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF805600),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: const Color(0xFF1A3328),
                                          width: 2,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                        size: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Sarah Amelia',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'sarah.amelia@email.com',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF809C8D),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xFF805600,
                                        ).withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: const Color(
                                            0xFF805600,
                                          ).withOpacity(0.4),
                                        ),
                                      ),
                                      child: const Text(
                                        '✦ Member Premium',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Color(0xFFFFB800),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // Stats row
                          Row(
                            children: [
                              _buildStatItem('28', 'Pesanan'),
                              _buildStatDivider(),
                              _buildStatItem('12', 'Favorit'),
                              _buildStatDivider(),
                              _buildStatItem('4.8k', 'Poin'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Points / Reward Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF805600), Color(0xFFB07A00)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Poin Reward',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '4.800 Poin',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Tukarkan sebelum kadaluarsa',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF805600),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                            ),
                            child: const Text(
                              'Tukarkan',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Order History section
                    _buildSectionHeader('Pesanan Saya'),
                    const SizedBox(height: 12),
                    _buildOrderStatusRow(context),
                    const SizedBox(height: 24),

                    // Account Settings
                    _buildSectionHeader('Pengaturan Akun'),
                    const SizedBox(height: 12),
                    _buildSettingsGroup([
                      {
                        'icon': Icons.person_outline,
                        'label': 'Edit Profil',
                        'route': null,
                      },
                      {
                        'icon': Icons.location_on_outlined,
                        'label': 'Alamat Saya',
                        'route': null,
                      },
                      {
                        'icon': Icons.credit_card_outlined,
                        'label': 'Metode Pembayaran',
                        'route': null,
                      },
                      {
                        'icon': Icons.notifications_outlined,
                        'label': 'Notifikasi',
                        'route': null,
                      },
                    ]),
                    const SizedBox(height: 16),

                    // Help
                    _buildSectionHeader('Bantuan'),
                    const SizedBox(height: 12),
                    _buildSettingsGroup([
                      {
                        'icon': Icons.help_outline,
                        'label': 'Pusat Bantuan',
                        'route': null,
                      },
                      {
                        'icon': Icons.chat_bubble_outline,
                        'label': 'Hubungi Kami',
                        'route': null,
                      },
                      {
                        'icon': Icons.star_outline,
                        'label': 'Beri Penilaian',
                        'route': null,
                      },
                    ]),
                    const SizedBox(height: 16),

                    // Logout
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.red.withOpacity(0.2)),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.logout, color: Colors.red),
                        title: const Text(
                          'Keluar',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.red,
                          size: 14,
                        ),
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MobiBottomNav(currentIndex: 3),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF809C8D)),
          ),
        ],
      ),
    );
  }

  Widget _buildStatDivider() {
    return Container(
      width: 1,
      height: 36,
      color: Colors.white.withOpacity(0.15),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1A3328),
        ),
      ),
    );
  }

  Widget _buildOrderStatusRow(BuildContext context) {
    final statuses = [
      {
        'icon': Icons.hourglass_empty_outlined,
        'label': 'Menunggu',
        'count': '2',
      },
      {'icon': Icons.local_shipping_outlined, 'label': 'Dikirim', 'count': '1'},
      {'icon': Icons.check_circle_outline, 'label': 'Selesai', 'count': '25'},
      {'icon': Icons.replay_outlined, 'label': 'Pengembalian', 'count': '0'},
    ];
    return Row(
      children: statuses.map((s) {
        return Expanded(
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/screen8'),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE8EDE9)),
              ),
              margin: const EdgeInsets.only(right: 8),
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Icon(
                        s['icon'] as IconData,
                        color: const Color(0xFF1A3328),
                        size: 26,
                      ),
                      if (s['count'] != '0')
                        Positioned(
                          top: -6,
                          right: -10,
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                              color: Color(0xFF1A3328),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              s['count']!.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    s['label']!.toString(),
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF424844),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSettingsGroup(List<Map<String, dynamic>> items) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1A3328).withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isLast = index == items.length - 1;
          return Column(
            children: [
              ListTile(
                leading: Icon(
                  item['icon'] as IconData,
                  color: const Color(0xFF1A3328),
                  size: 22,
                ),
                title: Text(
                  item['label'] as String,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1A3328),
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF809C8D),
                  size: 14,
                ),
                onTap: () {},
              ),
              if (!isLast)
                const Divider(height: 1, indent: 56, color: Color(0xFFE8EDE9)),
            ],
          );
        }),
      ),
    );
  }
}

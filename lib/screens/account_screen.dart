import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F3),
      appBar: const MobiAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile card
            Container(
              width: double.infinity,
              color: const Color(0xFF2D4A3E),
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 68,
                        height: 68,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.15),
                          border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
                        ),
                        child: const Icon(Icons.person, color: Colors.white, size: 34),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            color: const Color(0xFF7B5E2A),
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFF2D4A3E), width: 2),
                          ),
                          child: const Icon(Icons.edit, color: Colors.white, size: 10),
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
                          'Budi Santoso',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'budi.santoso@email.com',
                          style: TextStyle(fontSize: 13, color: Color(0xFF9EC2B0)),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF7B5E2A).withOpacity(0.25),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFF7B5E2A).withOpacity(0.4)),
                          ),
                          child: const Text(
                            '✦ Penjelajah Premium',
                            style: TextStyle(fontSize: 11, color: Color(0xFFD4A44C), fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Stats row
            Container(
              color: const Color(0xFF2D4A3E),
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
              child: Row(
                children: [
                  _buildStat('8', 'Perjalanan'),
                  _buildStatDivider(),
                  _buildStat('3', 'Destinasi'),
                  _buildStatDivider(),
                  _buildStat('1.2k', 'Poin'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Settings sections
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Akun Saya'),
                  const SizedBox(height: 10),
                  _buildSettingsGroup([
                    _buildSettingsItem(Icons.person_outline, 'Ubah Profil', () {}),
                    _buildSettingsItem(Icons.lock_outline, 'Ubah Kata Sandi', () {}),
                    _buildSettingsItem(Icons.credit_card_outlined, 'Metode Pembayaran', () {}),
                    _buildSettingsItem(Icons.location_on_outlined, 'Alamat Tersimpan', () {}),
                  ]),
                  const SizedBox(height: 20),

                  _buildSectionTitle('Perjalanan'),
                  const SizedBox(height: 10),
                  _buildSettingsGroup([
                    _buildSettingsItem(Icons.history_outlined, 'Riwayat Perjalanan', () => Navigator.pushNamed(context, '/history')),
                    _buildSettingsItem(Icons.favorite_border, 'Destinasi Favorit', () {}),
                    _buildSettingsItem(Icons.card_giftcard_outlined, 'Poin & Reward', () {}),
                  ]),
                  const SizedBox(height: 20),

                  _buildSectionTitle('Preferensi'),
                  const SizedBox(height: 10),
                  _buildSettingsGroup([
                    _buildSettingsItem(Icons.notifications_outlined, 'Notifikasi', () {}),
                    _buildSettingsItem(Icons.language_outlined, 'Bahasa', () {}),
                    _buildSettingsItem(Icons.dark_mode_outlined, 'Tampilan Gelap', () {}),
                  ]),
                  const SizedBox(height: 20),

                  _buildSectionTitle('Lainnya'),
                  const SizedBox(height: 10),
                  _buildSettingsGroup([
                    _buildSettingsItem(Icons.help_outline, 'Bantuan & FAQ', () {}),
                    _buildSettingsItem(Icons.privacy_tip_outlined, 'Kebijakan Privasi', () {}),
                    _buildSettingsItem(Icons.info_outline, 'Tentang MobiTravel', () {}),
                  ]),
                  const SizedBox(height: 16),

                  // Logout
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE8DFC8)),
                    ),
                    child: ListTile(
                      onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                      leading: const Icon(Icons.logout, color: Color(0xFFB94A3A), size: 20),
                      title: const Text(
                        'Keluar',
                        style: TextStyle(fontSize: 14, color: Color(0xFFB94A3A), fontWeight: FontWeight.w600),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFFB94A3A)),
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MobiBottomNav(currentIndex: 3),
    );
  }

  Widget _buildStat(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF9EC2B0))),
        ],
      ),
    );
  }

  Widget _buildStatDivider() {
    return Container(
      width: 1,
      height: 32,
      color: Colors.white.withOpacity(0.15),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF5A5A4A), letterSpacing: 0.5),
    );
  }

  Widget _buildSettingsGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8DFC8)),
      ),
      child: Column(
        children: List.generate(children.length, (index) {
          final isLast = index == children.length - 1;
          return Column(
            children: [
              children[index],
              if (!isLast) const Divider(height: 1, indent: 52, color: Color(0xFFE8DFC8)),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildSettingsItem(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: const Color(0xFF2D4A3E), size: 20),
      title: Text(label, style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A1A))),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF9E9E8E)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    );
  }
}

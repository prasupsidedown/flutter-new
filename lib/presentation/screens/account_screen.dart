import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../data/repositories/travel_repository.dart';
import '../../domain/entities/entities.dart';
import '../widgets/shared_widgets.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = TravelRepositoryImpl();
    final user = repo.getUserProfile();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        scrolledUnderElevation: 0,
        // Fixed: back button navigates to home
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Colors.white, size: 18),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.home, (r) => false);
            }
          },
        ),
        title: const Text(
          'Profil Saya',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined,
                color: Colors.white, size: 22),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _ProfileHeader(user: user),
            const SizedBox(height: 20),
            _StatsRow(user: user),
            const SizedBox(height: 20),

            // Sections
            _SettingsSection(
              title: 'Akun Saya',
              items: [
                _SettingsItem(
                    Icons.person_outline, 'Ubah Profil', () {}),
                _SettingsItem(
                    Icons.lock_outline, 'Ubah Kata Sandi', () {}),
                _SettingsItem(
                    Icons.credit_card_outlined, 'Metode Pembayaran', () {}),
                _SettingsItem(
                    Icons.location_on_outlined, 'Alamat Tersimpan', () {}),
              ],
            ),
            const SizedBox(height: 16),

            _SettingsSection(
              title: 'Perjalanan',
              items: [
                _SettingsItem(
                  Icons.history_outlined,
                  'Riwayat Perjalanan',
                  () => Navigator.pushNamed(context, AppRoutes.history),
                ),
                _SettingsItem(
                    Icons.favorite_border, 'Destinasi Favorit', () {}),
                _SettingsItem(
                    Icons.card_giftcard_outlined, 'Poin & Reward', () {}),
              ],
            ),
            const SizedBox(height: 16),

            _SettingsSection(
              title: 'Preferensi',
              items: [
                _SettingsItem(
                    Icons.notifications_outlined, 'Notifikasi', () {}),
                _SettingsItem(Icons.language_outlined, 'Bahasa', () {}),
                _SettingsItem(
                    Icons.dark_mode_outlined, 'Tampilan Gelap', () {}),
              ],
            ),
            const SizedBox(height: 16),

            _SettingsSection(
              title: 'Bantuan',
              items: [
                _SettingsItem(Icons.help_outline, 'Bantuan & FAQ', () {}),
                _SettingsItem(
                    Icons.privacy_tip_outlined, 'Kebijakan Privasi', () {}),
                _SettingsItem(
                    Icons.info_outline, 'Tentang MobiTravel', () {}),
              ],
            ),
            const SizedBox(height: 16),

            // Logout
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppCard(
                padding: EdgeInsets.zero,
                onTap: () => Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.login, (r) => false),
                child: ListTile(
                  leading: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.errorBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.logout,
                        color: AppColors.error, size: 18),
                  ),
                  title: const Text(
                    'Keluar dari Akun',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      size: 14, color: AppColors.error),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                ),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: const MobiBottomNav(currentIndex: 3),
    );
  }
}

// ─── Profile Header ────────────────────────────────────────────────────────

class _ProfileHeader extends StatelessWidget {
  final UserProfile user;
  const _ProfileHeader({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A3328), Color(0xFF2D4A3E)],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
      child: Row(
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
                      color: Colors.white.withOpacity(0.4), width: 2.5),
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 36),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: const Color(0xFF2D4A3E), width: 2),
                    ),
                    child: const Icon(Icons.edit,
                        color: Colors.white, size: 11),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7B5E2A).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: AppColors.accentGold.withOpacity(0.4)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.workspace_premium,
                          color: AppColors.accentGold, size: 13),
                      const SizedBox(width: 5),
                      Text(
                        user.membershipLevel,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.accentGold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Stats Row ─────────────────────────────────────────────────────────────

class _StatsRow extends StatelessWidget {
  final UserProfile user;
  const _StatsRow({required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            _StatItem(
                value: user.totalTrips.toString(),
                label: 'Perjalanan',
                icon: Icons.luggage_outlined),
            _Divider(),
            _StatItem(
                value: user.totalDestinations.toString(),
                label: 'Destinasi',
                icon: Icons.location_on_outlined),
            _Divider(),
            _StatItem(
                value: user.points,
                label: 'Poin',
                icon: Icons.star_outline),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  const _StatItem(
      {required this.value, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: AppColors.accent, size: 22),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 44,
      color: AppColors.border,
    );
  }
}

// ─── Settings Section ──────────────────────────────────────────────────────

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<_SettingsItem> items;
  const _SettingsSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.textMuted,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: List.generate(items.length, (index) {
                final isLast = index == items.length - 1;
                return Column(
                  children: [
                    items[index].build(context),
                    if (!isLast)
                      const Divider(
                          height: 1,
                          indent: 54,
                          color: AppColors.border),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _SettingsItem(this.icon, this.label, this.onTap);

  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primary, size: 18),
      ),
      title: Text(
        label,
        style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
      ),
      trailing: const Icon(Icons.arrow_forward_ios,
          size: 14, color: AppColors.textMuted),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    );
  }
}

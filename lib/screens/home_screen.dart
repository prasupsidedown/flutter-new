import 'package:flutter/material.dart';
import '../app_theme.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  int _selectedNav = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    _buildProfileHeader(),
                    const SizedBox(height: 24),
                    _buildStatCards(),
                    const SizedBox(height: 32),
                    _buildSectionTitle('Auction Info Formal'),
                    const SizedBox(height: 16),
                    _buildMenuSection(),
                    const SizedBox(height: 24),
                    _buildLogoutButton(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          const Text(
            'Profile',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.settings_outlined,
                color: AppColors.primary,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        Stack(
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.cardBorder, width: 2),
                color: AppColors.surface,
              ),
              child: const ClipOval(
                child: Icon(
                  Icons.person,
                  size: 52,
                  color: AppColors.primary,
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.background, width: 2),
                ),
                child: const Icon(Icons.edit, color: Colors.white, size: 12),
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
                'Rizky Firmansyah',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.accentLight.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: AppColors.accent, size: 14),
                    SizedBox(width: 4),
                    Text(
                      'Gold Member',
                      style: TextStyle(
                        color: AppColors.accent,
                        fontSize: 12,
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
    );
  }

  Widget _buildStatCards() {
    final stats = [
      {'label': 'Trips', 'value': '24'},
      {'label': 'Reviews', 'value': '12'},
      {'label': 'Points', 'value': '1.4k'},
    ];
    return Row(
      children: stats.map((s) {
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(
              right: s != stats.last ? 12 : 0,
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  s['value']!,
                  style: const TextStyle(
                    color: AppColors.accent,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  s['label']!,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildMenuSection() {
    final menuItems = [
      {
        'icon': Icons.receipt_long_outlined,
        'label': 'My Bookings',
        'sub': 'View all your trips'
      },
      {
        'icon': Icons.account_balance_wallet_outlined,
        'label': 'Payment Methods',
        'sub': 'Manage your payments'
      },
      {
        'icon': Icons.notifications_outlined,
        'label': 'Notifications',
        'sub': 'Stay up to date'
      },
      {
        'icon': Icons.shield_outlined,
        'label': 'Privacy & Security',
        'sub': 'Protect your account'
      },
      {
        'icon': Icons.help_outline,
        'label': 'Help & Support',
        'sub': 'Get help anytime'
      },
    ];

    return Column(
      children: menuItems.map((item) {
        return GestureDetector(
          onTap: () {
            if (item['label'] == 'My Bookings') {
              Navigator.pushNamed(context, '/search');
            }
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['label'] as String,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        item['sub'] as String,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right,
                    color: AppColors.textMuted, size: 20),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLogoutButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.error.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(29),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, color: AppColors.error, size: 20),
            SizedBox(width: 8),
            Text(
              'Keluar',
              style: TextStyle(
                color: AppColors.error,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {'icon': Icons.home_outlined, 'activeIcon': Icons.home, 'label': 'Home'},
      {
        'icon': Icons.search_outlined,
        'activeIcon': Icons.search,
        'label': 'Search'
      },
      {
        'icon': Icons.bookmark_outline,
        'activeIcon': Icons.bookmark,
        'label': 'Saved'
      },
      {
        'icon': Icons.person_outline,
        'activeIcon': Icons.person,
        'label': 'Profile'
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.9),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.06),
            blurRadius: 32,
            offset: const Offset(0, -12),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(items.length, (i) {
          final selected = _selectedNav == i;
          return GestureDetector(
            onTap: () {
              setState(() => _selectedNav = i);
              if (i == 1) Navigator.pushNamed(context, '/search');
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  selected
                      ? items[i]['activeIcon'] as IconData
                      : items[i]['icon'] as IconData,
                  color: selected ? AppColors.accent : AppColors.textMuted,
                  size: 26,
                ),
                const SizedBox(height: 4),
                Text(
                  items[i]['label'] as String,
                  style: TextStyle(
                    color: selected ? AppColors.accent : AppColors.textMuted,
                    fontSize: 11,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
} // ← penutup class _AccountScreenState

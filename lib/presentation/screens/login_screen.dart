import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../data/repositories/travel_repository.dart';
import '../widgets/shared_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool _obscurePassword = true;
  bool _isLoading = false;
  late TabController _tabController;
  final _emailController = TextEditingController(); // NIK → Email
  final _passwordController = TextEditingController();
  final _repo = TravelRepositoryImpl();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackbar('Email dan kata sandi wajib diisi');
      return;
    }

    setState(() => _isLoading = true);

    final result = await _repo.login(email, password);

    setState(() => _isLoading = false);

    if (result['success']) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }
    } else {
      _showSnackbar(result['message'] ?? 'Login gagal');
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildBrandHeader(),
              Container(
                color: Colors.white,
                child: TabBar(
                  controller: _tabController,
                  labelColor: AppColors.accent,
                  unselectedLabelColor: AppColors.textMuted,
                  labelStyle: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w700),
                  unselectedLabelStyle: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400),
                  indicatorColor: AppColors.accent,
                  indicatorWeight: 3,
                  tabs: const [
                    Tab(text: 'Masuk'),
                    Tab(text: 'Daftar'),
                  ],
                  onTap: (i) {
                    if (i == 1) {
                      Navigator.pushNamed(context, AppRoutes.register);
                      _tabController.animateTo(0);
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),
              _buildLoginForm(context),
              const SizedBox(height: 24),
              _OrDivider(),
              const SizedBox(height: 20),
              _PartnerCard(
                  onTap: () => Navigator.pushNamed(context, AppRoutes.agent)),
              const SizedBox(height: 32),
              const Text(
                '© 2025 MobiTravel. Dibuat untuk eksplorasi.',
                style: TextStyle(fontSize: 12, color: AppColors.textMuted),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrandHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 36),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF2D4A3E), Color(0xFF1A3328)],
              ),
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.25),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(Icons.explore_outlined,
                color: Colors.white, size: 36),
          ),
          const SizedBox(height: 18),
          const Text(
            'MobiTravel',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              fontStyle: FontStyle.italic,
              color: AppColors.accent,
              fontFamily: 'serif',
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Jelajahi keindahan nusantara bersama kami.',
            style: TextStyle(
                fontSize: 14, color: AppColors.textSecondary, height: 1.5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selamat Datang Kembali',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary),
          ),
          const SizedBox(height: 6),
          const Text(
            'Silakan masuk untuk melanjutkan petualangan Anda.',
            style: TextStyle(
                fontSize: 14, color: AppColors.textSecondary, height: 1.5),
          ),
          const SizedBox(height: 28),

          // Email field
          const _FieldLabel('Email'),
          const SizedBox(height: 8),
          _InputField(
            controller: _emailController,
            hint: 'contoh@email.com',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),

          // Password field
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const _FieldLabel('Kata Sandi'),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Lupa kata sandi?',
                  style: TextStyle(
                      fontSize: 13,
                      color: AppColors.accent,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _InputField(
            controller: _passwordController,
            hint: 'Masukkan kata sandi Anda',
            prefixIcon: Icons.lock_outline,
            obscureText: _obscurePassword,
            suffixIcon: GestureDetector(
              onTap: () => setState(() => _obscurePassword = !_obscurePassword),
              child: Icon(
                _obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.textMuted,
                size: 20,
              ),
            ),
          ),
          const SizedBox(height: 28),

          // Login button
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : PrimaryButton(
                  label: 'Masuk Sekarang',
                  icon: Icons.arrow_forward,
                  onPressed: _handleLogin,
                ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                  child: _SocialButton(
                      icon: Icons.g_mobiledata, label: 'Google', onTap: () {})),
              const SizedBox(width: 12),
              Expanded(
                  child: _SocialButton(
                      icon: Icons.facebook_outlined,
                      label: 'Facebook',
                      onTap: () {})),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget classes tetap sama persis
class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;

  const _InputField({
    required this.controller,
    required this.hint,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1.5),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 14),
          prefixIcon: Icon(prefixIcon, color: AppColors.textMuted, size: 20),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _SocialButton(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: AppColors.textSecondary),
            const SizedBox(width: 8),
            Text(label,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: const [
          Expanded(child: Divider(color: AppColors.border)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('ATAU',
                style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w600)),
          ),
          Expanded(child: Divider(color: AppColors.border)),
        ],
      ),
    );
  }
}

class _PartnerCard extends StatelessWidget {
  final VoidCallback onTap;
  const _PartnerCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFF5EBD8), Color(0xFFEDE3CC)],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.handshake_outlined,
                    color: Colors.white, size: 22),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bermitra dengan MobiTravel',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary)),
                    SizedBox(height: 3),
                    Text('Jangkau ribuan penjelajah setiap hari.',
                        style: TextStyle(
                            fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios,
                  size: 16, color: AppColors.accent),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  int _selectedTab = 0; // 0 = Masuk, 1 = Daftar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F3),
      appBar: const MobiAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // White card with rounded top content
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  // MobiTravel italic gold title
                  const Text(
                    'MobiTravel',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF7B5E2A),
                      fontFamily: 'serif',
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Jelajahi keindahan nusantara bersama kami.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF5A5A4A),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),

                  // Tabs: Masuk / Daftar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        _buildTab('Masuk', 0),
                        const SizedBox(width: 24),
                        _buildTab('Daftar', 1),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: Color(0xFFE8DFC8)),
                  const SizedBox(height: 32),

                  // Form area
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_selectedTab == 0) ..._buildLoginForm()
                        else ..._buildRegisterPreview(context),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Divider with text
            Row(
              children: [
                Expanded(child: Divider(color: const Color(0xFFE8DFC8), indent: 24, endIndent: 12)),
                const Text(
                  'ATAU JALAN BERSAMA',
                  style: TextStyle(fontSize: 11, color: Color(0xFF9E9E8E), letterSpacing: 1),
                ),
                Expanded(child: Divider(color: const Color(0xFFE8DFC8), indent: 12, endIndent: 24)),
              ],
            ),

            const SizedBox(height: 16),

            // Partner card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0EBE0),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Color(0xFF7B5E2A),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.star, color: Colors.white, size: 16),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Bermitra dengan MobiTravel',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Punya agensi tur atau pengalaman lokal? Jadilah mitra terverifikasi dan jangkau ribuan penjelajah setiap hari.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF5A5A4A),
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/agent'),
                      child: Row(
                        children: [
                          const Text(
                            'Daftar Sebagai Agen',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF7B5E2A),
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.arrow_forward, color: Color(0xFF7B5E2A), size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Footer
            const Text(
              '© 2024 MobiTravel. Dibuat untuk eksplorasi.',
              style: TextStyle(fontSize: 12, color: Color(0xFF9E9E8E)),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: const MobiBottomNav(currentIndex: 0),
    );
  }

  Widget _buildTab(String label, int index) {
    final isActive = _selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedTab = index);
        if (index == 1) {
          Navigator.pushNamed(context, '/register');
        }
      },
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
              color: isActive ? const Color(0xFF1A1A1A) : const Color(0xFF9E9E8E),
            ),
          ),
          const SizedBox(height: 8),
          if (isActive)
            Container(
              height: 3,
              width: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF7B5E2A),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildLoginForm() {
    return [
      const Text(
        'Selamat Datang',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: Color(0xFF1A1A1A),
        ),
      ),
      const SizedBox(height: 8),
      const Text(
        'Silakan masuk untuk melanjutkan petualangan Anda.',
        style: TextStyle(fontSize: 14, color: Color(0xFF5A5A4A), height: 1.5),
      ),
      const SizedBox(height: 28),

      // NIK field
      const Text(
        'NIK (Nomor Induk Kependudukan)',
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF1A1A1A)),
      ),
      const SizedBox(height: 8),
      _buildTextField(
        hint: '16 digit nomor identitas',
        icon: Icons.fingerprint_outlined,
        keyboardType: TextInputType.number,
      ),
      const SizedBox(height: 20),

      // Password field
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Kata Sandi',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF1A1A1A)),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Lupa kata sandi?',
              style: TextStyle(fontSize: 13, color: Color(0xFF7B5E2A), fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      _buildPasswordField(),
      const SizedBox(height: 28),

      // Login button
      SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF7B5E2A),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            elevation: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Masuk Sekarang', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              SizedBox(width: 10),
              Icon(Icons.arrow_forward, size: 18),
            ],
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildRegisterPreview(BuildContext context) {
    return [
      const Text(
        'Buat Akun',
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Color(0xFF1A1A1A)),
      ),
      const SizedBox(height: 8),
      const Text(
        'Bergabunglah dan mulai petualangan baru Anda.',
        style: TextStyle(fontSize: 14, color: Color(0xFF5A5A4A)),
      ),
      const SizedBox(height: 28),
      SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/register'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF7B5E2A),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          ),
          child: const Text('Daftar Sekarang', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ),
      ),
    ];
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8DFC8), width: 1.5),
      ),
      child: TextField(
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A1A)),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFFBBB8AE), fontSize: 14),
          suffixIcon: Icon(icon, color: const Color(0xFFBBB8AE), size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8DFC8), width: 1.5),
      ),
      child: TextField(
        obscureText: _obscurePassword,
        style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A1A)),
        decoration: InputDecoration(
          hintText: 'Masukkan kata sandi Anda',
          hintStyle: const TextStyle(color: Color(0xFFBBB8AE), fontSize: 14),
          suffixIcon: GestureDetector(
            onTap: () => setState(() => _obscurePassword = !_obscurePassword),
            child: Icon(
              _obscurePassword ? Icons.lock_outline : Icons.lock_open_outlined,
              color: const Color(0xFFBBB8AE),
              size: 20,
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }
}

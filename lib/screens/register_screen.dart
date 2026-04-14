import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F3),
      appBar: const MobiAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  const SizedBox(height: 32),
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
                    style: TextStyle(fontSize: 14, color: Color(0xFF5A5A4A)),
                  ),
                  const SizedBox(height: 28),

                  // Tabs
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        _buildTab(context, 'Masuk', false),
                        const SizedBox(width: 24),
                        _buildTab(context, 'Daftar', true),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: Color(0xFFE8DFC8)),
                  const SizedBox(height: 32),

                  // Register form
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Buat Akun Baru',
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Color(0xFF1A1A1A)),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Isi data diri Anda untuk mulai berpetualang.',
                          style: TextStyle(fontSize: 14, color: Color(0xFF5A5A4A), height: 1.5),
                        ),
                        const SizedBox(height: 28),

                        // Name
                        _buildLabel('Nama Lengkap'),
                        const SizedBox(height: 8),
                        _buildTextField(hint: 'Masukkan nama lengkap Anda', icon: Icons.person_outline),
                        const SizedBox(height: 20),

                        // NIK
                        _buildLabel('NIK (Nomor Induk Kependudukan)'),
                        const SizedBox(height: 8),
                        _buildTextField(
                          hint: '16 digit nomor identitas',
                          icon: Icons.fingerprint_outlined,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 20),

                        // Email
                        _buildLabel('Email'),
                        const SizedBox(height: 8),
                        _buildTextField(
                          hint: 'contoh@email.com',
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20),

                        // Phone
                        _buildLabel('Nomor HP'),
                        const SizedBox(height: 8),
                        _buildTextField(
                          hint: '08xx xxxx xxxx',
                          icon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 20),

                        // Password
                        _buildLabel('Kata Sandi'),
                        const SizedBox(height: 8),
                        _buildPasswordField(
                          hint: 'Buat kata sandi Anda',
                          obscure: _obscurePassword,
                          onToggle: () => setState(() => _obscurePassword = !_obscurePassword),
                        ),
                        const SizedBox(height: 20),

                        // Confirm Password
                        _buildLabel('Konfirmasi Kata Sandi'),
                        const SizedBox(height: 8),
                        _buildPasswordField(
                          hint: 'Ulangi kata sandi Anda',
                          obscure: _obscureConfirm,
                          onToggle: () => setState(() => _obscureConfirm = !_obscureConfirm),
                        ),
                        const SizedBox(height: 28),

                        // Date of birth
                        _buildLabel('Tanggal Lahir'),
                        const SizedBox(height: 8),
                        _buildTextField(
                          hint: 'dd / mm / yyyy',
                          icon: Icons.calendar_today_outlined,
                          keyboardType: TextInputType.datetime,
                        ),
                        const SizedBox(height: 32),

                        // Register button
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
                                Text('Daftar Sekarang', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                SizedBox(width: 10),
                                Icon(Icons.arrow_forward, size: 18),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Already have account
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Sudah punya akun? ', style: TextStyle(color: Color(0xFF5A5A4A))),
                            GestureDetector(
                              onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                              child: const Text(
                                'Masuk',
                                style: TextStyle(color: Color(0xFF7B5E2A), fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MobiBottomNav(currentIndex: 0),
    );
  }

  Widget _buildTab(BuildContext context, String label, bool isActive) {
    return GestureDetector(
      onTap: () {
        if (!isActive) Navigator.pushReplacementNamed(context, '/login');
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

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF1A1A1A)),
    );
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

  Widget _buildPasswordField({
    required String hint,
    required bool obscure,
    required VoidCallback onToggle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8DFC8), width: 1.5),
      ),
      child: TextField(
        obscureText: obscure,
        style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A1A)),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFFBBB8AE), fontSize: 14),
          suffixIcon: GestureDetector(
            onTap: onToggle,
            child: Icon(
              obscure ? Icons.lock_outline : Icons.lock_open_outlined,
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

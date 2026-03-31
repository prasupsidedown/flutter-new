import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Pastikan sudah menambahkan google_fonts di pubspec.yaml:
// dependencies:
//   google_fonts: ^6.2.1

class HelloScreen extends StatefulWidget {
  const HelloScreen({super.key});

  @override
  State<HelloScreen> createState() => _HelloScreenState();
}

class _HelloScreenState extends State<HelloScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Fade + slide animations
  late Animation<double> _navFade;
  late Animation<Offset> _navSlide;

  late Animation<double> _titleFade;
  late Animation<Offset> _titleSlide;

  late Animation<double> _dividerFade;
  late Animation<double> _dividerWidth;

  late Animation<double> _btnFade;
  late Animation<Offset> _btnSlide;

  // Hover state untuk tombol
  bool _btnHovered = false;

  // Hover state untuk nav links
  final Map<String, bool> _navHover = {
    'Home': false,
    'About Me': false,
    'Contact': false,
  };

  // Warna
  static const Color cream = Color(0xFFF5F0E8);
  static const Color ink = Color(0xFF1A1612);
  static const Color rust = Color(0xFFC0392B);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    // Nav: fadeDown (delay ~0.3s → 420ms)
    _navFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.30, 0.75, curve: Curves.easeOut),
      ),
    );
    _navSlide = Tween<Offset>(begin: const Offset(0, -0.5), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.30, 0.75, curve: Curves.easeOut),
          ),
        );

    // Title: fadeUp (delay ~0.2s → 280ms)
    _titleFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.20, 0.65, curve: Curves.easeOut),
      ),
    );
    _titleSlide = Tween<Offset>(begin: const Offset(0, 0.6), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.20, 0.65, curve: Curves.easeOut),
          ),
        );

    // Divider: expand (delay ~0.4s → 560ms)
    _dividerFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.40, 0.70, curve: Curves.easeOut),
      ),
    );
    _dividerWidth = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.40, 0.70, curve: Curves.easeOut),
      ),
    );

    // Button: fadeUp (delay ~0.5s → 700ms)
    _btnFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.50, 0.90, curve: Curves.easeOut),
      ),
    );
    _btnSlide = Tween<Offset>(begin: const Offset(0, 0.6), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.50, 0.90, curve: Curves.easeOut),
          ),
        );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      body: Stack(
        children: [
          // ── Grain texture overlay
          Positioned.fill(
            child: IgnorePointer(child: CustomPaint(painter: _GrainPainter())),
          ),

          // ── Navigation (top-left)
          Positioned(
            top: 28,
            left: 36,
            child: FadeTransition(
              opacity: _navFade,
              child: SlideTransition(
                position: _navSlide,
                child: Row(
                  children: [
                    _NavLink(
                      label: 'Home',
                      isHovered: _navHover['Home']!,
                      onHoverChange: (v) =>
                          setState(() => _navHover['Home'] = v),
                      onTap: () {},
                    ),
                    const _NavDot(),
                    _NavLink(
                      label: 'About Me',
                      isHovered: _navHover['About Me']!,
                      onHoverChange: (v) =>
                          setState(() => _navHover['About Me'] = v),
                      onTap: () {},
                    ),
                    const _NavDot(),
                    _NavLink(
                      label: 'Contact',
                      isHovered: _navHover['Contact']!,
                      onHoverChange: (v) =>
                          setState(() => _navHover['Contact'] = v),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Main content (center)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(48),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title: "Hello" + "World" (rust)
                  FadeTransition(
                    opacity: _titleFade,
                    child: SlideTransition(
                      position: _titleSlide,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: GoogleFonts.playfairDisplay(
                            fontSize: _responsiveFontSize(context),
                            fontWeight: FontWeight.w700,
                            height: 1.0,
                            letterSpacing: -0.02 * _responsiveFontSize(context),
                          ),
                          children: const [
                            TextSpan(
                              text: 'Hello\n',
                              style: TextStyle(color: ink),
                            ),
                            TextSpan(
                              text: 'World',
                              style: TextStyle(color: rust),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Divider (animated expand)
                  FadeTransition(
                    opacity: _dividerFade,
                    child: AnimatedBuilder(
                      animation: _dividerWidth,
                      builder: (context, _) {
                        return SizedBox(
                          height: 2,
                          width: 60 * _dividerWidth.value,
                          child: const ColoredBox(color: ink),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Button
                  FadeTransition(
                    opacity: _btnFade,
                    child: SlideTransition(
                      position: _btnSlide,
                      child: MouseRegion(
                        onEnter: (_) => setState(() => _btnHovered = true),
                        onExit: (_) => setState(() => _btnHovered = false),
                        child: GestureDetector(
                          onTap: () {
                            // Navigasi ke ProfileScreen
                            Navigator.pushNamed(context, '/profile');
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeOut,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 48,
                              vertical: 18,
                            ),
                            decoration: BoxDecoration(
                              color: _btnHovered ? rust : ink,
                              border: Border.all(
                                color: _btnHovered ? rust : ink,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              'LIHAT SAYA',
                              style: GoogleFonts.dmSans(
                                fontSize: 13.6,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.2 * 13.6,
                                color: cream,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _responsiveFontSize(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    // clamp(4rem → 64px, 12vw, 8rem → 128px)
    return (w * 0.12).clamp(64.0, 128.0);
  }
}

// ── Nav Link Widget
class _NavLink extends StatelessWidget {
  final String label;
  final bool isHovered;
  final ValueChanged<bool> onHoverChange;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.isHovered,
    required this.onHoverChange,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onHoverChange(true),
      onExit: (_) => onHoverChange(false),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: GoogleFonts.dmSans(
                fontSize: 11.5,
                fontWeight: FontWeight.w300,
                letterSpacing: 0.25 * 11.5,
                color: isHovered
                    ? const Color(0xFFC0392B)
                    : const Color(0xFF1A1612),
              ),
              child: Text(label.toUpperCase()),
            ),
            const SizedBox(height: 3),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              height: 1.5,
              width: isHovered ? _textWidth(label) : 0,
              color: const Color(0xFFC0392B),
            ),
          ],
        ),
      ),
    );
  }

  // Estimasi lebar teks untuk underline
  double _textWidth(String text) => text.length * 7.5;
}

// ── Nav Dot
class _NavDot extends StatelessWidget {
  const _NavDot();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: 3,
        height: 3,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0x4D1A1612), // ink 30%
          ),
        ),
      ),
    );
  }
}

// ── Grain texture painter
class _GrainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Simulasi grain ringan dengan banyak titik acak kecil
    final paint = Paint()
      ..color = const Color(0x08000000)
      ..strokeWidth = 1;

    // Gunakan seed tetap agar tidak berubah setiap frame
    var rng = _SimpleLCG(seed: 42);
    for (int i = 0; i < 12000; i++) {
      final x = rng.nextDouble() * size.width;
      final y = rng.nextDouble() * size.height;
      canvas.drawCircle(Offset(x, y), 0.5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Linear Congruential Generator sederhana (tanpa dart:math Random)
class _SimpleLCG {
  int _state;
  _SimpleLCG({required int seed}) : _state = seed;

  double nextDouble() {
    _state = (_state * 1664525 + 1013904223) & 0xFFFFFFFF;
    return _state / 0xFFFFFFFF;
  }
}

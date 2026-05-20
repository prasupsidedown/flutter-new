import 'package:flutter/material.dart';
import 'virtual_assistant_chat.dart'; // Sesuaikan dengan path file Anda

// CONTOH PENGGUNAAN VirtualAssistantChat dengan floating button

class HomePageWithChatbot extends StatefulWidget {
  const HomePageWithChatbot({super.key});

  @override
  State<HomePageWithChatbot> createState() => _HomePageWithChatbotState();
}

class _HomePageWithChatbotState extends State<HomePageWithChatbot> {
  bool _isChatVisible = false; // Status apakah chat terbuka atau tidak

  void _toggleChat() {
    setState(() {
      _isChatVisible = !_isChatVisible;
    });
  }

  void _closeChat() {
    setState(() {
      _isChatVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MobiTravel'),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          // Konten utama aplikasi Anda
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Selamat datang di MobiTravel!',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _toggleChat,
                  child: Text(_isChatVisible ? 'Tutup Chat' : 'Buka Chat'),
                ),
              ],
            ),
          ),

          // ✅ FLOATING CHATBOT - Muncul di kanan bawah
          if (_isChatVisible)
            Positioned(
              right: 16,
              bottom: 80, // Tinggi dari bawah (ada ruang untuk FAB)
              child: AnimatedOpacity(
                opacity: _isChatVisible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: VirtualAssistantChat(
                  onClose: _closeChat, // ✅ Callback untuk tutup chat
                ),
              ),
            ),
        ],
      ),

      // ✅ FLOATING ACTION BUTTON untuk buka/tutup chat
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleChat,
        backgroundColor: Colors.blue,
        child: Icon(
          _isChatVisible ? Icons.close : Icons.chat,
          color: Colors.white,
        ),
      ),
    );
  }
}

// ============================================
// CONTOH 2: Dengan animasi slide dari bawah
// ============================================

class HomePageWithAnimatedChatbot extends StatefulWidget {
  const HomePageWithAnimatedChatbot({super.key});

  @override
  State<HomePageWithAnimatedChatbot> createState() =>
      _HomePageWithAnimatedChatbotState();
}

class _HomePageWithAnimatedChatbotState
    extends State<HomePageWithAnimatedChatbot>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  bool _isChatVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Mulai dari bawah
      end: Offset.zero, // Slide ke posisi normal
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleChat() {
    setState(() {
      _isChatVisible = !_isChatVisible;
      if (_isChatVisible) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _closeChat() {
    setState(() {
      _isChatVisible = false;
      _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MobiTravel'),
      ),
      body: Stack(
        children: [
          // Konten utama
          const Center(
            child: Text('Your app content here'),
          ),

          // ✅ CHATBOT dengan animasi slide
          if (_isChatVisible)
            Positioned(
              right: 16,
              bottom: 80,
              child: SlideTransition(
                position: _slideAnimation,
                child: VirtualAssistantChat(
                  onClose: _closeChat,
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleChat,
        child: Icon(_isChatVisible ? Icons.close : Icons.chat),
      ),
    );
  }
}

// ============================================
// CARA PAKAI:
// ============================================
// 1. Copy file virtual_assistant_chat.dart ke project Anda
// 2. Import di halaman yang ingin pakai chatbot
// 3. Gunakan salah satu contoh di atas
// 4. Sesuaikan posisi dan styling sesuai kebutuhan

void main() {
  runApp(const MaterialApp(
    home: HomePageWithChatbot(), // atau HomePageWithAnimatedChatbot()
  ));
}

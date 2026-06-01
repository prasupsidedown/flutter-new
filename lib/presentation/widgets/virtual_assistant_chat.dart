import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class VirtualAssistantChat extends StatefulWidget {
  final VoidCallback? onClose;

  const VirtualAssistantChat({super.key, this.onClose});

  @override
  State<VirtualAssistantChat> createState() => _VirtualAssistantChatState();
}

class _VirtualAssistantChatState extends State<VirtualAssistantChat> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _messages.add(ChatMessage(
      text: "Halo! Saya asisten virtual MobiTravel. Ada yang bisa saya bantu?",
      isUser: false,
    ));
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
    });
    _textController.clear();

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _messages.add(ChatMessage(
          text: _getBotResponse(text),
          isUser: false,
        ));
      });
      _scrollToBottom();
    });
    _scrollToBottom();
  }

  String _getBotResponse(String userMessage) {
    final msg = userMessage.toLowerCase();

    if (msg.contains('halo') || msg.contains('hai') || msg.contains('hello')) {
      return "Halo! Selamat datang di MobiTravel. Ada yang bisa saya bantu?";
    } else if (msg.contains('destinasi') || msg.contains('wisata')) {
      return "Kami punya banyak destinasi wisata menarik seperti Bali, Raja Ampat, Labuan Bajo, dan masih banyak lagi. Mau cari yang mana?";
    } else if (msg.contains('harga') || msg.contains('price')) {
      return "Harga tiket bervariasi tergantung destinasi dan kelas. Bisa cek di halaman utama untuk info lebih detail ya!";
    } else if (msg.contains('booking') || msg.contains('pesan')) {
      return "Untuk booking, silakan pilih paket wisata atau kendaraan favorit, lalu klik tombol 'Pesan Sekarang'.";
    } else if (msg.contains('agen') || msg.contains('partner')) {
      return "Tertarik jadi agen? Klik tombol 'Bermitra dengan MobiTravel' di halaman login ya!";
    } else if (msg.contains('thanks') || msg.contains('terima kasih')) {
      return "Sama-sama! Senang bisa membantu. Ada lagi yang ingin ditanyakan?";
    } else {
      return "Terima kasih atas pertanyaannya. Tim customer service kami akan segera merespon. Atau bisa cek FAQ di menu bantuan ya!";
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _closeChat() {
    if (widget.onClose != null) {
      widget.onClose!();
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Asisten Virtual MobiTravel'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _closeChat,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: message.isUser ? AppColors.accent : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft:
                message.isUser ? const Radius.circular(16) : Radius.zero,
            bottomRight:
                message.isUser ? Radius.zero : const Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isUser ? Colors.white : AppColors.textPrimary,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Tanyakan sesuatu...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: AppColors.border),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

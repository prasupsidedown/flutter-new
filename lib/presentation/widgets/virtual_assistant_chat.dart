import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/api_constants.dart';

class ChatMessage {
  final String text;
  final bool isBot;
  final bool isTyping;
  final DateTime time;

  ChatMessage({
    required this.text,
    required this.isBot,
    this.isTyping = false,
    required this.time,
  });
}

class QuickReply {
  final String label;
  final String answer;
  QuickReply({required this.label, required this.answer});
}

class VirtualAssistantChat extends StatefulWidget {
  final VoidCallback onClose;

  const VirtualAssistantChat({
    super.key,
    required this.onClose,
  });

  @override
  State<VirtualAssistantChat> createState() => _VirtualAssistantChatState();
}

class _VirtualAssistantChatState extends State<VirtualAssistantChat> {
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _showQuickReplies = true;
  bool _isLoading = false;

  // Gemini setup
  late final GenerativeModel _model;
  late final ChatSession _chat;

  static const String _systemPrompt = '''
Kamu adalah Mobi, asisten virtual dari aplikasi wisata MobiTravel.
Kamu membantu pengguna dengan informasi seputar:
- Cara booking trip dan paket wisata
- Destinasi wisata populer di Indonesia (pantai, gunung, budaya, kuliner, diving)
- Metode pembayaran yang tersedia
- Kebijakan pembatalan dan refund
- Cara menghubungi agen wisata
- Cek status pesanan
- Rekomendasi destinasi berdasarkan preferensi pengguna

Aturan menjawab:
- Selalu jawab dalam Bahasa Indonesia
- Jawaban singkat, padat, ramah, dan informatif
- Maksimal 5-6 baris per jawaban
- Jika ditanya di luar topik wisata/MobiTravel, tolak dengan sopan dan arahkan kembali ke topik wisata
- Gunakan emoji sesekali agar terasa ramah
- Panggil pengguna dengan "kamu" bukan "Anda"
''';

  final List<QuickReply> _quickReplies = [
    QuickReply(
      label: 'Cara booking trip?',
      answer:
          'Untuk booking trip di MobiTravel sangat mudah!\n\n1. Pilih destinasi yang kamu inginkan\n2. Klik tombol "Booking Sekarang"\n3. Pilih tanggal keberangkatan\n4. Isi data peserta\n5. Pilih metode pembayaran\n6. Konfirmasi & selesai! 🎉\n\nTim kami akan mengirim e-voucher ke emailmu dalam 1x24 jam.',
    ),
    QuickReply(
      label: 'Metode pembayaran apa saja?',
      answer:
          'MobiTravel menerima berbagai metode pembayaran:\n\n• Transfer Bank (BCA, BNI, BRI, Mandiri)\n• Virtual Account\n• Kartu Kredit / Debit\n• GoPay & OVO\n• Bayar di tempat (untuk trip lokal tertentu)\n\nSemua transaksi aman & terenkripsi 🔒',
    ),
    QuickReply(
      label: 'Cara batalkan booking?',
      answer:
          'Pembatalan booking bisa dilakukan melalui:\n\n1. Buka menu "Riwayat" di bawah\n2. Pilih booking yang ingin dibatalkan\n3. Klik "Batalkan Pesanan"\n4. Pilih alasan pembatalan\n\n⚠️ Kebijakan refund:\n• Batal >7 hari sebelum trip: refund 100%\n• Batal 3-7 hari: refund 50%\n• Batal <3 hari: tidak dapat refund',
    ),
    QuickReply(
      label: 'Hubungi agen wisata?',
      answer:
          'Kamu bisa menghubungi agen wisata kami melalui:\n\n• Menu "Agen" di navigasi bawah\n• WhatsApp: +62 812-3456-7890\n• Email: support@mobitravel.id\n• Live chat (jam 08.00 – 22.00 WIB)\n\nAgen kami siap membantu merencanakan perjalanan impianmu! 😊',
    ),
    QuickReply(
      label: 'Rekomendasi destinasi?',
      answer:
          'Destinasi populer saat ini:\n\n🏖️ Pantai: Raja Ampat, Labuan Bajo, Lombok\n⛰️ Gunung: Bromo, Rinjani, Semeru\n🏛️ Budaya: Yogyakarta, Ubud Bali, Toraja\n🤿 Diving: Bunaken, Wakatobi, Komodo\n🍜 Kuliner: Surabaya, Semarang, Makassar\n\nKetuk destinasi di beranda untuk info lengkap! ✨',
    ),
    QuickReply(
      label: 'Cek status pesanan?',
      answer:
          'Untuk cek status pesanan:\n\n1. Buka menu "Riwayat" di navigasi bawah\n2. Pilih pesanan yang ingin dicek\n3. Lihat detail status perjalananmu\n\nStatus akan diperbarui real-time. Jika ada kendala, hubungi CS kami di +62 812-3456-7890 🙌',
    ),
  ];

  @override
  void initState() {
    super.initState();

    // Init Gemini
    _model = GenerativeModel(
      model: ApiConstants.geminiModel,
      apiKey: ApiConstants.geminiApiKey,
      systemInstruction: Content.system(_systemPrompt),
    );
    _chat = _model.startChat();

    _messages.add(ChatMessage(
      text:
          'Halo! Saya Mobi, asisten virtual MobiTravel 👋\n\nAda yang bisa saya bantu? Pilih pertanyaan di bawah atau ketik langsung ya!',
      isBot: true,
      time: DateTime.now(),
    ));
  }

  // ── Quick reply (pakai jawaban lokal, tidak perlu API) ───────────
  void _handleQuickReply(QuickReply reply) {
    setState(() {
      _showQuickReplies = false;
      _messages.add(ChatMessage(
        text: reply.label,
        isBot: false,
        time: DateTime.now(),
      ));
    });
    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() {
        _messages.add(ChatMessage(
          text: reply.answer,
          isBot: true,
          time: DateTime.now(),
        ));
        _showQuickReplies = true;
      });
      _scrollToBottom();
    });
  }

  // ── Kirim pesan teks bebas ke Gemini ────────────────────────────
  Future<void> _sendMessage() async {
    final text = _textController.text.trim();
    if (text.isEmpty || _isLoading) return;

    _textController.clear();
    setState(() {
      _showQuickReplies = false;
      _isLoading = true;
      _messages
          .add(ChatMessage(text: text, isBot: false, time: DateTime.now()));
      _messages.add(ChatMessage(
        text: '',
        isBot: true,
        isTyping: true,
        time: DateTime.now(),
      ));
    });
    _scrollToBottom();

    String? reply;
    const retries = 3;

    for (int i = 0; i < retries; i++) {
      try {
        final response = await _chat.sendMessage(Content.text(text));
        reply = response.text ?? 'Maaf, saya tidak bisa menjawab saat ini.';
        break;
      } catch (e) {
        final isRateLimit = e.toString().contains('429') ||
            e.toString().contains('Too Many Requests');
        if (isRateLimit && i < retries - 1) {
          await Future.delayed(Duration(seconds: 3 * (i + 1)));
          continue;
        }
        reply = isRateLimit
            ? 'Sedang ramai, mohon tunggu sebentar dan coba lagi ya 🙏'
            : 'Maaf, terjadi gangguan koneksi. Silakan coba lagi ya 🙏';
        break;
      }
    }

    if (!mounted) return;
    setState(() {
      _messages.removeLast();
      _messages.add(ChatMessage(
        text: reply!,
        isBot: true,
        time: DateTime.now(),
      ));
      _showQuickReplies = true;
      _isLoading = false;
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 150), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bottomNavHeight = 70.0;
    final fabOffset = 80.0;
    final topSafeArea = MediaQuery.of(context).padding.top + kToolbarHeight;
    final availableHeight =
        screenSize.height - topSafeArea - bottomNavHeight - fabOffset - 24;
    final chatWidth = (screenSize.width - 40).clamp(280.0, 340.0);
    final chatHeight = availableHeight.clamp(320.0, 520.0);

    return Material(
      color: Colors.transparent,
      child: Container(
        width: chatWidth,
        height: chatHeight,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.18),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            children: [
              // ── Header ──────────────────────────────────────────
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1A3328), Color(0xFF2D4A3E)],
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: AppColors.accentGold.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: AppColors.accentGold.withValues(alpha: 0.5),
                            width: 1.5),
                      ),
                      child: const Icon(Icons.support_agent_rounded,
                          color: Colors.white, size: 18),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Mobi Assistant',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 7,
                                height: 7,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF4CAF50),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _isLoading ? 'Mengetik...' : 'Online',
                                style: const TextStyle(
                                    color: Colors.white70, fontSize: 11),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onClose,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close,
                            color: Colors.white, size: 16),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Messages ────────────────────────────────────────
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                  itemCount: _messages.length + (_showQuickReplies ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (_showQuickReplies && index == _messages.length) {
                      return _buildQuickReplies();
                    }
                    final msg = _messages[index];
                    if (msg.isTyping) return const _TypingIndicator();
                    return _MessageBubble(message: msg);
                  },
                ),
              ),

              // ── Input TextField ──────────────────────────────────
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        focusNode: _focusNode,
                        enabled: !_isLoading,
                        style: const TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                          hintText: 'Ketik pertanyaan...',
                          hintStyle: TextStyle(
                              fontSize: 13, color: Colors.grey.shade400),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: AppColors.border),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: AppColors.border),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: AppColors.primary, width: 1.5),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          isDense: true,
                        ),
                        onSubmitted: (_) => _sendMessage(),
                        textInputAction: TextInputAction.send,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _isLoading ? null : _sendMessage,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: _isLoading
                              ? Colors.grey.shade300
                              : AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: _isLoading
                            ? const Padding(
                                padding: EdgeInsets.all(10),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.send_rounded,
                                color: Colors.white, size: 17),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickReplies() {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.fromLTRB(2, 10, 2, 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8, bottom: 8),
            child: Text(
              'Pertanyaan umum:',
              style: TextStyle(
                fontSize: 11,
                color: AppColors.textMuted,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: _quickReplies
                .map((r) => _QuickReplyChip(
                      label: r.label,
                      onTap: () => _handleQuickReply(r),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

// ── Typing indicator (animasi tiga titik) ───────────────────────────
class _TypingIndicator extends StatefulWidget {
  const _TypingIndicator();

  @override
  State<_TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 26,
            height: 26,
            margin: const EdgeInsets.only(right: 6),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.support_agent_rounded,
                color: Colors.white, size: 14),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
                bottomRight: Radius.circular(14),
                bottomLeft: Radius.circular(4),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(3, (i) {
                    final delay = i / 3;
                    final value = ((_controller.value - delay) % 1.0);
                    final opacity = value < 0.5 ? value * 2 : (1.0 - value) * 2;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: AppColors.primary
                            .withValues(alpha: 0.3 + (opacity * 0.7)),
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Message bubble ───────────────────────────────────────────────────
class _MessageBubble extends StatelessWidget {
  final ChatMessage message;
  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isBot = message.isBot;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (isBot) ...[
            Container(
              width: 26,
              height: 26,
              margin: const EdgeInsets.only(right: 6),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.support_agent_rounded,
                  color: Colors.white, size: 14),
            ),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
              decoration: BoxDecoration(
                color: isBot ? Colors.white : AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(14),
                  topRight: const Radius.circular(14),
                  bottomLeft: Radius.circular(isBot ? 4 : 14),
                  bottomRight: Radius.circular(isBot ? 14 : 4),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: isBot ? AppColors.textPrimary : Colors.white,
                  fontSize: 13,
                  height: 1.45,
                ),
              ),
            ),
          ),
          if (!isBot) const SizedBox(width: 2),
        ],
      ),
    );
  }
}

// ── Quick reply chip ─────────────────────────────────────────────────
class _QuickReplyChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _QuickReplyChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.accentLight,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.accent,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

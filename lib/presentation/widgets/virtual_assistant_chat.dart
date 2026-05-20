import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ChatMessage {
  final String text;
  final bool isBot;
  final DateTime time;

  ChatMessage({required this.text, required this.isBot, required this.time});
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

  bool _showQuickReplies = true;

  @override
  void initState() {
    super.initState();
    _messages.add(ChatMessage(
      text:
          'Halo! Saya Mobi, asisten virtual MobiTravel 👋\n\nAda yang bisa saya bantu? Pilih pertanyaan di bawah atau ketik langsung ya!',
      isBot: true,
      time: DateTime.now(),
    ));
  }

  void _handleQuickReply(QuickReply reply) {
    setState(() {
      _showQuickReplies = false;
      _messages.add(ChatMessage(
        text: reply.label,
        isBot: false,
        time: DateTime.now(),
      ));
    });

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

    _scrollToBottom();
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

  @override
  void dispose() {
    _scrollController.dispose();
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
              // ── Header ──────────────────────────────────
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
                              const Text(
                                'Online',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 11),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Close button
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

              // ── Messages + Quick Replies (scrollable together) ──────
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                  // +1 untuk slot quick replies di akhir
                  itemCount: _messages.length + (_showQuickReplies ? 1 : 0),
                  itemBuilder: (context, index) {
                    // Item terakhir = quick replies
                    if (_showQuickReplies && index == _messages.length) {
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
                    return _MessageBubble(message: _messages[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

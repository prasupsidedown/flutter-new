import 'package:flutter/material.dart';
import '../app_theme.dart';

/// Screen 5 — Pembayaran & Konfirmasi
/// Berdasarkan Body-4.svg: pilih metode pembayaran, ringkasan akhir,
/// form kode promo, tombol bayar, dan konfirmasi sukses.
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedMethod = 0;
  bool _promoApplied = false;
  final _promoCtrl = TextEditingController();
  bool _showSuccess = false;

  final _methods = [
    {'name': 'Transfer Bank BCA', 'icon': Icons.account_balance_outlined, 'sub': 'Virtual Account'},
    {'name': 'GoPay', 'icon': Icons.account_balance_wallet_outlined, 'sub': 'Saldo: Rp 500.000'},
    {'name': 'OVO', 'icon': Icons.account_balance_wallet_outlined, 'sub': 'Saldo: Rp 250.000'},
    {'name': 'Kartu Kredit / Debit', 'icon': Icons.credit_card_outlined, 'sub': 'Visa, Mastercard'},
    {'name': 'Indomaret / Alfamart', 'icon': Icons.store_outlined, 'sub': 'Bayar di kasir'},
  ];

  @override
  void dispose() {
    _promoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_showSuccess) return _buildSuccessScreen(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _buildOrderSummary(),
                    const SizedBox(height: 20),
                    _sectionTitle('Kode Promo'),
                    const SizedBox(height: 12),
                    _buildPromoField(),
                    const SizedBox(height: 20),
                    _sectionTitle('Metode Pembayaran'),
                    const SizedBox(height: 12),
                    _buildPaymentMethods(),
                    const SizedBox(height: 20),
                    _buildFinalAmount(),
                    const SizedBox(height: 20),
                    _buildTerms(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            _buildPayButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          const Text(
            'Pembayaran',
            style: TextStyle(color: AppColors.primary, fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.05), blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Ringkasan Pesanan', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700, fontSize: 14)),
          const SizedBox(height: 12),
          // trip info row
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.directions_bus, color: AppColors.primary, size: 26),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bus Executive Hino',
                      style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Surabaya → Jakarta  •  07.00 WIB',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '25 Januari 2025  •  Kursi 5',
                      style: TextStyle(color: AppColors.textMuted, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: AppColors.cardBorder),
          const SizedBox(height: 8),
          _detailRow('Penumpang', 'Rizky Firmansyah'),
          _detailRow('Nomor HP', '081234567890'),
          _detailRow('Email', 'rizky@email.com'),
          _detailRow('ID Booking', '#MBT-2025-0125'),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(color: AppColors.textPrimary, fontSize: 13, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(color: AppColors.textPrimary, fontSize: 15, fontWeight: FontWeight.w700),
    );
  }

  Widget _buildPromoField() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _promoApplied ? AppColors.successDark : AppColors.cardBorder,
              ),
            ),
            child: TextField(
              controller: _promoCtrl,
              textCapitalization: TextCapitalization.characters,
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.local_offer_outlined,
                  color: _promoApplied ? AppColors.successDark : AppColors.textMuted,
                  size: 20,
                ),
                hintText: 'Masukkan kode promo',
                hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 13),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                suffixIcon: _promoApplied
                    ? const Icon(Icons.check_circle, color: AppColors.successDark, size: 20)
                    : null,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            if (_promoCtrl.text.isNotEmpty) {
              setState(() => _promoApplied = true);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Promo berhasil! Hemat Rp 35.000'),
                  backgroundColor: AppColors.successDark,
                ),
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text('Pakai', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      children: List.generate(_methods.length, (i) {
        final selected = _selectedMethod == i;
        final m = _methods[i];
        return GestureDetector(
          onTap: () => setState(() => _selectedMethod = i),
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selected ? AppColors.accent : AppColors.cardBorder,
                width: selected ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: selected ? AppColors.accentLight.withOpacity(0.2) : AppColors.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    m['icon'] as IconData,
                    color: selected ? AppColors.accent : AppColors.textSecondary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        m['name'] as String,
                        style: TextStyle(
                          color: selected ? AppColors.accent : AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                      Text(
                        m['sub'] as String,
                        style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: selected ? AppColors.accent : AppColors.cardBorder, width: 2),
                    color: selected ? AppColors.accent : Colors.transparent,
                  ),
                  child: selected
                      ? const Icon(Icons.check, color: Colors.white, size: 12)
                      : null,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildFinalAmount() {
    final discount = _promoApplied ? 35000 : 0;
    final total = 350000 - discount;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _amountRow('Tiket Bus', 'Rp 350.000'),
          if (_promoApplied) _amountRow('Diskon Promo', '- Rp 35.000', isDiscount: true),
          const Divider(color: AppColors.cardBorder),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total Bayar', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textPrimary, fontSize: 15)),
              Text(
                'Rp ${_formatPrice(total)}',
                style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.accent, fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _amountRow(String label, String amount, {bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          Text(
            amount,
            style: TextStyle(
              color: isDiscount ? AppColors.successDark : AppColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTerms() {
    return const Text(
      'Dengan melanjutkan pembayaran, kamu menyetujui Syarat & Ketentuan serta Kebijakan Privasi MobiTravel.',
      style: TextStyle(color: AppColors.textMuted, fontSize: 12, height: 1.5),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildPayButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => setState(() => _showSuccess = true),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.lock_outline, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Bayar Sekarang',
                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // success illustration
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle, color: AppColors.primary, size: 64),
              ),
              const SizedBox(height: 24),
              const Text(
                'Pembayaran Berhasil!',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Tiketmu sudah dipesan.\nCek e-tiket di email kamu.',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.6),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              // ticket card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Surabaya', style: TextStyle(color: Color(0xFF809C8D), fontSize: 12)),
                            Text('SUB', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
                          ],
                        ),
                        Icon(Icons.double_arrow, color: Color(0xFF809C8D)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Jakarta', style: TextStyle(color: Color(0xFF809C8D), fontSize: 12)),
                            Text('JKT', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(color: Color(0xFF2D4A3A)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _ticketDetail('Tanggal', '25 Jan 2025'),
                        _ticketDetail('Berangkat', '07.00'),
                        _ticketDetail('Kursi', '5'),
                        _ticketDetail('Kelas', 'Executive'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        '#MBT-2025-0125',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, letterSpacing: 2),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Text(
                      'Kembali ke Beranda',
                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Unduh E-Tiket',
                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ticketDetail(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF809C8D), fontSize: 11)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
      ],
    );
  }

  String _formatPrice(int price) {
    final s = price.toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return buf.toString();
  }
}

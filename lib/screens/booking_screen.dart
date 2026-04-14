import 'package:flutter/material.dart';
import '../app_theme.dart';

/// Screen 4 — Form Pemesanan
/// Berdasarkan Body-3.svg: form data penumpang, pilih kursi, ringkasan pesanan,
/// berbagai input field, tombol lanjut bayar.
class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  int? _selectedSeat;
  bool _needBaggage = false;
  bool _needInsurance = false;

  // Seat grid: 20 seats, some taken
  final _takenSeats = {3, 7, 12, 15, 19};

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildProgressBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _buildTripSummaryCard(),
                    const SizedBox(height: 20),
                    _sectionTitle('Data Penumpang'),
                    const SizedBox(height: 12),
                    _buildPassengerForm(),
                    const SizedBox(height: 20),
                    _sectionTitle('Pilih Kursi'),
                    const SizedBox(height: 12),
                    _buildSeatPicker(),
                    const SizedBox(height: 20),
                    _sectionTitle('Tambahan'),
                    const SizedBox(height: 12),
                    _buildAddOns(),
                    const SizedBox(height: 20),
                    _buildPriceBreakdown(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            _buildBottomBar(context),
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
            'Form Pemesanan',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: List.generate(3, (i) {
          final active = i <= 0;
          return Expanded(
            child: Container(
              height: 4,
              margin: EdgeInsets.only(right: i < 2 ? 6 : 0),
              decoration: BoxDecoration(
                color: active ? AppColors.accent : AppColors.cardBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTripSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.directions_bus, color: Colors.white, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Bus Executive Hino',
                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Surabaya → Jakarta  •  25 Januari 2025',
                  style: TextStyle(color: Color(0xFF809C8D), fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              '07.00',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 15,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildPassengerForm() {
    return Column(
      children: [
        _inputField('Nama Lengkap', _nameCtrl, Icons.person_outline, 'cth. Rizky Firmansyah'),
        const SizedBox(height: 12),
        _inputField('Nomor Telepon', _phoneCtrl, Icons.phone_outlined, '08xxxxxxxxxx',
            type: TextInputType.phone),
        const SizedBox(height: 12),
        _inputField('Email', _emailCtrl, Icons.email_outlined, 'email@contoh.com',
            type: TextInputType.emailAddress),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Row(
            children: [
              const Icon(Icons.badge_outlined, color: AppColors.textMuted, size: 20),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Jenis ID: KTP / Paspor',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: AppColors.textMuted),
            ],
          ),
        ),
      ],
    );
  }

  Widget _inputField(
    String label,
    TextEditingController ctrl,
    IconData icon,
    String hint, {
    TextInputType type = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: TextField(
            controller: ctrl,
            keyboardType: type,
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: AppColors.textMuted, size: 20),
              hintText: hint,
              hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 13),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSeatPicker() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: AppColors.primary.withOpacity(0.05), blurRadius: 8),
        ],
      ),
      child: Column(
        children: [
          // legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _seatLegend(Colors.white, AppColors.cardBorder, 'Tersedia'),
              const SizedBox(width: 20),
              _seatLegend(AppColors.accent, AppColors.accent, 'Dipilih'),
              const SizedBox(width: 20),
              _seatLegend(AppColors.cardBorder, AppColors.cardBorder, 'Terisi'),
            ],
          ),
          const SizedBox(height: 16),
          // driver icon
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.person, color: AppColors.accent, size: 20),
              ),
              const SizedBox(width: 8),
              const Text('Sopir', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          // seat grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.3,
            ),
            itemCount: 20,
            itemBuilder: (context, i) {
              final seatNum = i + 1;
              final taken = _takenSeats.contains(seatNum);
              final selected = _selectedSeat == seatNum;
              return GestureDetector(
                onTap: taken ? null : () => setState(() => _selectedSeat = seatNum),
                child: Container(
                  decoration: BoxDecoration(
                    color: taken
                        ? AppColors.cardBorder
                        : selected
                            ? AppColors.accent
                            : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: taken
                          ? AppColors.cardBorder
                          : selected
                              ? AppColors.accent
                              : AppColors.cardBorder,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '$seatNum',
                      style: TextStyle(
                        color: taken
                            ? AppColors.textMuted
                            : selected
                                ? Colors.white
                                : AppColors.textPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          if (_selectedSeat != null) ...[
            const SizedBox(height: 12),
            Text(
              'Kursi ${_selectedSeat!} dipilih',
              style: const TextStyle(color: AppColors.accent, fontWeight: FontWeight.w600),
            ),
          ],
        ],
      ),
    );
  }

  Widget _seatLegend(Color fill, Color border, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: fill,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: border),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
      ],
    );
  }

  Widget _buildAddOns() {
    return Column(
      children: [
        _addOnTile(
          'Bagasi Tambahan',
          '+20kg — Rp 50.000',
          Icons.luggage_outlined,
          _needBaggage,
          (v) => setState(() => _needBaggage = v),
        ),
        const SizedBox(height: 8),
        _addOnTile(
          'Asuransi Perjalanan',
          'Proteksi hingga Rp 5jt — Rp 25.000',
          Icons.shield_outlined,
          _needInsurance,
          (v) => setState(() => _needInsurance = v),
        ),
      ],
    );
  }

  Widget _addOnTile(String title, String sub, IconData icon, bool val, ValueChanged<bool> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: val ? AppColors.accent : AppColors.cardBorder),
      ),
      child: Row(
        children: [
          Icon(icon, color: val ? AppColors.accent : AppColors.textMuted, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: AppColors.textPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
                Text(sub, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Switch(
            value: val,
            onChanged: onChanged,
            activeColor: AppColors.accent,
          ),
        ],
      ),
    );
  }

  Widget _buildPriceBreakdown() {
    final baggage = _needBaggage ? 50000 : 0;
    final insurance = _needInsurance ? 25000 : 0;
    final total = 350000 + baggage + insurance;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Rincian Harga', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textPrimary, fontSize: 14)),
          const SizedBox(height: 12),
          _priceRow('Tiket Bus', 'Rp 350.000'),
          if (_needBaggage) _priceRow('Bagasi Tambahan', 'Rp 50.000'),
          if (_needInsurance) _priceRow('Asuransi', 'Rp 25.000'),
          const Divider(color: AppColors.cardBorder),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              Text(
                'Rp ${_formatPrice(total)}',
                style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.accent, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _priceRow(String label, String price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          Text(price, style: const TextStyle(color: AppColors.textPrimary, fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
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

  Widget _buildBottomBar(BuildContext context) {
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
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/payment'),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Text(
              'Lanjut ke Pembayaran',
              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}

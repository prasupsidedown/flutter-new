import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class Screen8 extends StatefulWidget {
  const Screen8({super.key});

  @override
  State<Screen8> createState() => _Screen8State();
}

class _Screen8State extends State<Screen8> {
  final List<Map<String, dynamic>> _cartItems = [
    {
      'name': 'Bayangan Mineral SPF 30',
      'variant': '50ml',
      'price': 245000,
      'qty': 1,
    },
    {
      'name': 'Serum Vitamin C 20%',
      'variant': '30ml',
      'price': 189000,
      'qty': 2,
    },
    {
      'name': 'Toner Niacinamide 10%',
      'variant': '100ml',
      'price': 135000,
      'qty': 1,
    },
  ];

  int get _totalItems =>
      _cartItems.fold(0, (sum, item) => sum + (item['qty'] as int));
  int get _totalPrice => _cartItems.fold(
    0,
    (sum, item) => sum + (item['price'] as int) * (item['qty'] as int),
  );

  void _increment(int index) => setState(() => _cartItems[index]['qty']++);
  void _decrement(int index) {
    setState(() {
      if (_cartItems[index]['qty'] > 1) {
        _cartItems[index]['qty']--;
      } else {
        _cartItems.removeAt(index);
      }
    });
  }

  String _formatRupiah(int amount) {
    final formatted = amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]}.',
    );
    return 'Rp $formatted';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF9F1),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF1A3328),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Keranjang',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A3328),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A3328).withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$_totalItems item',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF1A3328),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_cartItems.isEmpty)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 100),
                          child: Column(
                            children: [
                              Icon(
                                Icons.shopping_bag_outlined,
                                size: 72,
                                color: Color(0xFF809C8D),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Keranjang kosong',
                                style: TextStyle(
                                  color: Color(0xFF809C8D),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      ...List.generate(
                        _cartItems.length,
                        (index) => _buildCartItem(index),
                      ),

                    if (_cartItems.isNotEmpty) ...[
                      const SizedBox(height: 24),

                      // Promo code
                      _buildPromoSection(),
                      const SizedBox(height: 24),

                      // Order Summary
                      const Text(
                        'Ringkasan Pesanan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A3328),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildSummaryRow('Subtotal', _formatRupiah(_totalPrice)),
                      _buildSummaryRow('Diskon', '- Rp 0'),
                      _buildSummaryRow('Ongkos Kirim', 'Gratis'),
                      const SizedBox(height: 12),
                      Container(height: 1, color: const Color(0xFFE8EDE9)),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A3328),
                            ),
                          ),
                          Text(
                            _formatRupiah(_totalPrice),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A3328),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 100),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_cartItems.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/screen9'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A3328),
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Lanjut ke Pembayaran',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _formatRupiah(_totalPrice),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF809C8D),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const MobiBottomNav(currentIndex: 3),
        ],
      ),
    );
  }

  Widget _buildCartItem(int index) {
    final item = _cartItems[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1A3328).withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFF1A3328).withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.spa_outlined,
              color: Color(0xFF1A3328),
              size: 30,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A3328),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item['variant'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF809C8D),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      _formatRupiah(item['price'] as int),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A3328),
                      ),
                    ),
                    const Spacer(),
                    // Quantity control
                    GestureDetector(
                      onTap: () => _decrement(index),
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A3328).withOpacity(0.08),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.remove,
                          size: 14,
                          color: Color(0xFF1A3328),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '${item['qty']}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A3328),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _increment(index),
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A3328),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8EDE9)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.local_offer_outlined,
            color: Color(0xFF805600),
            size: 20,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Masukkan kode promo',
                hintStyle: TextStyle(color: Color(0xFF809C8D), fontSize: 14),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF1A3328),
            ),
            child: const Text(
              'Pakai',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Color(0xFF424844)),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF1A3328),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

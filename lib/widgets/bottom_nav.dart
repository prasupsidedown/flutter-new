import 'package:flutter/material.dart';

class MobiBottomNav extends StatelessWidget {
  final int currentIndex;

  const MobiBottomNav({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.home_outlined, 'activeIcon': Icons.home, 'label': 'BERANDA', 'route': '/home'},
      {'icon': Icons.support_agent_outlined, 'activeIcon': Icons.support_agent, 'label': 'AGEN', 'route': '/agent'},
      {'icon': Icons.history_outlined, 'activeIcon': Icons.history, 'label': 'RIWAYAT', 'route': '/history'},
      {'icon': Icons.person_outline, 'activeIcon': Icons.person, 'label': 'AKUN', 'route': '/account'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: const Color(0xFFE8DFC8), width: 1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: List.generate(items.length, (index) {
              final isActive = index == currentIndex;
              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (!isActive) {
                      Navigator.pushReplacementNamed(context, items[index]['route'] as String);
                    }
                  },
                  child: Container(
                    color: isActive ? const Color(0xFFF5EFE0) : Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isActive
                              ? items[index]['activeIcon'] as IconData
                              : items[index]['icon'] as IconData,
                          size: 24,
                          color: isActive ? const Color(0xFF7B5E2A) : const Color(0xFF9E9E8E),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          items[index]['label'] as String,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                            color: isActive ? const Color(0xFF7B5E2A) : const Color(0xFF9E9E8E),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

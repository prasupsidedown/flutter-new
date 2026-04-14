import 'package:flutter/material.dart';

class MobiAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBack;

  const MobiAppBar({super.key, this.showBack = false});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFFAF8F3),
      elevation: 0,
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A1A)),
              onPressed: () => Navigator.of(context).pop(),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 20),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(Icons.menu, color: Color(0xFF3B4D3F), size: 22),
              ),
            ),
      title: Text(
        'Nusantara',
        style: const TextStyle(
          fontFamily: 'serif',
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Color(0xFF3B4D3F),
          fontStyle: FontStyle.italic,
        ),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Color(0xFF1A1A1A), size: 22),
          onPressed: () {},
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'virtual_assistant_fab.dart';
import 'virtual_assistant_chat.dart';

class VirtualAssistantOverlay extends StatefulWidget {
  final Widget child;

  const VirtualAssistantOverlay({
    super.key,
    required this.child,
  });

  @override
  State<VirtualAssistantOverlay> createState() =>
      _VirtualAssistantOverlayState();
}

class _VirtualAssistantOverlayState extends State<VirtualAssistantOverlay>
    with SingleTickerProviderStateMixin {
  bool _isChatOpen = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _openChat() {
    setState(() => _isChatOpen = true);
    _animationController.forward();
  }

  void _closeChat() {
    _animationController.reverse().then((_) {
      if (mounted) setState(() => _isChatOpen = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,

        // ── Chat panel (shown when open) ────────────────────────────
        if (_isChatOpen)
          Positioned(
            // Anchor from right & bottom, but constrain so it won't overflow
            right: 16,
            bottom: 80,
            // Limit max width so it never bleeds off screen
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 32,
              ),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: VirtualAssistantChat(
                    onClose: _closeChat,
                  ),
                ),
              ),
            ),
          ),

        // ── FAB (always visible when chat is closed) ─────────────────
        if (!_isChatOpen)
          Positioned(
            right: 16,
            bottom: 80,
            child: VirtualAssistantFAB(
              onTap: _openChat,
            ),
          ),
      ],
    );
  }
}

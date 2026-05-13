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

class _VirtualAssistantOverlayState extends State<VirtualAssistantOverlay> {
  bool _isChatOpen = false;

  void _toggleChat() {
    setState(() {
      _isChatOpen = !_isChatOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        
        // Virtual Assistant UI
        Positioned(
          right: 20,
          bottom: 20,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: animation,
                  child: child,
                ),
              );
            },
            child: _isChatOpen
                ? VirtualAssistantChat(
                    key: const ValueKey('chat'),
                    onClose: _toggleChat,
                  )
                : VirtualAssistantFAB(
                    key: const ValueKey('fab'),
                    onTap: _toggleChat,
                  ),
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';

class AppSnackBar {
  static OverlayEntry? _entry;
  static bool _isShowing = false;

  static void show(BuildContext context, {required String message, required Color color, double bottom = 40, double left = 20, double right = 20}) {
    if (_isShowing) return;
    _isShowing = true;

    _entry?.remove();

    final animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 250),
      vsync: Navigator.of(context),
    );

    final animation = CurvedAnimation(parent: animationController, curve: Curves.easeOut, reverseCurve: Curves.easeIn);

    _entry = OverlayEntry(
      builder: (_) {
        return Positioned(
          // bottom: bottom,
          top: 80,
          left: left,
          right: right,
          child: FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(animation),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: color, // <- pake parameter
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [BoxShadow(blurRadius: 10, color: Colors.black26)],
                  ),
                  child: Text(message, style: const TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context, rootOverlay: true).insert(_entry!);
    animationController.forward();

    // Auto dismiss
    Future.delayed(const Duration(seconds: 2), () async {
      await animationController.reverse();
      _entry?.remove();
      _entry = null;
      _isShowing = false;
    });
  }
}

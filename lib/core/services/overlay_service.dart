import 'package:al_huda/feature/azkar/presentation/widgets/floating_azkar_widget.dart';
import 'package:flutter/material.dart';

class OverlayService {
  static OverlayEntry? _overlayEntry;

  static void showFloatingAzkar(BuildContext context) {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => const FloatingAzkarWidget(),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  static void hideFloatingAzkar() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  static bool get isShowing => _overlayEntry != null;
}

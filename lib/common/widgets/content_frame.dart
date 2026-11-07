import 'package:flutter/material.dart';

/// Ограничивает ширину контента на широком окне и центрирует его.
class ContentFrame extends StatelessWidget {
  const ContentFrame({super.key, required this.child});

  static const maxWidth = 1040.0;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}

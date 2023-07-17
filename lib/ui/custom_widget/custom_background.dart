import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomBackground extends StatelessWidget {
  final Size size;

  const CustomBackground({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          transform: GradientRotation(-1 * math.pi / 6),
          colors: [
            Color(0xFFE778DB),
            Color(0xFFFAA7E6),
            Color(0xFFB5ADF6),
            Color(0xFF98A5FA),
            Color(0xFF7D7AE5)
          ],
          stops: [0.15, 0.5, 0.7, 0.89, 1],
        ),
      ),
    );
  }
}

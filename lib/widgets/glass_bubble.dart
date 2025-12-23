import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class GlassBubble extends StatelessWidget {
  final double size;
  final Widget child;
  final double blurStrength;
  final double borderWidth;

  const GlassBubble({
    Key? key,
    required this.size,
    required this.child,
    this.blurStrength = 10,
    this.borderWidth = 1.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: borderWidth,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.2),
            Colors.white.withOpacity(0.05),
          ],
        ),
      ),
      child: ClipOval(
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: blurStrength, sigmaY: blurStrength),
          child: Center(child: child),
        ),
      ),
    );
  }
}

import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class WaterAwareWidget extends StatelessWidget {
  final double waterLevel;
  final double elementHeight;
  final Widget child;

  const WaterAwareWidget({
    Key? key,
    required this.waterLevel,
    required this.elementHeight,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSubmerged = waterLevel > (1 - elementHeight);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isSubmerged ? Colors.blue.withOpacity(0.2) : Colors.transparent,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: isSubmerged ? 5 : 10,
            sigmaY: isSubmerged ? 5 : 10,
          ),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 400),
            opacity: isSubmerged ? 0.4 : 1.0,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                isSubmerged
                    ? Colors.blue.withOpacity(0.5)
                    : Colors.transparent,
                BlendMode.srcATop,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A comprehensive demo showcasing 8 variants of wave progress indicators
/// with customizable animations and interactive controls.
class WaveProgressDemo extends StatefulWidget {
  const WaveProgressDemo({Key? key}) : super(key: key);

  @override
  State<WaveProgressDemo> createState() => _WaveProgressDemoState();
}

class _WaveProgressDemoState extends State<WaveProgressDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  double _progress = 0.5;
  int _selectedVariant = 0;
  Color _waveColor = Colors.blue;
  double _waveHeight = 10.0;
  double _waveFrequency = 1.0;
  bool _showPercentage = true;

  final List<WaveVariantConfig> _variants = [
    WaveVariantConfig(
      name: 'Classic Single',
      layerCount: 1,
      colors: [Colors.blue],
      opacities: [0.8],
    ),
    WaveVariantConfig(
      name: 'Dual Wave',
      layerCount: 2,
      colors: [Colors.blue, Colors.lightBlue],
      opacities: [0.6, 0.4],
    ),
    WaveVariantConfig(
      name: 'Triple Wave',
      layerCount: 3,
      colors: [Colors.blue, Colors.lightBlue, Colors.cyan],
      opacities: [0.7, 0.5, 0.3],
    ),
    WaveVariantConfig(
      name: 'Ocean Waves',
      layerCount: 3,
      colors: [Colors.indigo, Colors.blue, Colors.teal],
      opacities: [0.8, 0.6, 0.4],
    ),
    WaveVariantConfig(
      name: 'Sunset Waves',
      layerCount: 3,
      colors: [Colors.orange, Colors.deepOrange, Colors.red],
      opacities: [0.7, 0.5, 0.3],
    ),
    WaveVariantConfig(
      name: 'Forest Waves',
      layerCount: 3,
      colors: [Colors.green, Colors.lightGreen, Colors.lime],
      opacities: [0.8, 0.6, 0.4],
    ),
    WaveVariantConfig(
      name: 'Purple Dream',
      layerCount: 3,
      colors: [Colors.purple, Colors.deepPurple, Colors.indigo],
      opacities: [0.7, 0.5, 0.3],
    ),
    WaveVariantConfig(
      name: 'Gradient Rainbow',
      layerCount: 3,
      colors: [Colors.pink, Colors.purple, Colors.blue],
      opacities: [0.6, 0.5, 0.4],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wave Progress Demo'),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Wave Progress Display
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Text(
                        _variants[_selectedVariant].name,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 300,
                        child: AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            return CustomPaint(
                              painter: WaveProgressPainter(
                                progress: _progress,
                                animation: _animationController.value,
                                variant: _variants[_selectedVariant],
                                waveHeight: _waveHeight,
                                waveFrequency: _waveFrequency,
                                showPercentage: _showPercentage,
                              ),
                              child: Container(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Variant Selector
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Wave Variant',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: List.generate(
                          _variants.length,
                          (index) => ChoiceChip(
                            label: Text(_variants[index].name),
                            selected: _selectedVariant == index,
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  _selectedVariant = index;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Progress Control
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Progress',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            '${(_progress * 100).toInt()}%',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      Slider(
                        value: _progress,
                        min: 0.0,
                        max: 1.0,
                        divisions: 100,
                        onChanged: (value) {
                          setState(() {
                            _progress = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Wave Height Control
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Wave Height',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            _waveHeight.toStringAsFixed(1),
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        ],
                      ),
                      Slider(
                        value: _waveHeight,
                        min: 5.0,
                        max: 30.0,
                        divisions: 50,
                        onChanged: (value) {
                          setState(() {
                            _waveHeight = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Wave Frequency Control
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Wave Frequency',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            _waveFrequency.toStringAsFixed(1),
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        ],
                      ),
                      Slider(
                        value: _waveFrequency,
                        min: 0.5,
                        max: 3.0,
                        divisions: 50,
                        onChanged: (value) {
                          setState(() {
                            _waveFrequency = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Toggle Controls
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SwitchListTile(
                        title: const Text('Show Percentage'),
                        value: _showPercentage,
                        onChanged: (value) {
                          setState(() {
                            _showPercentage = value;
                          });
                        },
                      ),
                      SwitchListTile(
                        title: const Text('Animation'),
                        value: _animationController.isAnimating,
                        onChanged: (value) {
                          setState(() {
                            if (value) {
                              _animationController.repeat();
                            } else {
                              _animationController.stop();
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Configuration for different wave variants
class WaveVariantConfig {
  final String name;
  final int layerCount;
  final List<Color> colors;
  final List<double> opacities;

  WaveVariantConfig({
    required this.name,
    required this.layerCount,
    required this.colors,
    required this.opacities,
  });
}

/// CustomPainter that renders 3-layer wave animation with progress
class WaveProgressPainter extends CustomPainter {
  final double progress;
  final double animation;
  final WaveVariantConfig variant;
  final double waveHeight;
  final double waveFrequency;
  final bool showPercentage;

  WaveProgressPainter({
    required this.progress,
    required this.animation,
    required this.variant,
    required this.waveHeight,
    required this.waveFrequency,
    required this.showPercentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw container background
    final backgroundPaint = Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.grey.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(12),
    );

    canvas.drawRRect(rect, backgroundPaint);

    // Calculate wave position based on progress
    final waveTop = size.height * (1 - progress);

    // Clip to container bounds
    canvas.clipRRect(rect);

    // Draw wave layers (up to 3 layers)
    final layersToRender = math.min(variant.layerCount, 3);
    for (int i = 0; i < layersToRender; i++) {
      _drawWaveLayer(
        canvas,
        size,
        waveTop,
        variant.colors[i % variant.colors.length],
        variant.opacities[i % variant.opacities.length],
        i,
      );
    }

    // Draw border after clipping
    canvas.drawRRect(rect, borderPaint);

    // Draw percentage text
    if (showPercentage) {
      _drawPercentageText(canvas, size);
    }
  }

  void _drawWaveLayer(
    Canvas canvas,
    Size size,
    double waveTop,
    Color color,
    double opacity,
    int layerIndex,
  ) {
    final paint = Paint()
      ..color = color.withOpacity(opacity)
      ..style = PaintingStyle.fill;

    final path = Path();

    // Phase shift for each layer to create offset effect
    final phaseShift = (layerIndex * math.pi / 3) + (animation * 2 * math.pi);

    // Start from bottom left
    path.moveTo(0, size.height);
    path.lineTo(0, waveTop);

    // Create wave curve
    final wavePoints = 100;
    for (int i = 0; i <= wavePoints; i++) {
      final x = (size.width / wavePoints) * i;
      final normalizedX = x / size.width;

      // Multi-frequency wave with harmonics
      final wave1 = math.sin((normalizedX * 2 * math.pi * waveFrequency) + phaseShift);
      final wave2 = math.sin((normalizedX * 4 * math.pi * waveFrequency) + phaseShift * 1.5) * 0.5;
      final wave3 = math.sin((normalizedX * 6 * math.pi * waveFrequency) + phaseShift * 2) * 0.25;

      final combinedWave = (wave1 + wave2 + wave3) / 1.75;
      final y = waveTop + (combinedWave * waveHeight);

      if (i == 0) {
        path.lineTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    // Complete the path
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  void _drawPercentageText(Canvas canvas, Size size) {
    final percentage = (progress * 100).toInt();
    final textSpan = TextSpan(
      text: '$percentage%',
      style: TextStyle(
        color: progress > 0.5 ? Colors.white : Colors.black87,
        fontSize: 48,
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(
            color: progress > 0.5 ? Colors.black26 : Colors.white54,
            offset: const Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    final offset = Offset(
      (size.width - textPainter.width) / 2,
      (size.height - textPainter.height) / 2,
    );

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(WaveProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.animation != animation ||
        oldDelegate.variant != variant ||
        oldDelegate.waveHeight != waveHeight ||
        oldDelegate.waveFrequency != waveFrequency ||
        oldDelegate.showPercentage != showPercentage;
  }
}

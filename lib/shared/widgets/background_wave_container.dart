import 'package:flutter/material.dart';

class BackgroundWaveContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;
  final double multiplier;

  const BackgroundWaveContainer({
    Key? key,
    this.width = double.infinity,
    this.height,
    this.child,
    this.multiplier = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BackgroundClipper(multiplier: multiplier),
      child: SizedBox(
        width: width,
        height: height,
        child: Center(child: child),
      ),
    );
  }
}

class BackgroundClipper extends CustomPainter {
  final double multiplier;

  @override
  BackgroundClipper({required this.multiplier});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    //TODO: Change maybe colors to theme
    paint.shader = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF68A8C9),
        Color(0xFF6B8EA0),
      ],
    ).createShader(Offset.zero & size);

    //Path created from SVG on https://www.flutterclutter.dev/tools/svg-to-flutter-path-converter/
    path = Path();
    path.lineTo(0, size.height * 0.05 * multiplier);
    path.cubicTo(
        size.width * 0.3, size.height * 0.1 * multiplier, size.width * 0.4, 0, size.width * 0.6, 0);
    path.cubicTo(size.width * 0.9, 0, size.width, size.height * 0.07 * multiplier, size.width,
        size.height * 0.07 * multiplier);
    path.cubicTo(size.width, size.height * 0.1 * multiplier, size.width, size.height, size.width,
        size.height);
    path.cubicTo(size.width, size.height, 0, size.height, 0, size.height);
    path.cubicTo(
        0, size.height, 0, size.height * 0.05 * multiplier, 0, size.height * 0.05 * multiplier);
    path.cubicTo(0, size.height * 0.05, 0, size.height * 0.05 * multiplier, 0,
        size.height * 0.05 * multiplier);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

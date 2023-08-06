import 'package:flutter/material.dart';

class AppBarWave extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  const AppBarWave({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Stack(
        children: [
          CustomPaint(
            painter: MyPainter(),
            child: Container(),
          ),
          AppBar(
            iconTheme: const IconThemeData(
              color: Colors.white,
              size: 32,
            ),
            title: Text(
              title ?? '',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 25);
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    paint.shader = const LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        Color(0xFF68A8C9),
        Color(0xFF6B8EA0),
      ],
    ).createShader(Offset.zero & size);

    path = Path();
    path.lineTo(0, size.height * 0.9);
    path.cubicTo(size.width * 0.2, size.height * 1.1, size.width * 0.4, size.height * 0.8,
        size.width * 0.6, size.height * 0.8);
    path.cubicTo(size.width * 0.9, size.height * 0.8, size.width, size.height * 1, size.width,
        size.height * 1);
    path.cubicTo(size.width, size.height * 0.9, size.width, 0, size.width, 0);
    path.cubicTo(size.width, 0, 0, 0, 0, 0);
    path.cubicTo(0, 0, 0, size.height * 0.9, 0, size.height * 0.9);
    path.cubicTo(0, size.height * 0.9, 0, size.height * 0.9, 0, size.height * 0.9);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

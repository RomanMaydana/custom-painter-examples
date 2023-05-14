import 'package:flutter/material.dart';
import 'dart:math' as math;

const PI = 3.1415926;

class DotsAnimationScreen extends StatefulWidget {
  const DotsAnimationScreen({super.key, required this.title});
  final String title;

  @override
  State<DotsAnimationScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DotsAnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = Tween<double>(begin: 0, end: PI + 9).animate(CurvedAnimation(
        parent: animationController, curve: Curves.easeInOutSine));

    animationController
        .forward()
        .whenComplete(() => animationController.repeat());
  }
  @override
  void deactivate() {
    animationController.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (_, __) {
          return CustomPaint(
            painter: DotsPainter(offset: animation.value),
          );
        });
  }
}

class DotsPainter extends CustomPainter {
  DotsPainter({required this.offset})
      : _paint = Paint()
          ..color = Colors.red
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.fill;
  final Paint _paint;
  final double offset;

  @override
  void paint(Canvas canvas, Size size) {
    double left = (offset > PI) ? PI : offset;
    final leftOffset =
        Offset(size.width / 4, size.height / 2 - 40 * math.sin(left));
    canvas.drawCircle(leftOffset, 20, _paint);

    double center = (offset - 1 > PI) ? PI : offset - 1;
    if (center < 0) {
      center = 0;
    }
    final centerOffset =
        Offset(size.width / 2, size.height / 2 - 40 * math.sin(center));
    canvas.drawCircle(centerOffset, 20, _paint);

    double right = offset - 2 < 0 ? 0 : offset - 2;
    if (right > PI) {
      right = PI;
    }
    final rightOffset =
        Offset(size.width * 3 / 4, size.height / 2 - 40 * math.sin(right));
    canvas.drawCircle(rightOffset, 20, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

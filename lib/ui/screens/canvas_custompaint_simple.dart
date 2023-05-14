import 'package:flutter/material.dart';

class CanvasCustomPaintSample extends StatelessWidget {
  const CanvasCustomPaintSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Canvas Custom Paint Sample'),
      ),
      body: Column(
        children: [
          Expanded(
              child: CustomPaint(
            painter: MyPainter(),
            child: Container(),
          )),
          Expanded(
              child: Container(
            color: Colors.blue,
          )),
          Expanded(
              child: Container(
            color: Colors.green,
            child: Switch(
              value: true,
              onChanged: (value) => null,
            ),
          )),
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.rotate(0.5);
    canvas.scale(1.2);
    canvas.drawRect(
        Rect.fromCenter(
            center: Offset(size.width / 2, size.height / 2),
            width: size.width / 2,
            height: size.height / 2),
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.fill);
    canvas.restore();
     canvas.drawRect(
        Rect.fromCenter(
            center: Offset(size.width / 4, size.height / 4),
            width: size.width / 2,
            height: size.height / 2),
        Paint()
          ..color = Colors.purple
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedDonutChart extends StatefulWidget {
  const AnimatedDonutChart({super.key});

  @override
  State<AnimatedDonutChart> createState() => _AnimatedDonutChartState();
}

class _AnimatedDonutChartState extends State<AnimatedDonutChart>
    with SingleTickerProviderStateMixin {
  late final _rotationController =
      AnimationController(vsync: this,upperBound: 2*pi);
  final _rotationDuration = const Duration(seconds: 1);
  @override
  void initState() {
    super.initState();
    _rotationController.duration = _rotationDuration;
  
      _rotationController.forward();
  }
@override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Donut Chart'),
      ),
      body: CustomPaint(
        painter: DonutPainter(rotation: _rotationController),
        child: const SizedBox.expand(),
      ),
    );
  }
}

final linePaint = Paint()
  ..color = Colors.white
  ..strokeWidth = 2
  ..style = PaintingStyle.stroke;

final midPaint = Paint()
  ..color = Colors.white
  ..style = PaintingStyle.fill;

const textCenterStyle =
    TextStyle(color: Colors.black38, fontWeight: FontWeight.bold, fontSize: 30);

const labelStyle =
    TextStyle(color: Colors.black, fontSize: 12);

class DonutPainter extends CustomPainter {
  DonutPainter({required this.rotation}) : super(repaint: rotation);
  final Animation<double> rotation;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final diameter = size.shortestSide;
    final rect =
        Rect.fromCenter(center: center, width: diameter, height: diameter);
    double startAngle = 0.0;
    for (var element in data) {
      double sweepAngle = drawSectors(element, canvas, rect, startAngle);
      drawLines(diameter, startAngle, center, canvas);
      drawLabels(
          canvas, center, diameter, startAngle, sweepAngle, element.label);
      startAngle += sweepAngle;
    }

    canvas.drawCircle(center, diameter * 0.3, midPaint);

    drawTextCentered(canvas, center, 'Favorite\nMovie\nGender', textCenterStyle,
        diameter * 0.6,(_) {
          
        },);
  }

  TextPainter measureText(
      String s, TextStyle style, double maxWidth, TextAlign align) {
    final span = TextSpan(text: s, style: style);
    final tp = TextPainter(
        text: span, textAlign: align, textDirection: TextDirection.ltr);

    tp.layout(minWidth: 0, maxWidth: maxWidth);
    return tp;
  }
  void drawLabels(Canvas canvas, Offset center, double diameter,
    double startAngle, double sweepAngle, String label) {
      final r = diameter/ 2.5;
      final dx = r * cos(startAngle + sweepAngle / 2);
      final dy = r * sin(startAngle + sweepAngle / 2);
      final position = center + Offset(dx, dy);
      drawTextCentered(canvas, position, label, labelStyle, 100.0, (Size sz){
        final rect = Rect.fromCenter(center: position, width: sz.width+ 5, height: sz.height+5);
        final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(5));
        canvas.drawRRect(rrect, midPaint);
      });

    }

  Size drawTextCentered(Canvas canvas, Offset position, String text,
      TextStyle style, double maxWidth, Function(Size) bgCb) {
    final tp = measureText(text, style, maxWidth, TextAlign.center);
    final ps = position + Offset(-tp.width / 2, -tp.height / 2);
    bgCb(tp.size);
    tp.paint(canvas, ps);
    return tp.size;
  }

  void drawLines(
      double diameter, double startAngle, Offset center, Canvas canvas) {
    final dx = diameter / 2 * cos(startAngle);
    final dy = diameter / 2 * sin(startAngle);
    final p2 = center + Offset(dx, dy);
    canvas.drawLine(center, p2, linePaint);
  }

  double drawSectors(
      DataItem element, Canvas canvas, Rect rect, double startAngle) {
    double sweepAngle = element.value * (rotation.value * 360 / (2*pi)) * pi / 180;
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = element.color;
    canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
    return sweepAngle;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}



const data = <DataItem>[
  DataItem(0.2, 'Comedy', Colors.red),
  DataItem(0.25, 'Action', Colors.brown),
  DataItem(0.3, 'Romance', Colors.green),
  DataItem(0.05, 'Drama', Colors.teal),
  DataItem(0.2, 'SciFi', Colors.pink),
];

class DataItem {
  const DataItem(this.value, this.label, this.color);

  final double value;
  final String label;
  final Color color;
}

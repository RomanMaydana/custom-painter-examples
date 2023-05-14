import 'dart:math';

import 'package:flutter/material.dart';

class CanvasPerformanceSample extends StatefulWidget {
  const CanvasPerformanceSample({super.key});

  @override
  State<CanvasPerformanceSample> createState() =>
      _CanvasPerformanceSampleState();
}

class _CanvasPerformanceSampleState extends State<CanvasPerformanceSample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Canvas Performance Sample'),
      ),
      body: Column(
        children: [
          Expanded(
              child: RepaintBoundary(
            child: CustomPaint(
              painter: MyPainter(),
              child: Container(),
            ),
          )),
          const CounterWidget()
        ],
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.white,
      child: Row(
        children: [
          ElevatedButton(
              onPressed: () => setState(() {
                    counter++;
                  }),
              child: const Text('Tap me')),
          const SizedBox(
            width: 100,
          ),
          Expanded(
              child: Text(
            counter.toString(),
            style: const TextStyle(color: Colors.black),
          ))
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final random = Random();
  final radius = 50.0;
  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < 100; i++) {
      final center = Offset(
          random.nextDouble() * size.width, random.nextDouble() * size.height);
      canvas.drawCircle(
          center,
          radius,
          Paint()
            ..color = Colors.primaries[random.nextInt(Colors.primaries.length)]
            ..style = PaintingStyle.fill);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

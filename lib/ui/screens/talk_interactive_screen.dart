import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';

class TalkInteractivePage extends StatefulWidget {
  const TalkInteractivePage({super.key});

  @override
  State<TalkInteractivePage> createState() => _TalkInteractivePageState();
}

class _TalkInteractivePageState extends State<TalkInteractivePage>
    with SingleTickerProviderStateMixin {
  late final _rotationController =
      AnimationController(vsync: this, upperBound: pi * 2);
  final _rotationDuration = const Duration(seconds: 20);

  @override
  void initState() {
    super.initState();
    _rotationController.duration = _rotationDuration;
    _rotationController.repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: RotationPainter(_rotationController),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class RotationPainter extends CustomPainter {
  RotationPainter(this.rotation) : super(repaint: rotation) {}
  final Animation<double> rotation;

  final Paint _paint = Paint()..color = const Color(0xffff33ff);
  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.shortestSide / 3;
    final center = Offset(size.width / 2, size.height / 2);
    const vertexCount = 10;

    final offsets = <Offset>[];
    offsets.add(center);
    for (var i = 0; i < vertexCount; i++) {
      final angle = (i / vertexCount) * 2 * pi;
      
      final x = cos(angle - rotation.value) * radius;
      final y = sin(angle - rotation.value) * radius;

      final offset = Offset(x, y);
      offsets.add(center + offset);
      // mark angle = 0
      if (i == 0) {
        // canvas.drawLine(center + offset * 1.1, center + offset * 1.2, _paint);
      }
    }

    final indices = <int>[];
    for (var i = 0; i < vertexCount - 1; i++) {
      indices.add(0);
      indices.add(1 + i);
      indices.add(1 + i + 1);
    }
    indices.addAll([0, vertexCount, 1]);
    final vertices = Vertices(
      VertexMode.triangles,
      offsets,
      indices: indices,
      colors: [
        Color(0xff000000),
        // Color(0xff00ff00),
        // Color(0xff00ff00),
        // Color(0xff00ff00),
        // Color(0xff00ff00),
        
      ]..addAll(List.generate(vertexCount, (index) => Color(0xff00ff00))),
    );

    canvas.drawVertices(vertices, BlendMode.dst, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ExamplePainter extends CustomPainter {
  ExamplePainter(this.rotation) : super(repaint: rotation);
  final Animation<double> rotation;

  final Paint _paint = Paint()..color = const Color(0xffff33ff);
  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.shortestSide / 3;
    final center = Offset(size.width / 2, size.height / 2);

    var vertices = Vertices(VertexMode.triangles, [
      center,
      center + Offset(100, 0),
      center + Offset(100, 100),
      center + Offset(0, 100)
    ], colors: [
      Color(0xff00ff00),
      Color(0xffff0000),
      Color(0xff0000ff),
      Color(0xffff00ff)
    ], indices: [
      0,
      2,
      3,
      1,
      2,
      3
    ]);
    final positions =
        Float32List.fromList([200, 200, 300, 200, 200, 300, 300, 300]);
    final indices = Uint16List(6);
    indices[0] = 0;
    indices[1] = 1;
    indices[2] = 2;
    indices[3] = 1;
    indices[4] = 2;
    indices[5] = 3;

    vertices = Vertices.raw(VertexMode.triangles, positions, indices: indices);

    canvas.drawVertices(vertices, BlendMode.src, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class ParticlesAnimationScreen extends StatelessWidget {
  const ParticlesAnimationScreen({super.key});

  Widget _buildListView() {
    final entries = <String>['A', 'B', 'C', 'D', 'E', 'F'];
    final colorCodes = <int>[600, 500, 400, 100, 600, 500];

    return ListView.separated(
        padding: const EdgeInsets.all(8),
        itemBuilder: (_, index) {
          return Container(
            height: 50,
            color: Colors.amber[colorCodes[index]],
            child: Center(
              child: Text('Entry ${entries[index]}'),
            ),
          );
        },
        separatorBuilder: (_, __) => const Divider(),
        itemCount: entries.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overlay Animation'),
      ),
      body: Container(
        child: Stack(
          children: [_buildListView(), const AnimationWidget()],
        ),
      ),
    );
  }
}

class AnimationWidget extends StatefulWidget {
  const AnimationWidget({super.key});

  @override
  State<AnimationWidget> createState() => _AnimationWidgetState();
}

class _AnimationWidgetState extends State<AnimationWidget>
    with SingleTickerProviderStateMixin {
  final particles = List<Particle>.generate(100, (_) => Particle());
  late final _movementController =
      AnimationController(vsync: this, upperBound: pi * 2);
  final _rotationDuration = const Duration(seconds: 20000);

  @override
  void initState() {
    super.initState();
    _movementController.duration = _rotationDuration;
    _movementController.forward();
  }

  @override
  void dispose() {
    _movementController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: CustomPaint(
        painter: MyPainter( _movementController,particles),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  MyPainter(
    this.movement, 
  this.particles) 
  : super(repaint: movement);
  final Animation<double> movement;
  final List<Particle> particles;

  final Paint _circlePaint = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.fill;
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide / 4;
    canvas.drawCircle(center, radius, _circlePaint);

    for (var particle in particles) {
      canvas.drawCircle(
          particle.pos, particle.radius, Paint()..style = PaintingStyle.fill .. color = particle.color);
        particle.pos += Offset(particle.dx, particle.dy);
      // print('particle.dx ${particle.pos.dx} -- particle.dy ${particle.pos.dy}');
      // final dx = center.dx - particle.pos.dx;
      // final dy = center.dy - particle.pos.dy;

      // if (dx == 0 && dy == 0) {
      //   continue;
      // }
      // final directionX = dx > 0? 1 : -1;
      // final directionY = dy > 0? 1: -1;

      // if (dx.abs() >= 1) {
      //   particle.dx += directionX;
      // } else {
      //   particle.dx += dx;
      // }

      // if (dy.abs() >= 1) {
      //   particle.dy += directionY;
      // } else {
      //   particle.dy += dy;
      // }

      // particle.pos = Offset(particle.dx, particle.dy);
    }
    // for (var particle in particles) {
    //   particle.pos += Offset(particle.dx, particle.dy);
    // }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Particle {
  Particle()
      : radius = Utils.range(3, 10),
        color = Colors.cyanAccent,
        pos = Offset(Utils.range(0, 400), Utils.range(0, 500)),
        dx = Utils.range(-0.1, 0.1),
        dy = Utils.range(-0.1, 0.1);

  final double radius;
  final Color color;
  Offset pos;
  double dx;
  double dy;
}

final rng = Random();

class Utils {
  static double range(double min, double max) =>
      rng.nextDouble() * (max - min) + min;
}

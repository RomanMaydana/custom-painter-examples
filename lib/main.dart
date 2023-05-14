import 'package:custom_painter_examples/ui/screens/canvas_performance_sample.dart';
import 'package:custom_painter_examples/ui/screens/canvas_render_object_sample.dart';
import 'package:custom_painter_examples/ui/screens/dots_animations_screen.dart';
import 'package:flutter/material.dart';

import 'ui/screens/animated_donut_chart.dart';
import 'ui/screens/canvas_custompaint_simple.dart';
import 'ui/screens/talk_interactive_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Canvas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
      home: const MyHomeScreen(),
    );
  }
}

class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Canvas/CustomPaint Performance'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(40),
          children: [
            ElevatedButton(
                onPressed: () {
                  push(context,
                      const DotsAnimationScreen(title: 'Dots Animations'));
                },
                child: const Text('Dots Animations')),
            ElevatedButton(
                onPressed: () {
                  push(context, const CanvasRenderObjectSample());
                },
                child: const Text('Canvas RenderObject Sample')),
            ElevatedButton(
                onPressed: () {
                  push(context, const CanvasCustomPaintSample());
                },
                child: const Text('Canvas CustomPaint')),
            ElevatedButton(
                onPressed: () {
                  push(context, const CanvasPerformanceSample());
                },
                child: const Text('Canvas Performance')),
            ElevatedButton(
                onPressed: () {
                  push(context, const TalkInteractivePage());
                },
                child: const Text('Talk Interactive Page')),
            ElevatedButton(
                onPressed: () {
                  push(context, const AnimatedDonutChart());
                },
                child: const Text('Animated Donut Chart'))
          ],
        ));
  }

  void push(BuildContext context, Widget child) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => child,
        ));
  }
}

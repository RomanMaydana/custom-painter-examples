import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CanvasRenderObjectSample extends StatelessWidget {
  const CanvasRenderObjectSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Canvas Render Object Sample'),
      ),
      body: Column(
        children: [
             MyRenderObjectWidget(
              child: Container(
            height: 100,
            width: 100,
          )),
          const Expanded(
              child: Center(
                  child: Text(
            'Roman',
            style: TextStyle(color: Colors.white),
          ))),
          Expanded(
              child: Container(
            color: Colors.blue,
          )),
          Expanded(
              child: Container(
            color: Colors.purple,
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

class MyRenderObjectWidget extends SingleChildRenderObjectWidget {
  const MyRenderObjectWidget({super.key, required this.child})
      : super(child: child);
  final Widget child;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MyRenderObject();
  }
}

class MyRenderObject extends RenderProxyBox {

  // @override
  // bool get isRepaintBoundary => true;
  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.save();
    context.canvas.rotate(0.3);
    context.canvas.translate(150, -50);
    context.canvas.drawRect(offset & size, Paint()..color = Colors.red);
    context.canvas.restore();
    super.paint(context, offset);
  }
}

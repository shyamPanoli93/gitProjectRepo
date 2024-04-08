import 'package:flutter/material.dart';

class MyCustomLinearProgressIndicator extends StatefulWidget {
  @override
  State<MyCustomLinearProgressIndicator> createState() => _MyCustomLinearProgressIndicatorState();
}

class _MyCustomLinearProgressIndicatorState extends State<MyCustomLinearProgressIndicator> with SingleTickerProviderStateMixin{

  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    controller.addStatusListener(statusListener);
    controller.forward();
  }

  statusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      controller.value = 0.0;
      controller.forward();
    }
  }

  @override
  void dispose() {
    controller.removeStatusListener(statusListener);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,// Set your desired color
            ),
            child: Center(
              child: AnimatedBuilder(
                  animation: controller.view,
                  builder: (context, snapshot) {
                    return ClipPath(
                      clipper: MyClipper(),
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.white,
                        child: CustomPaint(
                          painter: MyCustomPainter(controller.value),
                        ),
                      ),
                    );
                  }),
            ),
          )),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    Path path = Path();
    path.moveTo(w / 2, 0);
    path.lineTo(w / 2 - 20, 55);
    path.lineTo(w / 2, 55);
    path.lineTo(w / 2 - 20, h);
    path.lineTo(w / 2 + 20, 45);
    path.lineTo(w / 2, 45);
    path.lineTo(w / 2 + 20, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}

class MyCustomPainter extends CustomPainter {
  final double percentage;

  MyCustomPainter(this.percentage);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.fill;

    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height * percentage);

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

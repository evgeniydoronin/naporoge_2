import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../login/presentation/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startSplashScreenTimer() async {
    var _duration = const Duration(seconds: 3);
    return Timer(_duration, navigateToScreen);
  }

  void navigateToScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  void initState() {
    super.initState();

    startSplashScreenTimer();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Center(
        child: Container(
          child: SvgPicture.asset('assets/images/logo_splash.svg'),
        ),
      ),
      painter: PathPainter(),
    );
  }
}

class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;

    Paint paint = Paint();

    Paint paintBox = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Color(0xFF00A2FF);
    canvas.drawPath(mainBackground, paint);

    Path topTriangle = Path();
    topTriangle.moveTo(width, 0);
    topTriangle.lineTo(width / 1.8, height * 0.25);
    topTriangle.lineTo(width, height * 0.45);
    canvas.drawPath(topTriangle, paintBox);

    Path bottomTriangle = Path();
    bottomTriangle.moveTo(0, height * 0.55);
    bottomTriangle.lineTo(0, height);
    bottomTriangle.lineTo(width / 2.2, height * 0.75);
    canvas.drawPath(bottomTriangle, paintBox);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

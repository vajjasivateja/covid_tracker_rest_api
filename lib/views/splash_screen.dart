import 'dart:async';

import 'package:covid_tracker_rest_api/views/worls_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const WorldScreens()));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  late final AnimationController controller = AnimationController(duration: const Duration(seconds: 3), vsync: this)..repeat();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: controller,
              child: SizedBox(
                height: 200,
                width: 200,
                child: Center(
                  child: Image.asset("images/virus.png"),
                ),
              ),
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(angle: controller.value * 2.0 * math.pi, child: child);
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            const Align(alignment: Alignment.center, child: Text("Covid-19\nTracker", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)))
          ],
        ),
      ),
    );
  }
}

import 'package:cl_pgn_mobile/extensions/mediaquery.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Expanded(
                child: Image.asset(
                  'assets/images/splash-bg.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          Positioned(
            child: Padding(
              padding: EdgeInsets.all(
                context.mediaQuery.size.width * 0.25,
              ),
              child: Image.asset('assets/images/logo/logo-colored-square.png'),
            ),
          ),
        ],
      ),
    );
  }
}

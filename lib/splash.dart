import 'package:antivirus/onboarding.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((_) => {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => OnboardingScreen(),
            ),
          ),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade50,
      child: Image.asset("assets/images/ant.png"),
    );
  }
}

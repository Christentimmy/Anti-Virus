import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;

    return Scaffold(
      body: Center(
        // Wrap the Column with Center
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.03), // 3% padding horizontally
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/anim/success.json",
                  repeat: false,
                  width: screenWidth * 0.8,
                  height:
                      screenHeight * 0.5), // Adjust width based on screen width
              SizedBox(height: screenHeight * 0.02), // 2% of screen height
              Text(
                "Success, You can uninstall the app now",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  // fontSize: screenWidth * 0.05, // 5% of screen width
                ),
              ),
              SizedBox(height: screenHeight * 0.02), // 2% of screen height
            ],
          ),
        ),
      ),
    );
  }
}

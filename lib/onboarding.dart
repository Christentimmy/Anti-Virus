import 'package:antivirus/scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatelessWidget {
 const OnboardingScreen({super.key});

  // final List _onboarding = [
  //   [
  //     "assets/anim/intro1.json",
  //     "Unmatched Security",
  //     "Safeguard your data with industry-leading encryption and advanced security measures.",
  //   ],
  //   [
  //     "assets/anim/intro2.json",
  //     "Real-Time Malware Detection",
  //     "Stay protected with our cutting-edge malware detection and removal tools.",
  //   ],
  //   [
  //     "assets/anim/intro3.json",
  //     "Comprehensive Protection",
  //     "Experience peace of mind with our all-in-one security suite, designed to keep all your devices safe."
  //   ]
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/anim/intro1.json"),
            const Text(
              "Real-Time Malware Detection",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Stay protected with our cutting-edge malware detection",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScanScreen()),
                );
              },
              child: Container(
                width: 200,
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                ),
                child: const Text(
                  "Scan Now",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}


// ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const ScanScreen()),
//               );
//             },
//             child: const Text('Start Scan'),
//           ),
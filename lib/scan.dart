import 'dart:io';

import 'package:antivirus/color.dart';
import 'package:flutter/material.dart';
import 'package:antivirus/success_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';
import 'package:get/get.dart';

class ScanScreen extends StatefulWidget {
  final String fullName;
  final String email;

  const ScanScreen({Key? key, required this.fullName, required this.email})
      : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with TickerProviderStateMixin {
  List<Task> tasks = [];
  RxString statusText = "Optimizing".obs;
  final RxBool _isOperationComplete = false.obs;

  @override
  void initState() {
    super.initState();

    tasks = [
      Task(
          name: 'Cleanup',
          status: 'Optimizing system files...',
          details: '',
          isComplete: false,
          progress: 0.0),
      Task(
          name: 'Privacy',
          status: 'Scanning private data...',
          details: '',
          isComplete: false,
          progress: 0.0),
      Task(
          name: 'Security protection',
          status: 'Checking security...',
          details: '',
          isComplete: false,
          progress: 0.0),
      Task(
          name: 'General',
          status: 'Performing general optimization...',
          details: '',
          isComplete: false,
          progress: 0.0),
    ];
    startScan();
  }

  Future<void> startScan() async {
    _isOperationComplete.value = true;

    for (int i = 0; i < tasks.length; i++) {
      // Varying speeds example: Very slow -> Extremely slow -> Ultra slow
      for (double p = 0.0; p <= 1.0; p += 0.02) {
        // Further reduced step to slow down the progress increments
        if (p <= 0.4) {
          // Very slow speed
          await Future.delayed(const Duration(milliseconds: 1000));
        } else if (p > 0.4 && p <= 0.7) {
          // Extremely slow speed
          await Future.delayed(const Duration(milliseconds: 1500));
        } else {
          // Ultra slow speed
          await Future.delayed(const Duration(milliseconds: 2500));
        }
        setState(() {
          tasks[i].progress = p;
          tasks[i].details = getRandomDetails(tasks[i].name);
        });
      }
      setState(() {
        tasks[i].isComplete = true;
        tasks[i].status = '${i + 2} items optimized';
        tasks[i].details = ''; // Clear the details once the task is complete
      });
    }

    statusText.value = "Done";
    _isOperationComplete.value = false;
  }

  String getRandomDetails(String taskName) {
    List<String> detailsList = [
      'Checking files...',
      'Optimizing system performance...',
      'Cleaning up temporary files...',
      'Removing redundant files...',
      'Enhancing privacy settings...',
      'Updating security protocols...',
      'Finalizing optimizations...'
    ];
    detailsList.shuffle();
    return detailsList.first;
  }

  @override
  Widget build(BuildContext context) {
    final isMacOS = Platform.isMacOS;
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          if (isMacOS &&
              !isSmallScreen) // Show sidebar only on macOS and when screen width is larger than 600
            Expanded(
              flex: 1,
              child: Container(
                color: AppConfig.primaryColor, // Sidebar background color
                // Add your sidebar content here
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                            'assets/images/ant.png'), // Your user image
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Welcome, ${widget.fullName}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Email: ${widget.email}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Expanded(
            flex: isMacOS
                ? (isSmallScreen ? 4 : 3)
                : 4, // Adjust flex value based on macOS and screen width
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 250,
                    width: 250,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Lottie.asset(
                          "assets/anim/scan.json",
                          width: 250,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          "assets/images/ant.png",
                          width: 100,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          trailing: Icon(
                            tasks[index].isComplete
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color: tasks[index].isComplete
                                ? AppConfig.primaryColor
                                : Colors.white,
                          ),
                          title: Text(
                            tasks[index].name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: tasks[index].isComplete
                              ? null
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tasks[index].details,
                                      style: const TextStyle(
                                          color: Colors.white70, fontSize: 12),
                                    ),
                                    const SizedBox(height: 4),
                                    AnimatedProgressBar(
                                      value: tasks[index].progress,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      height: 3.0,
                                      color: AppConfig.primaryColor,
                                      backgroundColor: Colors.grey,
                                      curve: Curves.easeInOut,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      tasks[index].status,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: isSmallScreen,
                    child: const SizedBox(height: 20),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_isOperationComplete.value) {
                        Get.snackbar(
                          "Error",
                          "Chill, Operation in progress",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      } else {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const SuccessScreen(),
                          ),
                        );
                      }
                    },
                    child: Obx(
                      () => Text(
                        statusText.value,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Visibility(
                    visible: isSmallScreen,
                    child: const SizedBox(height: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Task {
  final String name;
  String status;
  String details;
  bool isComplete;
  double progress;

  Task({
    required this.name,
    required this.status,
    required this.details,
    this.isComplete = false,
    this.progress = 0.0,
  });
}

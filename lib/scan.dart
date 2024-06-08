import 'package:antivirus/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';
import 'package:get/get.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

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
      // Varying speeds example: Full speed -> 40% speed -> Slow -> 70% speed
      for (double p = 0.0; p <= 1.0; p += 0.1) {
        if (p <= 0.4) {
          // Full speed
          await Future.delayed(const Duration(milliseconds: 100));
        } else if (p > 0.4 && p <= 0.7) {
          // 40% speed
          await Future.delayed(const Duration(milliseconds: 500));
        } else {
          // Slow speed
          await Future.delayed(const Duration(milliseconds: 1500));
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 50),
            SizedBox(
              height: 250,
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
                      color:
                          tasks[index].isComplete ? Colors.blue : Colors.white,
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
                                duration: const Duration(milliseconds: 300),
                                width: MediaQuery.of(context).size.width * 0.6,
                                height: 3.0,
                                color: Colors.blue,
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_isOperationComplete.value) {
                  Get.snackbar(
                    "Error",
                    "Chill, Operation in prgress",
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
          ],
        ),
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

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Malware Scanner',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Malware Scanner'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScanScreen()),
            );
          },
          child: const Text('Start Scan'),
        ),
      ),
    );
  }
}

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  List<Task> tasks = [];
  String statusText = "Optimizing";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    tasks = [
      Task(name: 'Cleanup', status: 'Optimizing system files...', details: '', isComplete: false, progress: 0.0),
      Task(name: 'Privacy', status: 'Scanning private data...', details: '', isComplete: false, progress: 0.0),
      Task(name: 'Security protection', status: 'Checking security...', details: '', isComplete: false, progress: 0.0),
      Task(name: 'General', status: 'Performing general optimization...', details: '', isComplete: false, progress: 0.0),
    ];
    startScan();
  }

  Future<void> startScan() async {
    _controller.forward();

    for (int i = 0; i < tasks.length; i++) {
      for (double p = 0.0; p <= 1.0; p += 0.1) {
        await Future.delayed(Duration(milliseconds: 300));
        setState(() {
          tasks[i].progress = p;
          tasks[i].details = getRandomDetails(tasks[i].name);
        });
      }
      setState(() {
        tasks[i].isComplete = true;
        tasks[i].status = '${i + 2} items optimized';
        tasks[i].details = '';  // Clear the details once the task is complete
      });
    }

    setState(() {
      statusText = "Done";
    });
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
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            Lottie.asset(
              "assets/anim/scan.json",
              width: 250,
              height: 250,
              fit: BoxFit.cover,
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
                      color: tasks[index].isComplete ? Colors.blue : Colors.white,
                    ),
                    title: Text(
                      tasks[index].name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: tasks[index].isComplete
                        ? null
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tasks[index].details,
                                style: const TextStyle(color: Colors.white70),
                              ),
                              const SizedBox(height: 4),
                              AnimatedProgressBar(
                                value: tasks[index].progress,
                                duration: Duration(milliseconds: 300),
                                width: MediaQuery.of(context).size.width * 0.6,
                                height: 10.0,
                                color: Colors.blue,
                                backgroundColor: Colors.grey,
                                curve: Curves.easeInOut,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                tasks[index].status,
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // primary: Colors.green,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(statusText),
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

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
              MaterialPageRoute(builder: (context) => const ScanScreen()),
            );
          },
          child: const Text('Start Scan'),
        ),
      ),
    );
  }
}

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);

    tasks = [
      Task(name: 'Cleanup', status: '2 items optimized', isComplete: false),
      Task(name: 'Privacy', status: '1 item optimized', isComplete: false),
      Task(
          name: 'Security protection',
          status: 'Accessibility turned off',
          isComplete: false),
      Task(name: 'General', status: 'Pending...', isComplete: false),
    ];

    startScan();
  }

  void startScan() {
    _controller.forward().then((_) {
      setState(() {
        tasks[0].isComplete = true;
        tasks[1].isComplete = true;
        tasks[2].isComplete = true;
        tasks[3].isComplete = true;
      });
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        tasks[0].isComplete = true;
      });
    });
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        tasks[1].isComplete = true;
      });
    });
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        tasks[2].isComplete = true;
      });
    });
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        tasks[3].isComplete = true;
      });
    });
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
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                const SizedBox(height: 40),
              CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 13.0,
                animation: true,
                percent: _animation.value,
                center: Text(
                  "${(_animation.value * 100).round()}%",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.green,
              ),
              const SizedBox(height: 20),
              const Text(
                'Optimizing',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(
                        tasks[index].isComplete
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color:
                            tasks[index].isComplete ? Colors.green : Colors.white,
                      ),
                      title: Text(
                        tasks[index].name,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        tasks[index].status,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class Task {
  final String name;
  final String status;
  bool isComplete;

  Task({required this.name, required this.status, this.isComplete = false});
}

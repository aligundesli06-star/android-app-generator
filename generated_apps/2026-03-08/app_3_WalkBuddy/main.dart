import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WalkBuddy',
      useMaterial3: true,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const WalkBuddyHome(),
    );
  }
}

class WalkBuddyHome extends StatefulWidget {
  const WalkBuddyHome({Key? key}) : super(key: key);

  @override
  State<WalkBuddyHome> createState() => _WalkBuddyHomeState();
}

class _WalkBuddyHomeState extends State<WalkBuddyHome> {
  int _steps = 0;
  int _goal = 10000;
  bool _isTracking = false;
  List<int> _history = [];

  void _startTracking() {
    setState(() {
      _isTracking = true;
    });
    Future.delayed(const Duration(minutes: 1), () {
      if (_isTracking) {
        _addSteps(100);
      }
    });
  }

  void _stopTracking() {
    setState(() {
      _isTracking = false;
    });
  }

  void _addSteps(int steps) {
    setState(() {
      _steps += steps;
      if (_steps > _goal) {
        _steps = _goal;
      }
      _history.add(_steps);
    });
    if (_isTracking) {
      Future.delayed(const Duration(minutes: 1), () {
        if (_isTracking) {
          _addSteps(100);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WalkBuddy'),
        backgroundColor: Theme.of(context).colorScheme.accentColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      _steps.toString(),
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const Text('Steps Today'),
                    Text(
                      _goal.toString(),
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const Text('Goal'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _startTracking,
              child: const Text('Start Tracking'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _stopTracking,
              child: const Text('Stop Tracking'),
            ),
            const SizedBox(height: 16),
            _history.isEmpty
                ? const Text('No History')
                : Expanded(
                    child: ListView.builder(
                      itemCount: _history.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            'Day ${index + 1}',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          trailing: Text(
                            _history[index].toString(),
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add friends
        },
        tooltip: 'Add Friends',
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
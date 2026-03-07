```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const FitBuddyApp());
}

class FitBuddyApp extends StatelessWidget {
  const FitBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitBuddy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FitBuddyHome(),
    );
  }
}

class FitBuddyHome extends StatefulWidget {
  const FitBuddyHome({super.key});

  @override
  State<FitBuddyHome> createState() => _FitBuddyHomeState();
}

class _FitBuddyHomeState extends State<FitBuddyHome> {
  final List<String> _workoutPlans = ['Beginner', 'Intermediate', 'Advanced'];
  String? _selectedWorkoutPlan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FitBuddy'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Share progress
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Welcome to FitBuddy!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            DropdownButton(
              hint: const Text('Select Workout Plan'),
              value: _selectedWorkoutPlan,
              items: _workoutPlans.map((plan) {
                return DropdownMenuItem(
                  child: Text(plan),
                  value: plan,
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedWorkoutPlan = value as String?;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Start workout
              },
              child: const Text('Start Workout'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Progress:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text(
              '0 workouts completed',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Join a community:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Join community
              },
              child: const Text('Join Community'),
            ),
          ],
        ),
      ),
    );
  }
}
```
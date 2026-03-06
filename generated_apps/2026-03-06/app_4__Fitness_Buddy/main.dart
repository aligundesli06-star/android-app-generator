```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const FitnessBuddyApp());
}

class FitnessBuddyApp extends StatelessWidget {
  const FitnessBuddyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Buddy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const FitnessBuddyHome(),
    );
  }
}

class FitnessBuddyHome extends StatefulWidget {
  const FitnessBuddyHome({Key? key}) : super(key: key);

  @override
  State<FitnessBuddyHome> createState() => _FitnessBuddyHomeState();
}

class _FitnessBuddyHomeState extends State<FitnessBuddyHome> {
  int _currentIndex = 0;
  final List<Widget> _tabs = const [
    ExercisesTab(),
    FriendsTab(),
    ChallengesTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Buddy'),
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Exercises'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Friends'),
          BottomNavigationBarItem(icon: Icon(Icons.chair), label: 'Challenges'),
        ],
      ),
    );
  }
}

class ExercisesTab extends StatelessWidget {
  const ExercisesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ExerciseCard('Bench Press', 'Chest'),
        ExerciseCard('Squats', 'Legs'),
        ExerciseCard('Deadlifts', 'Back'),
        ExerciseCard('Bicep Curls', 'Arms'),
      ],
    );
  }
}

class FriendsTab extends StatelessWidget {
  const FriendsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        FriendCard('John Doe'),
        FriendCard('Jane Doe'),
        FriendCard('Bob Smith'),
        FriendCard('Alice Johnson'),
      ],
    );
  }
}

class ChallengesTab extends StatelessWidget {
  const ChallengesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ChallengeCard('Push-up Challenge', '100 push-ups in a week'),
        ChallengeCard('Running Challenge', 'Run 5K in 30 minutes'),
        ChallengeCard('Squat Challenge', '200 squats in a week'),
        ChallengeCard('Yoga Challenge', 'Practice yoga for 30 minutes daily'),
      ],
    );
  }
}

class ExerciseCard extends StatelessWidget {
  final String exercise;
  final String muscleGroup;

  const ExerciseCard(this.exercise, this.muscleGroup, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exercise,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(muscleGroup),
          ],
        ),
      ),
    );
  }
}

class FriendCard extends StatelessWidget {
  final String friend;

  const FriendCard(this.friend, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
            ),
            const SizedBox(width: 16),
            Text(friend),
          ],
        ),
      ),
    );
  }
}

class ChallengeCard extends StatelessWidget {
  final String challenge;
  final String description;

  const ChallengeCard(this.challenge, this.description, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              challenge,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(description),
          ],
        ),
      ),
    );
  }
}
```
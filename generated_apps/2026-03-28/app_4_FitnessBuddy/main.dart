import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitnessBuddy',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const FitnessBuddy(),
    );
  }
}

class FitnessBuddy extends StatefulWidget {
  const FitnessBuddy({Key? key}) : super(key: key);

  @override
  State<FitnessBuddy> createState() => _FitnessBuddyState();
}

class _FitnessBuddyState extends State<FitnessBuddy> {
  int _currentIndex = 0;
  String _language = 'English';
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: const [
            HomeScreen(),
            ProgressScreen(),
            SettingsScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new item functionality
        },
        tooltip: 'Add new item',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        children: [
          _buildCard(context, 'Workout', Icons.directions_run),
          _buildCard(context, 'Nutrition', Icons.food_bank),
          _buildCard(context, 'Meditation', Icons.meditation),
          _buildCard(context, 'Yoga', Icons.self_improvement),
        ],
      ),
    );
  }

  Card _buildCard(BuildContext context, String title, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildIndicator(context, 'Workout', 80),
              _buildIndicator(context, 'Nutrition', 60),
              _buildIndicator(context, 'Meditation', 40),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildIndicator(context, 'Yoga', 20),
              _buildIndicator(context, 'Run', 50),
              _buildIndicator(context, 'Bike', 30),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(BuildContext context, String title, int value) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 40,
          height: 40,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                strokeWidth: 4,
                backgroundColor: Colors.grey.shade200,
                value: value / 100,
              ),
              Center(
                child: Text(
                  '$value%',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _language = 'English';
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Dark Mode'),
              Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Language'),
              DropdownButton(
                value: _language,
                onChanged: (value) {
                  setState(() {
                    _language = value as String;
                  });
                },
                items: const [
                  DropdownMenuItem(child: Text('English'), value: 'English'),
                  DropdownMenuItem(child: Text('Turkish'), value: 'Turkish'),
                  DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
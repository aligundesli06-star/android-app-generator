import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const WaterReminderApp());
}

class WaterReminderApp extends StatefulWidget {
  const WaterReminderApp({Key? key}) : super(key: key);

  @override
  State<WaterReminderApp> createState() => _WaterReminderAppState();
}

class _WaterReminderAppState extends State<WaterReminderApp> {
  int _currentTabIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode
          ? ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.indigo,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
            ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentTabIndex,
          children: const [
            HomeScreen(),
            ProgressScreen(),
            SettingsScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentTabIndex,
          onTap: (index) {
            setState(() {
              _currentTabIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Progress',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _hydrationLevels = [
    'Low',
    'Moderate',
    'High',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Welcome to WaterReminder!',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.water,
                    size: 24,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Hydration Level:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Moderate',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Timer(const Duration(seconds: 1), () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Reminder to drink water!'),
                  ),
                );
              });
            },
            child: const Text('Drink Water Reminder'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('New reminder added!'),
                ),
              );
            },
            child: const Text('Add New Reminder'),
          ),
        ],
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text(
                'Water Intake:',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '80%',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text(
                'Days since last drink:',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '5',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Track Progress'),
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Dark Mode:',
                style: TextStyle(fontSize: 18),
              ),
              const Spacer(),
              Switch(
                value: (_WaterReminderAppState().context as Element).findAncestorStateOfType<_WaterReminderAppState>()._isDarkMode,
                onChanged: (value) {
                  (_WaterReminderAppState().context as Element).findAncestorStateOfType<_WaterReminderAppState>().setState(
                    () {
                      (_WaterReminderAppState().context as Element).findAncestorStateOfType<_WaterReminderAppState>()._isDarkMode = value;
                    },
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                'Language:',
                style: TextStyle(fontSize: 18),
              ),
              const Spacer(),
              DropdownButton(
                value: (_WaterReminderAppState().context as Element).findAncestorStateOfType<_WaterReminderAppState>()._language,
                onChanged: (String? value) {
                  (_WaterReminderAppState().context as Element).findAncestorStateOfType<_WaterReminderAppState>().setState(
                    () {
                      (_WaterReminderAppState().context as Element).findAncestorStateOfType<_WaterReminderAppState>()._language = value!;
                    },
                  );
                },
                items: const [
                  DropdownMenuItem(
                    child: Text('English'),
                    value: 'English',
                  ),
                  DropdownMenuItem(
                    child: Text('Turkish'),
                    value: 'Turkish',
                  ),
                  DropdownMenuItem(
                    child: Text('Spanish'),
                    value: 'Spanish',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
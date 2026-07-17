import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskMaster',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
              primarySwatch: Colors.indigo,
            )
          : ThemeData.light().copyWith(
              primarySwatch: Colors.indigo,
            ),
      home: const MyHomePage(),
      routes: {
        '/settings': (context) => SettingsPage(
              isDarkMode: _isDarkMode,
              language: _language,
              onChanged: (val) {
                setState(() {
                  _isDarkMode = val;
                });
              },
              onLanguageChanged: (val) {
                setState(() {
                  _language = val;
                });
              },
            ),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final _screens = [
    HomeScreen(),
    ProgressScreen(),
    const Center(child: Text('Settings')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskMaster'),
      ),
      body: _screens[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new item
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (index) {
          if (index == 2) {
            Navigator.pushNamed(context, '/settings');
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        children: [
          _buildCard(
            context,
            Icons.calendar_today,
            'Calendar',
            'View your tasks in a calendar',
          ),
          _buildCard(
            context,
            Icons.reminders,
            'Reminders',
            'Get notified about upcoming tasks',
          ),
          _buildCard(
            context,
            Icons.bar_chart,
            'Progress',
            'Track your progress and stay motivated',
          ),
          _buildCard(
            context,
            Icons.list,
            'Task List',
            'View and manage your tasks',
          ),
        ],
      ),
    );
  }

  Card _buildCard(BuildContext context, IconData icon, String title, String description) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 40),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(description),
          ],
        ),
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              _buildIndicator(context, Icons.circle, 'Completed', 50),
              const SizedBox(width: 16),
              _buildIndicator(context, Icons.circle, 'In Progress', 25),
              const SizedBox(width: 16),
              _buildIndicator(context, Icons.circle, 'Not Started', 25),
            ],
          ),
          const SizedBox(height: 16),
          _buildIndicator(context, Icons.bar_chart, 'Overall Progress', 75),
        ],
      ),
    );
  }

  Widget _buildIndicator(BuildContext context, IconData icon, String title, double percentage) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).primaryColor),
        const SizedBox(height: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 50,
          height: 10,
          child: LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.grey.shade300,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}

class SettingsPage extends StatelessWidget {
  final bool isDarkMode;
  final String language;
  final Function(bool) onChanged;
  final Function(String) onLanguageChanged;

  const SettingsPage({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.onChanged,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Dark Mode'),
                const Spacer(),
                Switch(
                  value: isDarkMode,
                  onChanged: (val) {
                    onChanged(val);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Language'),
                const Spacer(),
                DropdownButton(
                  value: language,
                  onChanged: (String? val) {
                    onLanguageChanged(val!);
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
      ),
    );
  }
}
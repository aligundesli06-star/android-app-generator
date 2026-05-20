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
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
              primarySwatch: Colors.indigo,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
            ),
      home: Scaffold(
        body: _buildBody(),
        bottomNavigationBar: _buildBottomNavigation(),
        floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const ProgressScreen();
      case 2:
        return SettingsScreen(
          isDarkMode: _isDarkMode,
          language: _language,
          onDarkModeChanged: (value) => setState(() {
            _isDarkMode = value;
          }),
          onLanguageChanged: (value) => setState(() {
            _language = value;
          }),
        );
      default:
        return const Center(child: Text('Unknown screen'));
    }
  }

  BottomNavigationBar _buildBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
      onTap: (index) => setState(() {
        _currentIndex = index;
      }),
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        // Add new item logic
      },
      child: const Icon(Icons.add),
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
        childAspectRatio: 1,
        children: [
          _buildCard(
            context,
            title: 'Task 1',
            subtitle: 'Work for 25 minutes',
            icon: Icon(Icons.work),
          ),
          _buildCard(
            context,
            title: 'Task 2',
            subtitle: 'Break for 5 minutes',
            icon: Icon(Icons.breakfast_dining),
          ),
          _buildCard(
            context,
            title: 'Task 3',
            subtitle: 'Work for 25 minutes',
            icon: Icon(Icons.work),
          ),
          _buildCard(
            context,
            title: 'Task 4',
            subtitle: 'Break for 5 minutes',
            icon: Icon(Icons.breakfast_dining),
          ),
        ],
      ),
    );
  }

  Card _buildCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required Widget icon,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon,
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium,
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
            children: [
              _buildIndicator(
                context,
                color: Colors.green,
                value: 0.8,
              ),
              const SizedBox(width: 8),
              Text(
                'Work',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildIndicator(
                context,
                color: Colors.red,
                value: 0.2,
              ),
              const SizedBox(width: 8),
              Text(
                'Break',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(
    BuildContext context, {
    required Color color,
    required double value,
  }) {
    return Container(
      height: 8,
      width: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      child: FractionallySizedBox(
        widthFactor: value,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final String language;
  final void Function(bool) onDarkModeChanged;
  final void Function(String) onLanguageChanged;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.onDarkModeChanged,
    required this.onLanguageChanged,
  }) : super(key: key);

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
              const Text('Dark mode'),
              const SizedBox(width: 8),
              Switch(
                value: widget.isDarkMode,
                onChanged: widget.onDarkModeChanged,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 8),
              DropdownButton(
                value: widget.language,
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
                onChanged: widget.onLanguageChanged,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
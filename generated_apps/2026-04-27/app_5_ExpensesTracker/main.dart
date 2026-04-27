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
      title: 'ExpensesTracker',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
              primarySwatch: Colors.indigo,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
            ),
      home: Scaffold(
        body: [
          const HomeScreen(),
          const ProgressScreen(),
          const SettingsScreen(),
        ][_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(
              () {
                _currentIndex = index;
              },
            );
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
        floatingActionButton: _currentIndex == 0
            ? FloatingActionButton(
                onPressed: () {},
                tooltip: 'Add',
                child: const Icon(Icons.add),
              )
            : null,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.8,
        children: [
          _BuildCard(
            icon: Icons.food_bank,
            title: 'Food',
            subtitle: '100\$',
          ),
          _BuildCard(
            icon: Icons.directions_car,
            title: 'Transportation',
            subtitle: '50\$',
          ),
          _BuildCard(
            icon: Icons.shopping_bag,
            title: 'Shopping',
            subtitle: '200\$',
          ),
          _BuildCard(
            icon: Icons.miscellaneous_services,
            title: 'Miscellaneous',
            subtitle: '150\$',
          ),
        ],
      ),
    );
  }
}

class _BuildCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _BuildCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
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
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _BuildProgress(
                  title: 'Food',
                  percent: 0.2,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _BuildProgress(
                  title: 'Transportation',
                  percent: 0.1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _BuildProgress(
                  title: 'Shopping',
                  percent: 0.4,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _BuildProgress(
                  title: 'Miscellaneous',
                  percent: 0.3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BuildProgress extends StatelessWidget {
  final String title;
  final double percent;

  const _BuildProgress({
    Key? key,
    required this.title,
    required this.percent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: percent,
            ),
          ],
        ),
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
  bool _isDarkMode = false;
  String _language = 'English';

  void _toggleDarkMode() {
    setState(
      () {
        _isDarkMode = !_isDarkMode;
      },
    );
  }

  void _changeLanguage(String language) {
    setState(
      () {
        _language = language;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ListTile(
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: _isDarkMode,
              onChanged: (value) {
                _toggleDarkMode();
              },
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            title: const Text('Language'),
            trailing: DropdownButton(
              value: _language,
              onChanged: (String? value) {
                _changeLanguage(value!);
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
          ),
        ],
      ),
    );
  }
}
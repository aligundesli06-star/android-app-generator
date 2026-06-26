import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TravelPlannerApp();
  }
}

class TravelPlannerApp extends StatefulWidget {
  const TravelPlannerApp({Key? key}) : super(key: key);

  @override
  State<TravelPlannerApp> createState() => _TravelPlannerAppState();
}

class _TravelPlannerAppState extends State<TravelPlannerApp> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  Locale _locale = const Locale('en');

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _selectLanguage(String languageCode) {
    setState(() {
      _locale = Locale(languageCode);
    });
  }

  final List<Travel> _travels = [];

  void _addTravel() {
    setState(() {
      _travels.add(Travel('New Travel', 'New Destination'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Planner',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo)
          : ThemeData.light().copyWith(primarySwatch: Colors.indigo),
      locale: _locale,
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(travels: _travels),
            ProgressScreen(),
            SettingsScreen(
              onToggleDarkMode: _toggleDarkMode,
              isDarkMode: _isDarkMode,
              onSelectLanguage: _selectLanguage,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icons.home,
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icons.bar_chart,
              label: 'Progress',
            ),
            BottomNavigationBarItem(
              icon: Icons.settings,
              label: 'Settings',
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addTravel,
          tooltip: 'Add Travel',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Travel {
  final String title;
  final String destination;

  Travel(this.title, this.destination);
}

class HomeScreen extends StatelessWidget {
  final List<Travel> travels;

  const HomeScreen({Key? key, required this.travels}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: travels.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 8.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.flight,
                    size: 32.0,
                  ),
                  const SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        travels[index].title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(travels[index].destination),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
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
              Expanded(
                child: Container(
                  height: 16.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              const Text('50%'),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 16.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              const Text('25%'),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final Function onToggleDarkMode;
  final bool isDarkMode;
  final Function onSelectLanguage;

  const SettingsScreen({
    Key? key,
    required this.onToggleDarkMode,
    required this.isDarkMode,
    required this.onSelectLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark Mode'),
              const Spacer(),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  onToggleDarkMode();
                },
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              const Text('Language'),
              const Spacer(),
              DropdownButton(
                items: [
                  DropdownMenuItem(
                    child: const Text('English'),
                    value: 'en',
                  ),
                  DropdownMenuItem(
                    child: const Text('Turkish'),
                    value: 'tr',
                  ),
                  DropdownMenuItem(
                    child: const Text('Spanish'),
                    value: 'es',
                  ),
                ],
                onChanged: (value) {
                  onSelectLanguage(value);
                },
                value: Locale('en').languageCode,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
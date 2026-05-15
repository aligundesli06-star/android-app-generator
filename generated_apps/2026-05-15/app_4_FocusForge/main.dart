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
      title: 'FocusForge',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
      ),
      themeMode: ThemeMode.light,
      home: const MyHomePage(),
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
  bool _isDarkMode = false;
  String _locale = 'en';

  final List<String> _locales = ['en', 'tr', 'es'];
  final List<String> _localeNames = ['English', 'Turkish', 'Spanish'];

  final List<FocusItem> _items = [
    FocusItem(icon: Icons.focus, title: 'Focus Time', description: 'Stay focused for 25 minutes'),
    FocusItem(icon: Icons.break_time, title: 'Break Time', description: 'Take a 5-minute break'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FocusForge'),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        tooltip: 'Add new item',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: const Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: const Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeScreen();
      case 1:
        return _buildProgressScreen();
      case 2:
        return _buildSettingsScreen();
      default:
        return const Center(
          child: Text('404'),
        );
    }
  }

  Widget _buildHomeScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(_items[index].icon, size: 32),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _items[index].title,
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        _items[index].description,
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
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

  Widget _buildProgressScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text('Progress', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildProgressIndicator(0.2),
              const SizedBox(width: 16),
              _buildProgressIndicator(0.5),
              const SizedBox(width: 16),
              _buildProgressIndicator(0.8),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(double value) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 64 * value,
          height: 64 * value,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(32),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark Mode'),
              const SizedBox(width: 16),
              Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                    ThemeMode themeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
                    (context as Element).owner!.buildOwner!.scheduleBuildFor(context);
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 16),
              DropdownButton(
                value: _locale,
                onChanged: (value) {
                  setState(() {
                    _locale = value as String;
                  });
                },
                items: _locales.map((locale) {
                  return DropdownMenuItem(
                    value: locale,
                    child: Text(_localeNames[_locales.indexOf(locale)]),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _addItem() {
    setState(() {
      _items.insert(0, FocusItem(icon: Icons.check, title: 'New Item', description: 'New item description'));
    });
  }
}

class FocusItem {
  final IconData icon;
  final String title;
  final String description;

  FocusItem({required this.icon, required this.title, required this.description});
}
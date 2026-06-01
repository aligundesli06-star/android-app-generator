import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: const MyHomePage(),
    );
  }
}

class ThemeModel with ChangeNotifier {
  bool _isDark = false;
  Locale? _locale;

  bool get isDark => _isDark;
  Locale? get locale => _locale;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }

  void setLocale(Locale? locale) {
    _locale = locale;
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeModel = context.watch<ThemeModel>();
    return MaterialApp(
      locale: themeModel.locale,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      themeMode: themeModel.isDark ? ThemeMode.dark : ThemeMode.light,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    const LessonsScreen(),
    const ProgressScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add new item')),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class LessonsScreen extends StatelessWidget {
  const LessonsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1,
        children: [
          _buildCard(
            context,
            'Lesson 1',
            Icons.book,
            'Learn the basics of the language',
          ),
          _buildCard(
            context,
            'Lesson 2',
            Icons.pencil,
            'Practice writing and speaking',
          ),
          _buildCard(
            context,
            'Lesson 3',
            Icons.headphones,
            'Improve your listening skills',
          ),
        ],
      ),
    );
  }

  Card _buildCard(
    BuildContext context,
    String title,
    IconData icon,
    String description,
  ) {
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
            Icon(
              icon,
              size: 32,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(description),
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
              const Text('Lessons completed:'),
              const SizedBox(width: 16),
              const Text('3/10'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Time spent:'),
              const SizedBox(width: 16),
              const Text('2 hours'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Score:'),
              const SizedBox(width: 16),
              const Text('80%'),
            ],
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
  bool _isDark = false;
  Locale? _locale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final themeModel = context.watch<ThemeModel>();
    _isDark = themeModel.isDark;
    _locale = themeModel.locale;
  }

  @override
  Widget build(BuildContext context) {
    final themeModel = context.watch<ThemeModel>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark mode:'),
              const SizedBox(width: 16),
              Switch(
                value: _isDark,
                onChanged: (bool value) {
                  setState(() {
                    _isDark = value;
                  });
                  themeModel.toggleTheme();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language:'),
              const SizedBox(width: 16),
              DropdownButton(
                value: _locale,
                onChanged: (Locale? value) {
                  setState(() {
                    _locale = value;
                  });
                  themeModel.setLocale(value);
                },
                items: [
                  DropdownMenuItem(
                    child: const Text('English'),
                    value: const Locale('en'),
                  ),
                  DropdownMenuItem(
                    child: const Text('Turkish'),
                    value: const Locale('tr'),
                  ),
                  DropdownMenuItem(
                    child: const Text('Spanish'),
                    value: const Locale('es'),
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
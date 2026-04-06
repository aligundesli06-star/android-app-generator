import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicTheme();
  }
}

class DynamicTheme extends StatefulWidget {
  @override
  State<DynamicTheme> createState() => _DynamicThemeState();
}

class _DynamicThemeState extends State<DynamicTheme> {
  Locale _locale = const Locale('en');
  bool _isDark = false;

  void setTheme() {
    setState(() {
      _isDark = !_isDark;
    });
  }

  void changeLocale(String locale) {
    setState(() {
      _locale = locale == 'en'
          ? const Locale('en')
          : locale == 'tr'
              ? const Locale('tr')
              : const Locale('es');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      title: 'Mood Journal',
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
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
  List<Mood> _moods = [];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _addMood() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Mood'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _moods.add(Mood(
                title: 'New Mood',
                description: 'New description',
                date: DateTime.now(),
              ));
              setState(() {});
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0
          ? HomeScreen(_moods)
          : _currentIndex == 1
              ? ProgressScreen(_moods)
              : SettingsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
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
      floatingActionButton: FloatingActionButton(
        onPressed: _addMood,
        tooltip: 'Add Mood',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Mood {
  String title;
  String description;
  DateTime date;

  Mood({
    required this.title,
    required this.description,
    required this.date,
  });
}

class HomeScreen extends StatelessWidget {
  final List<Mood> _moods;

  const HomeScreen(this._moods, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: _moods.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.sentiment_satisfied),
                      const SizedBox(width: 16),
                      Text(
                        _moods[index].title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(_moods[index].description),
                  const SizedBox(height: 16),
                  Text(_moods[index].date.toString()),
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
  final List<Mood> _moods;

  const ProgressScreen(this._moods, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.bar_chart),
              const SizedBox(width: 16),
              Text(
                'Progress',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Column(
                children: [
                  const Text('Good'),
                  const Text('5'),
                ],
              ),
              const SizedBox(width: 32),
              Column(
                children: [
                  const Text('Bad'),
                  const Text('3'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDark = false;
  String _language = 'en';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.settings),
              const SizedBox(width: 16),
              Text(
                'Settings',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Dark Mode'),
              const SizedBox(width: 16),
              Switch(
                value: _isDark,
                onChanged: (bool value) {
                  setState(() {
                    _isDark = value;
                  });
                  (context as Element).ancestorWidgetOfExactType<DynamicTheme>()!.setState(() {
                    (context as Element).ancestorWidgetOfExactType<DynamicTheme>()!._isDark = value;
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
              DropdownButton<String>(
                value: _language,
                onChanged: (String? value) {
                  setState(() {
                    _language = value ?? 'en';
                  });
                  (context as Element).ancestorWidgetOfExactType<DynamicTheme>()!.setState(() {
                    if (_language == 'en') {
                      (context as Element).ancestorWidgetOfExactType<DynamicTheme>()!._locale = const Locale('en');
                    } else if (_language == 'tr') {
                      (context as Element).ancestorWidgetOfExactType<DynamicTheme>()!._locale = const Locale('tr');
                    } else {
                      (context as Element).ancestorWidgetOfExactType<DynamicTheme>()!._locale = const Locale('es');
                    }
                  });
                },
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
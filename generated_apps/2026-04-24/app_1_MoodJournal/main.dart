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
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void _changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoodJournal',
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      locale: _locale,
      localizationsDelegates: const [
        DefaultMaterialLocalizations(),
        DefaultWidgetsLocalizations(),
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('tr'),
        Locale('es'),
      ],
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
  final List<Mood> _moods = [];

  void _addMood() {
    setState(() {
      _moods.add(Mood(
        DateTime.now(),
        'Happy',
        'Today was a great day!',
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(
            moods: _moods,
          ),
          ProgressScreen(
            moods: _moods,
          ),
          SettingsScreen(
            onThemeToggle: () {
              (context as Element).ancestorWidgetOfExactType<_MyAppState>()!._toggleTheme();
            },
            onLocaleChange: (locale) {
              (context as Element).ancestorWidgetOfExactType<_MyAppState>()!._changeLocale(locale);
            },
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
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Mood {
  final DateTime date;
  final String emotion;
  final String note;

  Mood(this.date, this.emotion, this.note);
}

class HomeScreen extends StatelessWidget {
  final List<Mood> moods;

  const HomeScreen({Key? key, required this.moods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: moods.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.date_range,
                        size: 24,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        '${moods[index].date.year}-${moods[index].date.month}-${moods[index].date.day}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.emotions,
                        size: 24,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        moods[index].emotion,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    moods[index].note,
                    style: Theme.of(context).textTheme.titleLarge,
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
  final List<Mood> moods;

  const ProgressScreen({Key? key, required this.moods}) : super(key: key);

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
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      'Happy: ${moods.where((m) => m.emotion == 'Happy').length}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      'Sad: ${moods.where((m) => m.emotion == 'Sad').length}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      'Neutral: ${moods.where((m) => m.emotion == 'Neutral').length}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      'Angry: ${moods.where((m) => m.emotion == 'Angry').length}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final void Function() onThemeToggle;
  final void Function(Locale) onLocaleChange;

  const SettingsScreen({Key? key, required this.onThemeToggle, required this.onLocaleChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ListTile(
            title: const Text(
              'Dark Mode',
              style: TextStyle(fontSize: 18),
            ),
            trailing: Switch(
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (value) {
                onThemeToggle();
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ListTile(
            title: const Text(
              'Language',
              style: TextStyle(fontSize: 18),
            ),
            trailing: DropdownButton<Locale>(
              value: context.locale,
              onChanged: (locale) {
                onLocaleChange(locale!);
              },
              items: const [
                DropdownMenuItem(
                  child: Text('English'),
                  value: Locale('en'),
                ),
                DropdownMenuItem(
                  child: Text('Turkish'),
                  value: Locale('tr'),
                ),
                DropdownMenuItem(
                  child: Text('Spanish'),
                  value: Locale('es'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
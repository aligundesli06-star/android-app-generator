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
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');

  void _changeThemeMode() {
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
      title: 'Mood Journal',
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      locale: _locale,
      supportedLocales: const [Locale('en'), Locale('tr'), Locale('es')],
      home: MyHomePage(
        currentIndex: _currentIndex,
        themeMode: _themeMode,
        locale: _locale,
        onChangeThemeMode: _changeThemeMode,
        onChangeLocale: _changeLocale,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final int currentIndex;
  final ThemeMode themeMode;
  final Locale locale;
  final VoidCallback onChangeThemeMode;
  final ValueChanged<Locale> onChangeLocale;

  const MyHomePage({
    Key? key,
    required this.currentIndex,
    required this.themeMode,
    required this.locale,
    required this.onChangeThemeMode,
    required this.onChangeLocale,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<MoodItem> _moodItems = [
    MoodItem('Happy', 'I had a good day', Icons.sentiment_very_satisfied),
    MoodItem('Sad', 'I had a bad day', Icons.sentiment_very_dissatisfied),
    MoodItem('Neutral', 'I had a normal day', Icons.sentiment_neutral),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: widget.currentIndex,
        children: [
          HomeScreen(
            moodItems: _moodItems,
          ),
          ProgressScreen(
            moodItems: _moodItems,
          ),
          SettingsScreen(
            themeMode: widget.themeMode,
            locale: widget.locale,
            onChangeThemeMode: widget.onChangeThemeMode,
            onChangeLocale: widget.onChangeLocale,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: (index) {
          setState(() {
            widget.currentIndex = index;
          });
        },
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addMoodItem();
        },
        tooltip: 'Add Mood Item',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addMoodItem() {
    showDialog(
      context: context,
      builder: (context) {
        final _controller = TextEditingController();
        return AlertDialog(
          title: const Text('Add Mood Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Mood',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.sentiment_very_satisfied),
                    onPressed: () {
                      setState(() {
                        _moodItems.add(MoodItem(_controller.text, '', Icons.sentiment_very_satisfied));
                      });
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.sentiment_very_dissatisfied),
                    onPressed: () {
                      setState(() {
                        _moodItems.add(MoodItem(_controller.text, '', Icons.sentiment_very_dissatisfied));
                      });
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.sentiment_neutral),
                    onPressed: () {
                      setState(() {
                        _moodItems.add(MoodItem(_controller.text, '', Icons.sentiment_neutral));
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<MoodItem> moodItems;

  const HomeScreen({
    Key? key,
    required this.moodItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: moodItems.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    moodItems[index].icon,
                    size: 32,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        moodItems[index].title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        moodItems[index].description,
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
}

class ProgressScreen extends StatelessWidget {
  final List<MoodItem> moodItems;

  const ProgressScreen({
    Key? key,
    required this.moodItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.sentiment_very_satisfied,
                size: 32,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 16),
              Text(
                'Happy: ${moodItems.where((item) => item.icon == Icons.sentiment_very_satisfied).length}',
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.sentiment_very_dissatisfied,
                size: 32,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 16),
              Text(
                'Sad: ${moodItems.where((item) => item.icon == Icons.sentiment_very_dissatisfied).length}',
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.sentiment_neutral,
                size: 32,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 16),
              Text(
                'Neutral: ${moodItems.where((item) => item.icon == Icons.sentiment_neutral).length}',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final ThemeMode themeMode;
  final Locale locale;
  final VoidCallback onChangeThemeMode;
  final ValueChanged<Locale> onChangeLocale;

  const SettingsScreen({
    Key? key,
    required this.themeMode,
    required this.locale,
    required this.onChangeThemeMode,
    required this.onChangeLocale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Theme: '),
              Switch(
                value: themeMode == ThemeMode.dark,
                onChanged: (value) {
                  if (value) {
                    onChangeThemeMode();
                  } else {
                    onChangeThemeMode();
                  }
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text('Language: '),
              DropdownButton(
                value: locale,
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
                onChanged: (Locale? value) {
                  onChangeLocale(value!);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MoodItem {
  final String title;
  final String description;
  final IconData icon;

  MoodItem(this.title, this.description, this.icon);
}
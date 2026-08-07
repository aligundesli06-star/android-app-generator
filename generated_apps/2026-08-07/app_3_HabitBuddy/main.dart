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
  _DynamicThemeState createState() => _DynamicThemeState();
}

class _DynamicThemeState extends State<DynamicTheme> {
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(),
      supportedLocales: const [
        Locale('en'),
        Locale('tr'),
        Locale('es'),
      ],
    );
  }

  void setTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const HomeScreen(),
    const ProgressScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
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
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Habit Name',
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Habit Description',
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: null,
                      child: Text('Add Habit'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
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
        childAspectRatio: 1.5,
        children: [
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.directions_walk,
                    size: 48,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Walking',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text('30 minutes/day'),
                ],
              ),
            ),
          ),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.pool,
                    size: 48,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Swimming',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text('2 times/week'),
                ],
              ),
            ),
          ),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.local_grocery_store,
                    size: 48,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Shopping',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text('1 time/week'),
                ],
              ),
            ),
          ),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.book,
                    size: 48,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Reading',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text('1 book/month'),
                ],
              ),
            ),
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
            children: const [
              Icon(Icons.directions_walk),
              Text('Walking: 50%'),
            ],
          ),
          Row(
            children: const [
              Icon(Icons.pool),
              Text('Swimming: 75%'),
            ],
          ),
          Row(
            children: const [
              Icon(Icons.local_grocery_store),
              Text('Shopping: 25%'),
            ],
          ),
          Row(
            children: const [
              Icon(Icons.book),
              Text('Reading: 90%'),
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
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  String? _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = 'English';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Dark Mode',
                style: TextStyle(fontSize: 18),
              ),
              const Spacer(),
              Switch(
                value: _isDarkMode,
                onChanged: (bool value) {
                  setState(() {
                    _isDarkMode = value;
                    if (_isDarkMode) {
                      DynamicTheme.of(context)?.setTheme(ThemeMode.dark);
                    } else {
                      DynamicTheme.of(context)?.setTheme(ThemeMode.light);
                    }
                  });
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'Language',
                style: TextStyle(fontSize: 18),
              ),
              const Spacer(),
              DropdownButton<String>(
                value: _selectedLanguage,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLanguage = newValue;
                    if (_selectedLanguage == 'English') {
                      DynamicTheme.of(context)?.setLocale(const Locale('en'));
                    } else if (_selectedLanguage == 'Turkish') {
                      DynamicTheme.of(context)?.setLocale(const Locale('tr'));
                    } else if (_selectedLanguage == 'Spanish') {
                      DynamicTheme.of(context)?.setLocale(const Locale('es'));
                    }
                  });
                },
                items: [
                  const DropdownMenuItem(
                    value: 'English',
                    child: Text('English'),
                  ),
                  const DropdownMenuItem(
                    value: 'Turkish',
                    child: Text('Turkish'),
                  ),
                  const DropdownMenuItem(
                    value: 'Spanish',
                    child: Text('Spanish'),
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
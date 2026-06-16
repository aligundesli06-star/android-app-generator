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
  bool _isDarkMode = false;
  Locale? _locale;
  String _lang = 'en';

  @override
  void initState() {
    super.initState();
    _locale = const Locale('en');
  }

  void changeLocale(String lang) {
    setState(() {
      if (lang == 'en') {
        _locale = const Locale('en');
        _lang = 'en';
      } else if (lang == 'tr') {
        _locale = const Locale('tr');
        _lang = 'tr';
      } else if (lang == 'es') {
        _locale = const Locale('es');
        _lang = 'es';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BookBuddy',
      locale: _locale,
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
              primarySwatch: Colors.indigo,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
            ),
      home: const MyHomePage(),
      routes: {
        '/settings': (context) => Settings(
              isDarkMode: _isDarkMode,
              changeTheme: (bool value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
              changeLocale: changeLocale,
              lang: _lang,
            ),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final _pages = [
    Home(),
    Progress(),
    Settings(
      isDarkMode: false,
      changeTheme: (bool value) {},
      changeLocale: (String lang) {},
      lang: 'en',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (int index) {
          if (index == 2) {
            Navigator.of(context).pushNamed('/settings');
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new item logic
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.book),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Book Title',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        'Book Author',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.book),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Book Title',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        'Book Author',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Progress extends StatelessWidget {
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
              Container(
                width: 100,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '50%',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Settings extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) changeTheme;
  final Function(String) changeLocale;
  final String lang;

  const Settings({
    Key? key,
    required this.isDarkMode,
    required this.changeTheme,
    required this.changeLocale,
    required this.lang,
  }) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Dark Mode',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const Spacer(),
                Switch(
                  value: widget.isDarkMode,
                  onChanged: widget.changeTheme,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Language',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const Spacer(),
                DropdownButton(
                  value: widget.lang,
                  onChanged: (String? value) {
                    widget.changeLocale(value!);
                  },
                  items: const [
                    DropdownMenuItem(
                      child: Text('English'),
                      value: 'en',
                    ),
                    DropdownMenuItem(
                      child: Text('Turkish'),
                      value: 'tr',
                    ),
                    DropdownMenuItem(
                      child: Text('Spanish'),
                      value: 'es',
                    ),
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
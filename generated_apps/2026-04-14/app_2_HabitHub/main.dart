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
      title: 'HabitHub',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      themeMode: _themeMode,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('tr'),
        Locale('es'),
      ],
      locale: _locale,
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(),
            ProgressScreen(),
            SettingsScreen(
              toggleTheme: _toggleTheme,
              changeLocale: _changeLocale,
              locale: _locale,
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
              icon: const Icon(Icons.home),
              label: _locale.languageCode == 'en'
                  ? 'Home'
                  : _locale.languageCode == 'tr'
                      ? 'Ana Sayfa'
                      : 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.bar_chart),
              label: _locale.languageCode == 'en'
                  ? 'Progress'
                  : _locale.languageCode == 'tr'
                      ? 'İlerleme'
                      : 'Progreso',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: _locale.languageCode == 'en'
                  ? 'Settings'
                  : _locale.languageCode == 'tr'
                      ? 'Ayarlar'
                      : 'Ajustes',
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add new item
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 8.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.directions_run),
                  const SizedBox(width: 16.0),
                  Text(
                    'Running',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 8.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.pool),
                  const SizedBox(width: 16.0),
                  Text(
                    'Swimming',
                    style: Theme.of(context).textTheme.titleLarge,
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

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: const Center(
                  child: Text(
                    '50%',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Text(
                'Running Progress',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: const Center(
                  child: Text(
                    '75%',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Text(
                'Swimming Progress',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final void Function() toggleTheme;
  final void Function(Locale) changeLocale;
  final Locale locale;

  const SettingsScreen({
    Key? key,
    required this.toggleTheme,
    required this.changeLocale,
    required this.locale,
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
              const SizedBox(width: 16.0),
              Switch(
                value: Theme.of(context).brightness == Brightness.dark,
                onChanged: (value) {
                  toggleTheme();
                },
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 16.0),
              DropdownButton(
                value: locale,
                onChanged: (Locale? value) {
                  if (value != null) {
                    changeLocale(value);
                  }
                },
                items: [
                  DropdownMenuItem(
                    child: const Text('English'),
                    value: const Locale('en'),
                  ),
                  DropdownMenuItem(
                    child: const Text('Türkçe'),
                    value: const Locale('tr'),
                  ),
                  DropdownMenuItem(
                    child: const Text('Español'),
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
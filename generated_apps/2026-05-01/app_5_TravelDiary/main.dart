import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const TravelDiaryApp());
}

class TravelDiaryApp extends StatefulWidget {
  const TravelDiaryApp({Key? key}) : super(key: key);

  @override
  State<TravelDiaryApp> createState() => _TravelDiaryAppState();
}

class _TravelDiaryAppState extends State<TravelDiaryApp> {
  int _currentIndex = 0;
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Diary',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      themeMode: _themeMode,
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('tr'),
        Locale('es'),
      ],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      home: TravelDiaryHome(
        currentIndex: _currentIndex,
        onChangeIndex: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        onThemeModeChange: (mode) {
          setState(() {
            _themeMode = mode;
          });
        },
        onLocaleChange: (locale) {
          setState(() {
            _locale = locale;
          });
        },
      ),
    );
  }
}

class TravelDiaryHome extends StatefulWidget {
  final int currentIndex;
  final void Function(int) onChangeIndex;
  final void Function(ThemeMode) onThemeModeChange;
  final void Function(Locale) onLocaleChange;

  const TravelDiaryHome({
    Key? key,
    required this.currentIndex,
    required this.onChangeIndex,
    required this.onThemeModeChange,
    required this.onLocaleChange,
  }) : super(key: key);

  @override
  State<TravelDiaryHome> createState() => _TravelDiaryHomeState();
}

class _TravelDiaryHomeState extends State<TravelDiaryHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: widget.currentIndex,
        children: const [
          HomeScreen(),
          ProgressScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: (index) {
          widget.onChangeIndex(index);
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Progress',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddItemScreen()),
          );
        },
        tooltip: 'Add Item',
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
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Icon(
                    Icons.airplane_ticket,
                    size: 40,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Trips',
                    style: TextStyle(fontSize: 18),
                  ),
                  const Text(
                    'Plan and organize your trips',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Icon(
                    Icons.camera,
                    size: 40,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Photos',
                    style: TextStyle(fontSize: 18),
                  ),
                  const Text(
                    'Store your travel memories',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Icon(
                    Icons.map,
                    size: 40,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    ' Destinations',
                    style: TextStyle(fontSize: 18),
                  ),
                  const Text(
                    'Explore new places',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Icon(
                    Icons.restaurant,
                    size: 40,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Food',
                    style: TextStyle(fontSize: 18),
                  ),
                  const Text(
                    'Savor local cuisine',
                    style: TextStyle(fontSize: 14),
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
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.bar_chart,
                size: 40,
              ),
              const SizedBox(width: 16),
              const Text(
                'Progress',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          'Trips',
                          style: TextStyle(fontSize: 18),
                        ),
                        const Text(
                          '10',
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          'Photos',
                          style: TextStyle(fontSize: 18),
                        ),
                        const Text(
                          '50',
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          'Destinations',
                          style: TextStyle(fontSize: 18),
                        ),
                        const Text(
                          '20',
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          'Food',
                          style: TextStyle(fontSize: 18),
                        ),
                        const Text(
                          '30',
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
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

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  String _language = 'en';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.settings,
                size: 40,
              ),
              const SizedBox(width: 16),
              const Text(
                'Settings',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                'Dark Mode',
                style:
import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      child: const MaterialApp(
        title: 'Travel Planner',
        home: MyHomePage(),
      ),
    );
  }
}

class DynamicTheme extends StatefulWidget {
  final Widget child;

  const DynamicTheme({Key? key, required this.child}) : super(key: key);

  @override
  State<DynamicTheme> createState() => _DynamicThemeState();
}

class _DynamicThemeState extends State<DynamicTheme> {
  bool _isDarkMode = false;
  Locale? _locale;

  void toggleMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo) : ThemeData.light().copyWith(primarySwatch: Colors.indigo),
      child: Builder(
        builder: (context) {
          return widget.child;
        },
      ),
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
  List<String> destinations = ['Paris', 'Tokyo', 'Rome'];

  void _addDestination() {
    setState(() {
      destinations.add('New Destination');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Planner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _currentIndex == 0
            ? GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                children: destinations
                    .map((destination) => Card(
                          elevation: 4,
                          shadowColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.place,
                                  size: 32,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  destination,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.restaurant,
                                      size: 24,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Restaurants',
                                      style: Theme.of(context).textTheme.titleSmall,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.hotel,
                                      size: 24,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Hotels',
                                      style: Theme.of(context).textTheme.titleSmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              )
            : _currentIndex == 1
                ? Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.bar_chart,
                            size: 32,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Progress',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: const [
                          Icon(
                            Icons.place,
                            size: 24,
                            color: Colors.green,
                          ),
                          SizedBox(width: 8),
                          Text(
                            '10 Destinations',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.restaurant,
                            size: 24,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 8),
                          Text(
                            '50 Restaurants',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  )
                : SettingsPage(
                    toggleMode: () {
                      (context.findAncestorWidgetOfExactType<DynamicTheme>() as DynamicTheme)
                          .toggleMode();
                    },
                  ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
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
      floatingActionButton: FloatingActionButton(
        onPressed: _addDestination,
        tooltip: 'Add Destination',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  final VoidCallback toggleMode;

  const SettingsPage({Key? key, required this.toggleMode}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.dark_mode,
                size: 32,
              ),
              const SizedBox(width: 16),
              Text(
                'Dark Mode',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              Switch(
                value: (context.findAncestorWidgetOfExactType<DynamicTheme>() as DynamicTheme)._isDarkMode,
                onChanged: (value) {
                  widget.toggleMode();
                },
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.language,
                size: 32,
              ),
              const SizedBox(width: 16),
              Text(
                'Language',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              DropdownButton(
                value: _selectedLanguage,
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value as String;
                  });
                },
                items: const [
                  DropdownMenuItem(
                    child: Text('English'),
                    value: 'English',
                  ),
                  DropdownMenuItem(
                    child: Text('Turkish'),
                    value: 'Turkish',
                  ),
                  DropdownMenuItem(
                    child: Text('Spanish'),
                    value: 'Spanish',
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
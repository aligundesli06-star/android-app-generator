import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const TravelBuddy());
}

class TravelBuddy extends StatefulWidget {
  const TravelBuddy({Key? key}) : super(key: key);

  @override
  State<TravelBuddy> createState() => _TravelBuddyState();
}

class _TravelBuddyState extends State<TravelBuddy> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TravelBuddy',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
              primarySwatch: Colors.indigo,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
            ),
      home: _TravelBuddyHome(
        isDarkMode: _isDarkMode,
        language: _language,
        onSettingsUpdate: (darkMode, language) {
          setState(() {
            _isDarkMode = darkMode;
            _language = language;
          });
        },
      ),
    );
  }
}

class _TravelBuddyHome extends StatefulWidget {
  final bool isDarkMode;
  final String language;
  final void Function(bool, String) onSettingsUpdate;

  const _TravelBuddyHome({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.onSettingsUpdate,
  }) : super(key: key);

  @override
  State<_TravelBuddyHome> createState() => _TravelBuddyHomeState();
}

class _TravelBuddyHomeState extends State<_TravelBuddyHome> {
  int _currentIndex = 0;
  List<String> _destinations = [];

  void _addDestination() {
    setState(() {
      _destinations.add('New Destination');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _HomeScreen(destinations: _destinations),
          _ProgressScreen(),
          _SettingsScreen(
            isDarkMode: widget.isDarkMode,
            language: widget.language,
            onSettingsUpdate: (darkMode, language) {
              widget.onSettingsUpdate(darkMode, language);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addDestination,
        tooltip: 'Add Destination',
        child: const Icon(Icons.add),
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
    );
  }
}

class _HomeScreen extends StatelessWidget {
  final List<String> destinations;

  const _HomeScreen({Key? key, required this.destinations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: const [
                  Icon(Icons.place, size: 48),
                  SizedBox(height: 16),
                  Text(
                    'Explore New Destinations',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: destinations.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on, size: 48),
                        const SizedBox(width: 16),
                        Text(destinations[index]),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: const [
                      Icon(Icons.directions, size: 48),
                      SizedBox(height: 16),
                      Text('Trips'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: const [
                      Icon(Icons.bar_chart, size: 48),
                      SizedBox(height: 16),
                      Text('Progress'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: const [
                  Icon(Icons.calendar_today, size: 48),
                  SizedBox(height: 16),
                  Text('Schedule'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final String language;
  final void Function(bool, String) onSettingsUpdate;

  const _SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.onSettingsUpdate,
  }) : super(key: key);

  @override
  State<_SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<_SettingsScreen> {
  bool _isDarkMode = false;
  String _language = '';

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
    _language = widget.language;
  }

  void _updateSettings() {
    widget.onSettingsUpdate(_isDarkMode, _language);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.dark_mode, size: 48),
                  const SizedBox(width: 16),
                  Text(
                    'Dark mode',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  Switch(
                    value: _isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        _isDarkMode = value;
                      });
                      _updateSettings();
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.language, size: 48),
                  const SizedBox(width: 16),
                  Text(
                    'Language',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  DropdownButton(
                    value: _language,
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
                    onChanged: (value) {
                      setState(() {
                        _language = value as String;
                      });
                      _updateSettings();
                    },
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
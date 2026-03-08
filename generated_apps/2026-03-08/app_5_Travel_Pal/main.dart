import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.black,
  ));
  runApp(const TravelPalApp());
}

class TravelPalApp extends StatelessWidget {
  const TravelPalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Pal',
      useMaterial3: true,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue).dark(),
      ),
      themeMode: ThemeMode.system,
      home: const TravelPalHome(),
    );
  }
}

class TravelPalHome extends StatefulWidget {
  const TravelPalHome({super.key});

  @override
  State<TravelPalHome> createState() => _TravelPalHomeState();
}

class _TravelPalHomeState extends State<TravelPalHome> {
  int _currentIndex = 0;
  final Locale _locale = const Locale('en');
  final List<_Trip> _trips = [];
  bool _isDarkMode = false;
  final List<String> _languages = ['English', 'Turkish', 'Spanish'];
  String _selectedLanguage = 'English';

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _addNewTrip() {
    setState(() {
      _trips.add(_Trip(
        title: 'New Trip',
        description: 'This is a new trip',
        date: DateTime.now(),
        destination: 'New York',
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Pal'),
        elevation: 0,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _trips.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.airplane_ticket,
                        size: 48,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      const Text('No trips yet'),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _trips.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: const EdgeInsets.all(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _trips[index].title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _trips[index].description,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${_trips[index].date.month}/${_trips[index].date.day}/${_trips[index].date.year} - ${_trips[index].destination}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
          const Center(
            child: Text('Stats'),
          ),
          _SettingsPage(
            onDarkModeToggle: _toggleDarkMode,
            languages: _languages,
            selectedLanguage: _selectedLanguage,
            onLanguageSelected: (language) {
              setState(() {
                _selectedLanguage = language;
              });
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
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
            icon: Icon(Icons.show_chart),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewTrip,
        tooltip: 'Add New Trip',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _Trip {
  final String title;
  final String description;
  final DateTime date;
  final String destination;

  _Trip({
    required this.title,
    required this.description,
    required this.date,
    required this.destination,
  });
}

class _SettingsPage extends StatefulWidget {
  final Function onDarkModeToggle;
  final List<String> languages;
  final String selectedLanguage;
  final Function(String) onLanguageSelected;

  const _SettingsPage({
    super.key,
    required this.onDarkModeToggle,
    required this.languages,
    required this.selectedLanguage,
    required this.onLanguageSelected,
  });

  @override
  State<_SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<_SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ListTile(
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: true,
              onChanged: (value) {
                widget.onDarkModeToggle();
              },
            ),
          ),
          ListTile(
            title: const Text('Language'),
            trailing: DropdownButton<String>(
              items: widget.languages.map((language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(language),
                );
              }).toList(),
              value: widget.selectedLanguage,
              onChanged: (language) {
                widget.onLanguageSelected(language!);
              },
            ),
          ),
        ],
      ),
    );
  }
}
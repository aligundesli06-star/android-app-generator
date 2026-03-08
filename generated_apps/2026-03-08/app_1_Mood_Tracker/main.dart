import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Tracker',
      useMaterial3: true,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
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
  bool _isDarkMode = false;
  Locale? _locale;
  List<Mood> _moods = [];
  final List<String> _languages = const ['en', 'tr', 'es'];

  void _createNewMood() {
    setState(() {
      _moods.add(Mood(
        id: DateTime.now().millisecondsSinceEpoch,
        date: DateTime.now(),
        mood: 'Happy',
      ));
    });
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    SystemChrome.setSystemUIOverlayStyle(
      _isDarkMode
          ? const SystemUiOverlayStyle(
              statusBarColor: Colors.black,
              statusBarIconBrightness: Brightness.light,
            )
          : const SystemUiOverlayStyle(
              statusBarColor: Colors.blue,
              statusBarIconBrightness: Brightness.dark,
            ),
    );
  }

  void _changeLanguage(String language) {
    setState(() {
      _locale = Locale(language, '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: _languages.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_languages[index].toUpperCase()),
                        onTap: () {
                          Navigator.of(context).pop();
                          _changeLanguage(_languages[index]);
                        },
                      );
                    },
                  );
                },
              );
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
            icon: Icon(Icons.stats),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHomeScreen(),
          _buildStatsScreen(),
          _buildSettingsScreen(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewMood,
        tooltip: 'Add new mood',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildHomeScreen() {
    return _moods.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.sentiment_neutral,
                  size: 100,
                ),
                const Text(
                  'No moods yet',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: _moods.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Icon(
                    _moods[index].mood == 'Happy'
                        ? Icons.sentiment_very_satisfied
                        : _moods[index].mood == 'Sad'
                            ? Icons.sentiment_very_dissatisfied
                            : Icons.sentiment_neutral,
                  ),
                  title: Text(
                    _moods[index].mood,
                    style: const TextStyle(fontSize: 24),
                  ),
                  subtitle: Text(
                    DateFormat('yyyy-MM-dd').format(_moods[index].date),
                  ),
                ),
              );
            },
          );
  }

  Widget _buildStatsScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.stats,
            size: 100,
          ),
          const Text(
            'Statistics coming soon',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsScreen() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Dark mode',
                style: TextStyle(fontSize: 18),
              ),
              Switch(
                value: _isDarkMode,
                onChanged: _toggleDarkMode,
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Language',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          DropdownButton(
            isExpanded: true,
            value: _languages[0],
            items: _languages.map((language) {
              return DropdownMenuItem(
                child: Text(language.toUpperCase()),
                value: language,
                onTap: () {
                  _changeLanguage(language);
                },
              );
            }).toList(),
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}

class Mood {
  final int id;
  final DateTime date;
  final String mood;

  Mood({required this.id, required this.date, required this.mood});
}
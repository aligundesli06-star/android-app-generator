import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Journal',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
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
  List<Mood> _moods = [];
  bool _isDarkMode = false;
  String _language = 'English';

  void _addMood() {
    setState(() {
      _moods.add(Mood(
        date: DateTime.now(),
        mood: 'Happy',
        note: 'Today was a great day!',
      ));
    });
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _changeLanguage(String language) {
    setState(() {
      _language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0
          ? HomeScreen(
              moods: _moods,
              language: _language,
              isDarkMode: _isDarkMode,
            )
          : _currentIndex == 1
              ? ProgressScreen(
                  moods: _moods,
                  language: _language,
                  isDarkMode: _isDarkMode,
                )
              : SettingsScreen(
                  isDarkMode: _isDarkMode,
                  language: _language,
                  toggleDarkMode: _toggleDarkMode,
                  changeLanguage: _changeLanguage,
                ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: _language == 'English'
                ? 'Home'
                : _language == 'Turkish'
                    ? 'Anasayfa'
                    : 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.bar_chart),
            label: _language == 'English'
                ? 'Progress'
                : _language == 'Turkish'
                    ? 'İlerleme'
                    : 'Progreso',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: _language == 'English'
                ? 'Settings'
                : _language == 'Turkish'
                    ? 'Ayarlar'
                    : 'Configuración',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMood,
        tooltip: _language == 'English'
            ? 'Add Mood'
            : _language == 'Turkish'
                ? 'Duygu Ekle'
                : 'Agregar Estado de Ánimo',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Mood {
  final DateTime date;
  final String mood;
  final String note;

  Mood({required this.date, required this.mood, required this.note});
}

class HomeScreen extends StatelessWidget {
  final List<Mood> moods;
  final bool isDarkMode;
  final String language;

  const HomeScreen({
    Key? key,
    required this.moods,
    required this.isDarkMode,
    required this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: moods.length,
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
                    moods[index].mood == 'Happy'
                        ? Icons.smile
                        : moods[index].mood == 'Sad'
                            ? Icons.sentiment_downtrend
                            : Icons.sentiment_neutral,
                    size: 32,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        moods[index].date.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        moods[index].note,
                        style: const TextStyle(fontSize: 14),
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
  final List<Mood> moods;
  final bool isDarkMode;
  final String language;

  const ProgressScreen({
    Key? key,
    required this.moods,
    required this.isDarkMode,
    required this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                language == 'English'
                    ? 'Happy'
                    : language == 'Turkish'
                        ? 'Mutlu'
                        : 'Feliz',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 16),
              Text(
                '${moods.where((mood) => mood.mood == 'Happy').length}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                language == 'English'
                    ? 'Sad'
                    : language == 'Turkish'
                        ? 'Üzgün'
                        : 'Triste',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 16),
              Text(
                '${moods.where((mood) => mood.mood == 'Sad').length}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                language == 'English'
                    ? 'Neutral'
                    : language == 'Turkish'
                        ? 'Nötr'
                        : 'Neutral',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 16),
              Text(
                '${moods.where((mood) => mood.mood == 'Neutral').length}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final String language;
  final Function toggleDarkMode;
  final Function changeLanguage;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.toggleDarkMode,
    required this.changeLanguage,
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
              const SizedBox(width: 16),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  toggleDarkMode();
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 16),
              DropdownButton(
                value: language,
                items: [
                  DropdownMenuItem(
                    child: const Text('English'),
                    value: 'English',
                  ),
                  DropdownMenuItem(
                    child: const Text('Türkçe'),
                    value: 'Turkish',
                  ),
                  DropdownMenuItem(
                    child: const Text('Español'),
                    value: 'Spanish',
                  ),
                ],
                onChanged: (value) {
                  changeLanguage(value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
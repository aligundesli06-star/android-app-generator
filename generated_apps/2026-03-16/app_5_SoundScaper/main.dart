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
      title: 'SoundScaper',
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
  bool _isDarkMode = false;
  String _language = 'English';
  final _formKey = GlobalKey<FormState>();
  List<String> _sounds = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(
            sounds: _sounds,
            onAddSound: (sound) {
              setState(() {
                _sounds.add(sound);
              });
            },
          ),
          ProgressScreen(
            sounds: _sounds,
          ),
          SettingsScreen(
            language: _language,
            isDarkMode: _isDarkMode,
            onChangeLanguage: (language) {
              setState(() {
                _language = language;
              });
            },
            onChangeTheme: (isDarkMode) {
              setState(() {
                _isDarkMode = isDarkMode;
                if (_isDarkMode) {
                  ThemeMode.dark;
                } else {
                  ThemeMode.light;
                }
              });
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Add Sound'),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Sound Name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a sound name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pop(context);
                              setState(() {
                                _sounds.add('New Sound');
                              });
                            }
                          },
                          child: const Text('Add'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<String> sounds;
  final Function onAddSound;

  const HomeScreen({
    Key? key,
    required this.sounds,
    required this.onAddSound,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemCount: sounds.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.music_note,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    sounds[index],
                    style: const TextStyle(fontSize: 24),
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
  final List<String> sounds;

  const ProgressScreen({
    Key? key,
    required this.sounds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(Icons.bar_chart),
              Text(
                'Progress',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            children: sounds.map((sound) {
              return Row(
                children: [
                  Text(sound),
                  const SizedBox(width: 16),
                  const CircularProgressIndicator(),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final String language;
  final bool isDarkMode;
  final Function onChangeLanguage;
  final Function onChangeTheme;

  const SettingsScreen({
    Key? key,
    required this.language,
    required this.isDarkMode,
    required this.onChangeLanguage,
    required this.onChangeTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Language',
                style: const TextStyle(fontSize: 24),
              ),
              DropdownButton(
                value: language,
                onChanged: (value) {
                  onChangeLanguage(value);
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
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Theme',
                style: const TextStyle(fontSize: 24),
              ),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  onChangeTheme(value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
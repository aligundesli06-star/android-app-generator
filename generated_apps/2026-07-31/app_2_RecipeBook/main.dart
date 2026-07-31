import 'package:flutter/material.dart';
import 'dart:async';

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
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      themeMode: _themeMode,
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            HomeScreen(),
            ProgressScreen(),
            SettingsScreen(),
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
            // Add new item logic here
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.restaurant),
                  SizedBox(width: 16),
                  Text(
                    'Italian Food',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.cake),
                  SizedBox(width: 16),
                  Text(
                    'Desserts',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.fastfood),
                  SizedBox(width: 16),
                  Text(
                    'Fast Food',
                    style: TextStyle(fontSize: 18),
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
            children: const [
              Icon(Icons.bar_chart),
              SizedBox(width: 16),
              Text(
                'Progress',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Icon(Icons.check),
              SizedBox(width: 16),
              Text('Complete'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Icon(Icons.access_time),
              SizedBox(width: 16),
              Text('In Progress'),
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
  int _themeModeValue = 0;
  int _languageValue = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Theme',
                style: TextStyle(fontSize: 18),
              ),
              const Spacer(),
              Row(
                children: [
                  Radio(
                    value: 0,
                    groupValue: _themeModeValue,
                    onChanged: (value) {
                      setState(() {
                        _themeModeValue = value as int;
                        if (_themeModeValue == 0) {
                          (context as Element).ancestorStateOfType(
                                TypeMatcher<_MyAppState>(),
                              )?.setState(() {
                            _themeMode = ThemeMode.light;
                          });
                        } else {
                          (context as Element).ancestorStateOfType(
                                TypeMatcher<_MyAppState>(),
                              )?.setState(() {
                            _themeMode = ThemeMode.dark;
                          });
                        }
                      });
                    },
                  ),
                  const Text('Light'),
                  Radio(
                    value: 1,
                    groupValue: _themeModeValue,
                    onChanged: (value) {
                      setState(() {
                        _themeModeValue = value as int;
                        if (_themeModeValue == 0) {
                          (context as Element).ancestorStateOfType(
                                TypeMatcher<_MyAppState>(),
                              )?.setState(() {
                            _themeMode = ThemeMode.light;
                          });
                        } else {
                          (context as Element).ancestorStateOfType(
                                TypeMatcher<_MyAppState>(),
                              )?.setState(() {
                            _themeMode = ThemeMode.dark;
                          });
                        }
                      });
                    },
                  ),
                  const Text('Dark'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                'Language',
                style: TextStyle(fontSize: 18),
              ),
              const Spacer(),
              Row(
                children: [
                  Radio(
                    value: 0,
                    groupValue: _languageValue,
                    onChanged: (value) {
                      setState(() {
                        _languageValue = value as int;
                        if (_languageValue == 0) {
                          (context as Element).ancestorStateOfType(
                                TypeMatcher<_MyAppState>(),
                              )?.setState(() {
                            _language = 'English';
                          });
                        } else if (_languageValue == 1) {
                          (context as Element).ancestorStateOfType(
                                TypeMatcher<_MyAppState>(),
                              )?.setState(() {
                            _language = 'Turkish';
                          });
                        } else {
                          (context as Element).ancestorStateOfType(
                                TypeMatcher<_MyAppState>(),
                              )?.setState(() {
                            _language = 'Spanish';
                          });
                        }
                      });
                    },
                  ),
                  const Text('English'),
                  Radio(
                    value: 1,
                    groupValue: _languageValue,
                    onChanged: (value) {
                      setState(() {
                        _languageValue = value as int;
                        if (_languageValue == 0) {
                          (context as Element).ancestorStateOfType(
                                TypeMatcher<_MyAppState>(),
                              )?.setState(() {
                            _language = 'English';
                          });
                        } else if (_languageValue == 1) {
                          (context as Element).ancestorStateOfType(
                                TypeMatcher<_MyAppState>(),
                              )?.setState(() {
                            _language = 'Turkish';
                          });
                        } else {
                          (context as Element).ancestorStateOfType(
                                TypeMatcher<_MyAppState>(),
                              )?.setState(() {
                            _language = 'Spanish';
                          });
                        }
                      });
                    },
                  ),
                  const Text('Turkish'),
                  Radio(
                    value: 2,
                    groupValue: _languageValue,
                    onChanged: (value) {
                      setState(() {
                        _languageValue = value as int;
                        if (_languageValue == 0) {
                          (context as Element).ancestorStateOfType(
                                TypeMatcher<_MyAppState>(),
                              )?.setState(() {
                            _language = 'English';
                          });
                        } else if (_languageValue == 1) {
                          (context as Element).ancestorStateOfType(
                                TypeMatcher<_MyAppState>(),
                              )?.setState(() {
                            _language = 'Turkish';
                          });
                        } else {
                          (context as Element).ancestorStateOfType(
                                TypeMatcher<_MyAppState>(),
                              )?.setState(() {
                            _language = 'Spanish';
                          });
                        }
                      });
                    },
                  ),
                  const Text('Spanish'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
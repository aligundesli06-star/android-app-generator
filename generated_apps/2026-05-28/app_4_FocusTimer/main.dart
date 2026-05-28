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
      title: 'FocusTimer',
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
  var _language = 'English';
  bool _isDarkMode = false;

  final _items = [
    {'title': 'Item 1', 'description': 'Description 1', 'time': 25},
    {'title': 'Item 2', 'description': 'Description 2', 'time': 30},
  ];

  void _addItem() {
    setState(() {
      _items.add({
        'title': 'New Item',
        'description': 'New Description',
        'time': 25,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(
            items: _items,
            language: _language,
            isDarkMode: _isDarkMode,
          ),
          ProgressScreen(
            language: _language,
            isDarkMode: _isDarkMode,
          ),
          SettingsScreen(
            language: _language,
            isDarkMode: _isDarkMode,
            onChangeLanguage: (value) {
              setState(() {
                _language = value;
              });
            },
            onChangeTheme: (value) {
              setState(() {
                _isDarkMode = value;
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
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: _language == 'English'
                ? 'Home'
                : _language == 'Turkish'
                    ? 'Ana Sayfa'
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
                    : 'Ajustes',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List _items;
  final String _language;
  final bool _isDarkMode;

  const HomeScreen({
    Key? key,
    required this._items,
    required this._language,
    required this._isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.timer),
                  const SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _items[index]['title'],
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        _items[index]['description'],
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        '${_items[index]['time']} minutes',
                        style: Theme.of(context).textTheme.caption,
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
  final String _language;
  final bool _isDarkMode;

  const ProgressScreen({
    Key? key,
    required this._language,
    required this._isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.bar_chart),
              const SizedBox(width: 16.0),
              Text(
                _language == 'English'
                    ? 'Progress'
                    : _language == 'Turkish'
                        ? 'İlerleme'
                        : 'Progreso',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          LinearProgressIndicator(
            value: 0.5,
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final String _language;
  final bool _isDarkMode;
  final Function(String) _onChangeLanguage;
  final Function(bool) _onChangeTheme;

  const SettingsScreen({
    Key? key,
    required this._language,
    required this._isDarkMode,
    required this._onChangeLanguage,
    required this._onChangeTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.settings),
              const SizedBox(width: 16.0),
              Text(
                _language == 'English'
                    ? 'Settings'
                    : _language == 'Turkish'
                        ? 'Ayarlar'
                        : 'Ajustes',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          DropdownButton<String>(
            value: _language,
            onChanged: _onChangeLanguage,
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
          const SizedBox(height: 16.0),
          SwitchListTile(
            title: Text(
              _language == 'English'
                  ? 'Dark Mode'
                  : _language == 'Turkish'
                      ? 'Koyu Mod'
                      : 'Modo Oscuro',
            ),
            value: _isDarkMode,
            onChanged: _onChangeTheme,
          ),
        ],
      ),
    );
  }
}
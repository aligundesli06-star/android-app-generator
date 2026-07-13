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
  bool _isDarkMode = false;
  String _language = 'English';
  List<MoodItem> _moodItems = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoodTracker',
      theme: _isDarkMode
          ? ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.dark,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.light,
            ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(
              moodItems: _moodItems,
              onAddItem: () {
                setState(() {
                  _moodItems.add(const MoodItem(
                    mood: 'Happy',
                    date: 'Today',
                  ));
                });
              },
            ),
            ProgressScreen(moodItems: _moodItems),
            SettingsScreen(
              isDarkMode: _isDarkMode,
              language: _language,
              onDarkModeChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
              onLanguageChanged: (value) {
                setState(() {
                  _language = value;
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
            setState(() {
              _moodItems.add(const MoodItem(
                mood: 'Happy',
                date: 'Today',
              ));
            });
          },
          tooltip: 'Add new item',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<MoodItem> moodItems;
  final VoidCallback onAddItem;

  const HomeScreen({
    Key? key,
    required this.moodItems,
    required this.onAddItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: moodItems.length,
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
                  const Icon(
                    Icons.face,
                    size: 48,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        moodItems[index].mood,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        moodItems[index].date,
                        style: Theme.of(context).textTheme.labelMedium,
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
  final List<MoodItem> moodItems;

  const ProgressScreen({
    Key? key,
    required this.moodItems,
  }) : super(key: key);

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
                size: 48,
              ),
              const SizedBox(width: 16),
              Text(
                'Progress',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...moodItems.map((item) => Row(
                children: [
                  Text(
                    item.mood,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final String language;
  final ValueChanged<bool> onDarkModeChanged;
  final ValueChanged<String> onLanguageChanged;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.onDarkModeChanged,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
                size: 48,
              ),
              const SizedBox(width: 16),
              Text(
                'Settings',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListTile(
            title: Text(
              'Dark mode',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            trailing: Switch(
              value: widget.isDarkMode,
              onChanged: widget.onDarkModeChanged,
            ),
          ),
          const SizedBox(height: 8),
          ListTile(
            title: Text(
              'Language',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            trailing: DropdownButton<String>(
              value: widget.language,
              onChanged: widget.onLanguageChanged,
              items: const [
                DropdownMenuItem(
                  value: 'English',
                  child: Text('English'),
                ),
                DropdownMenuItem(
                  value: 'Turkish',
                  child: Text('Turkish'),
                ),
                DropdownMenuItem(
                  value: 'Spanish',
                  child: Text('Spanish'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MoodItem {
  final String mood;
  final String date;

  const MoodItem({
    required this.mood,
    required this.date,
  });
}
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
      title: 'BookBuddy',
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

  final List<String> _languages = ['English', 'Turkish', 'Spanish'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const ProgressScreen();
      case 2:
        return SettingsScreen(
          isDarkMode: _isDarkMode,
          language: _language,
          onDarkModeChanged: (value) => setState(() => _isDarkMode = value),
          onLanguageChanged: (value) => setState(() => _language = value),
        );
      default:
        return const Center(child: Text('Invalid index'));
    }
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      items: [
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        const BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
        const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
      onTap: (index) => setState(() => _currentIndex = index),
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {},
      tooltip: 'Add new item',
      child: const Icon(Icons.add),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16),
      childAspectRatio: 1,
      children: [
        _buildCard(
          context,
          'Book Title',
          'Author Name',
          'https://example.com/book-cover.jpg',
          Icons.book,
        ),
        _buildCard(
          context,
          'Another Book',
          'Another Author',
          'https://example.com/another-book-cover.jpg',
          Icons.audiotrack,
        ),
        _buildCard(
          context,
          'More Books',
          'More Authors',
          'https://example.com/more-book-cover.jpg',
          Icons.format_color_text,
        ),
      ],
    );
  }

  Card _buildCard(
    BuildContext context,
    String title,
    String author,
    String imageUrl,
    IconData icon,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Image.network(imageUrl),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              author,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).textTheme.titleLarge?.color?.withOpacity(0.7)),
            ),
            const SizedBox(height: 16),
            Icon(icon),
          ],
        ),
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildProgressIndicator(context, 'Read', 50),
            _buildProgressIndicator(context, 'Listening', 25),
            _buildProgressIndicator(context, 'To Read', 100),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildProgressIndicator(context, 'Finished', 75),
            _buildProgressIndicator(context, 'In Progress', 50),
            _buildProgressIndicator(context, 'Dropped', 10),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressIndicator(BuildContext context, String label, int value) {
    return Column(
      children: [
        Text(label),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: value / 100,
        ),
      ],
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final String language;
  final Function(bool) onDarkModeChanged;
  final Function(String) onLanguageChanged;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.onDarkModeChanged,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Dark Mode'),
              Switch(
                value: isDarkMode,
                onChanged: onDarkModeChanged,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Language'),
              DropdownButton(
                value: language,
                onChanged: (value) => onLanguageChanged(value as String),
                items: [
                  'English',
                  'Turkish',
                  'Spanish',
                ].map((value) => DropdownMenuItem(
                  value: value,
                  child: Text(value),
                )).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
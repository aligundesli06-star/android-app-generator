import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      child: const MaterialApp(
        title: 'ExpenseMonitor',
        home: MyHomePage(),
      ),
    );
  }
}

class DynamicTheme extends StatefulWidget {
  final Widget child;

  const DynamicTheme({super.key, required this.child});

  @override
  State<DynamicTheme> createState() => _DynamicThemeState();
}

class _DynamicThemeState extends State<DynamicTheme> {
  bool _isDark = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDark
          ? ThemeData.dark().copyWith(
              primarySwatch: Colors.indigo,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
            ),
      child: Builder(
        builder: (context) {
          return widget.child;
        },
      ),
    );
  }

  void setDarkMode(bool isDark) {
    setState(() {
      _isDark = isDark;
    });
  }

  void setLanguage(String language) {
    setState(() {
      _language = language;
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final _pages = [
    const HomeScreen(),
    const ProgressScreen(),
    const SettingsScreen(),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dynamicTheme = context.findAncestorStateOfType<_DynamicThemeState>();

    return Scaffold(
      body: _pages[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddItemScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.money,
                  size: 40,
                ),
                SizedBox(height: 16),
                Text(
                  'Total Expenses',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  '\$1000',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.shopping_cart,
                  size: 40,
                ),
                SizedBox(height: 16),
                Text(
                  'Shopping',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  '\$500',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.restaurant,
                  size: 40,
                ),
                SizedBox(height: 16),
                Text(
                  'Food',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  '\$300',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.local_gas_station,
                  size: 40,
                ),
                SizedBox(height: 16),
                Text(
                  'Fuel',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  '\$200',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: const [
                  Icon(
                    Icons.money,
                    size: 40,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Total Expenses',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '\$1000',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              Column(
                children: const [
                  Icon(
                    Icons.shopping_cart,
                    size: 40,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Shopping',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '\$500',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: const [
                  Icon(
                    Icons.restaurant,
                    size: 40,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Food',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '\$300',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              Column(
                children: const [
                  Icon(
                    Icons.local_gas_station,
                    size: 40,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Fuel',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '\$200',
                    style: TextStyle(fontSize: 24),
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

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDark = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    final dynamicTheme = context.findAncestorStateOfType<_DynamicThemeState>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.dark_mode,
                size: 24,
              ),
              const SizedBox(width: 16),
              const Text(
                'Dark Mode',
                style: TextStyle(fontSize: 18),
              ),
              const Spacer(),
              Switch(
                value: _isDark,
                onChanged: (value) {
                  setState(() {
                    _isDark = value;
                    dynamicTheme?.setDarkMode(value);
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(
                Icons.language,
                size: 24,
              ),
              const SizedBox(width: 16),
              const Text(
                'Language',
                style: TextStyle(fontSize: 18),
              ),
              const Spacer(),
              DropdownButton(
                value: _language,
                items: [
                  const DropdownMenuItem(
                    child: Text('English'),
                    value: 'English',
                  ),
                  const DropdownMenuItem(
                    child: Text('Turkish'),
                    value: 'Turkish',
                  ),
                  const DropdownMenuItem(
                    child: Text('Spanish'),
                    value: 'Spanish',
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _language = value as String;
                    dynamicTheme?.setLanguage(value as String);
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AddItemScreen extends StatelessWidget {
  const AddItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '
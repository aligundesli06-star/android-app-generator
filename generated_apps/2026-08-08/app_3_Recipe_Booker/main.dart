import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicTheme();
  }
}

class DynamicTheme extends StatefulWidget {
  @override
  _DynamicThemeState createState() => _DynamicThemeState();
}

class _DynamicThemeState extends State<DynamicTheme> {
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(),
      supportedLocales: const [
        Locale('en'),
        Locale('tr'),
        Locale('es'),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const HomeScreen(),
    const ProgressScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add new item')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _card(
            context,
            'Breakfast',
            Icons.breakfast_dining,
            Colors.purple,
          ),
          _card(
            context,
            'Lunch',
            Icons.lunch_dining,
            Colors.blue,
          ),
          _card(
            context,
            'Dinner',
            Icons.dinner_dining,
            Colors.red,
          ),
          _card(
            context,
            'Dessert',
            Icons.cake,
            Colors.pink,
          ),
          _card(
            context,
            'Snack',
            Icons.snack_bar,
            Colors.orange,
          ),
          _card(
            context,
            'Beverage',
            Icons.local_cafe,
            Colors.brown,
          ),
        ],
      ),
    );
  }

  Widget _card(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 16,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              _indicator(
                context,
                'Target',
                Icons.flag,
                Colors.purple,
                50,
              ),
              const SizedBox(width: 16),
              _indicator(
                context,
                'Achieved',
                Icons.check,
                Colors.green,
                75,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _indicator(
                context,
                'Healthy',
                Icons.healing,
                Colors.blue,
                80,
              ),
              const SizedBox(width: 16),
              _indicator(
                context,
                'Unhealthy',
                Icons.warning,
                Colors.red,
                20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _indicator(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    double value,
  ) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Icon(
          icon,
          color: color,
        ),
        const SizedBox(height: 8),
        Text(
          '$value%',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');

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
                value: _themeMode == ThemeMode.dark,
                onChanged: (bool value) {
                  setState(() {
                    _themeMode = value ? ThemeMode.dark : ThemeMode.light;
                  });
                  (context as Element).findAncestorWidgetOfExactType<DynamicTheme>()!._themeMode = _themeMode;
                  (context as Element).findAncestorWidgetOfExactType<DynamicTheme>()!.setState(() {});
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 16),
              DropdownButton(
                value: _locale.languageCode,
                onChanged: (String? value) {
                  setState(() {
                    _locale = Locale(value!);
                  });
                  (context as Element).findAncestorWidgetOfExactType<DynamicTheme>()!._locale = _locale;
                  (context as Element).findAncestorWidgetOfExactType<DynamicTheme>()!.setState(() {});
                },
                items: const [
                  DropdownMenuItem(
                    child: Text('English'),
                    value: 'en',
                  ),
                  DropdownMenuItem(
                    child: Text('Turkish'),
                    value: 'tr',
                  ),
                  DropdownMenuItem(
                    child: Text('Spanish'),
                    value: 'es',
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
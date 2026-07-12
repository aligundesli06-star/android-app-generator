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

  final List<WaterIntake> _waterIntake = [];

  void _addWaterIntake() {
    setState(() {
      _waterIntake.add(WaterIntake(DateTime.now(), 250));
    });
  }

  void _changeTheme() {
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
    return MaterialApp(
      title: 'DailyWater',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
              primarySwatch: Colors.indigo,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
            ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(
              waterIntake: _waterIntake,
              addWaterIntake: _addWaterIntake,
            ),
            ProgressScreen(waterIntake: _waterIntake),
            SettingsScreen(
              changeTheme: _changeTheme,
              changeLanguage: _changeLanguage,
              isDarkMode: _isDarkMode,
              language: _language,
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
                      : 'Ajustes',
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addWaterIntake,
          tooltip: _language == 'English'
              ? 'Add Water Intake'
              : _language == 'Turkish'
                  ? 'Su Alımını Ekle'
                  : 'Agregar Ingesta de Agua',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<WaterIntake> waterIntake;
  final VoidCallback addWaterIntake;

  const HomeScreen({
    Key? key,
    required this.waterIntake,
    required this.addWaterIntake,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  Icon(Icons.local_drink),
                  SizedBox(width: 16),
                  Text('Daily Water Goal'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  Icon(Icons.history),
                  SizedBox(width: 16),
                  Text('Water Intake History'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ...waterIntake.map((intake) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Text('${intake.time.hour}:${intake.time.minute}'),
                      const SizedBox(width: 16),
                      Text('${intake.amount}ml'),
                    ],
                  ),
                ),
              )).toList(),
        ],
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final List<WaterIntake> waterIntake;

  const ProgressScreen({
    Key? key,
    required this.waterIntake,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.bar_chart),
              const SizedBox(width: 16),
              const Text('Progress'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Total Water Intake: '),
              Text('${waterIntake.map((intake) => intake.amount).reduce((a, b) => a + b)}ml'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Average Water Intake: '),
              Text('${waterIntake.isEmpty ? 0 : waterIntake.map((intake) => intake.amount).reduce((a, b) => a + b) / waterIntake.length}ml'),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final VoidCallback changeTheme;
  final VoidCallback Function(String) changeLanguage;
  final bool isDarkMode;
  final String language;

  const SettingsScreen({
    Key? key,
    required this.changeTheme,
    required this.changeLanguage,
    required this.isDarkMode,
    required this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark Mode: '),
              Switch(
                value: isDarkMode,
                onChanged: (value) => changeTheme(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language: '),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => changeLanguage('English'),
                child: const Text('English'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => changeLanguage('Turkish'),
                child: const Text('Turkish'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => changeLanguage('Spanish'),
                child: const Text('Spanish'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WaterIntake {
  final DateTime time;
  final int amount;

  WaterIntake(this.time, this.amount);
}
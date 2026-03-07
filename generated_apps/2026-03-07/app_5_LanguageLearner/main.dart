```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const LanguageLearnerApp());
}

class LanguageLearnerApp extends StatelessWidget {
  const LanguageLearnerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LanguageLearner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LanguageLearnerHomePage(),
    );
  }
}

class LanguageLearnerHomePage extends StatefulWidget {
  const LanguageLearnerHomePage({Key? key}) : super(key: key);

  @override
  State<LanguageLearnerHomePage> createState() => _LanguageLearnerHomePageState();
}

class _LanguageLearnerHomePageState extends State<LanguageLearnerHomePage> {
  final _languages = const ['English', 'Spanish', 'French', 'German', 'Chinese'];
  final _lessons = const ['Alphabet', 'Numbers', 'Greetings', 'Introductions', 'Basic Phrases'];
  String _selectedLanguage = 'English';
  String _selectedLesson = 'Alphabet';

  void _showLessonDetails() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$_selectedLesson in $_selectedLanguage'),
          content: const Text('This is a sample lesson content'),
          actions: [
            TextButton(
              child: const Text('Start Lesson'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showQuiz() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quiz Time!'),
          content: const Text('How are you doing in your language learning journey?'),
          actions: [
            TextButton(
              child: const Text('Take Quiz'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LanguageLearner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Welcome to LanguageLearner!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Select Language:'),
                const SizedBox(width: 10),
                DropdownButton(
                  value: _selectedLanguage,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedLanguage = value!;
                    });
                  },
                  items: _languages.map((language) {
                    return DropdownMenuItem(
                      value: language,
                      child: Text(language),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Select Lesson:'),
                const SizedBox(width: 10),
                DropdownButton(
                  value: _selectedLesson,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedLesson = value!;
                    });
                  },
                  items: _lessons.map((lesson) {
                    return DropdownMenuItem(
                      value: lesson,
                      child: Text(lesson),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showLessonDetails,
              child: const Text('Start Lesson'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _showQuiz,
              child: const Text('Take Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
```
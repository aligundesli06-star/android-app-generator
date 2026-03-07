```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const BookPalApp());
}

class BookPalApp extends StatelessWidget {
  const BookPalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BookPal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const BookPalHome(),
    );
  }
}

class BookPalHome extends StatefulWidget {
  const BookPalHome({Key? key}) : super(key: key);

  @override
  State<BookPalHome> createState() => _BookPalHomeState();
}

class _BookPalHomeState extends State<BookPalHome> {
  final _bookController = TextEditingController();
  final _authorController = TextEditingController();

  @override
  void dispose() {
    _bookController.dispose();
    _authorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookPal'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _bookController,
              decoration: const InputDecoration(
                labelText: 'Search for a book',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _authorController,
              decoration: const InputDecoration(
                labelText: 'Search for an author',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Book Recommendations'),
                      content: const Text('Based on your search, we recommend:'),
                      actions: [
                        TextButton(
                          child: const Text('Join Book Club'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BookClubPage(),
                              ),
                            );
                          },
                        ),
                        TextButton(
                          child: const Text('Discuss Book'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DiscussBookPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Get Recommendations'),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            const Text('Recently Added Books'),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: const [
                  BookCard(
                    title: 'The Great Gatsby',
                    author: 'F. Scott Fitzgerald',
                  ),
                  BookCard(
                    title: 'To Kill a Mockingbird',
                    author: 'Harper Lee',
                  ),
                  BookCard(
                    title: 'Pride and Prejudice',
                    author: 'Jane Austen',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final String title;
  final String author;

  const BookCard({
    Key? key,
    required this.title,
    required this.author,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.book),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.headline6),
                Text(author, style: Theme.of(context).textTheme.caption),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BookClubPage extends StatelessWidget {
  const BookClubPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Club'),
      ),
      body: const Center(
        child: Text('Join our book club to discuss your favorite books'),
      ),
    );
  }
}

class DiscussBookPage extends StatelessWidget {
  const DiscussBookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discuss Book'),
      ),
      body: const Center(
        child: Text('Discuss your favorite books with other readers'),
      ),
    );
  }
}
```
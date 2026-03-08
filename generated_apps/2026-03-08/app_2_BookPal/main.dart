import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BookPal',
      useMaterial3: true,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff4d8dff)),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Book> _books = [];
  final TextEditingController _newBookController = TextEditingController();

  void _addBook() {
    setState(() {
      _books.add(Book(_newBookController.text));
    });
    _newBookController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text('BookPal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _newBookController,
              decoration: InputDecoration(
                labelText: 'Add new book',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addBook,
              child: const Text('Add'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _books.isEmpty
                  ? const Center(child: Text('No books yet!'))
                  : ListView.builder(
                      itemCount: _books.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Expanded(child: Text(_books[index].title)),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    setState(() {
                                      _books.removeAt(index);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DiscussionPage()),
          );
        },
        child: const Icon(Icons.chat),
      ),
    );
  }
}

class Book {
  final String title;

  Book(this.title);
}

class DiscussionPage extends StatelessWidget {
  const DiscussionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text('Discussion'),
      ),
      body: const Center(
        child: Text('Discussion page'),
      ),
    );
  }
}
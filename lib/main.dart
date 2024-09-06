import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 65, 237, 79)),
        useMaterial3: true,
      ),
      home: const TodaApp(),
    );
  }
}

class TodaApp extends StatefulWidget {
  const TodaApp({
    super.key,
  });

  @override
  State<TodaApp> createState() => _TodaAppState();
}

class _TodaAppState extends State<TodaApp> {
  late TextEditingController _texteditController;
  late TextEditingController _descriptionController;

  final List<Map<String, String>> _myList = [];
  
  @override
  void initState() {
    super.initState();
    _texteditController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  void addTodoHandle(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add new task"),
            content: SizedBox(
              width: 120,
              height: 140,
              child: Column(
                children: [
                  TextField(
                    controller: _texteditController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Input your task"),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Description"),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      _myList.add({
                        'title': _texteditController.text,
                        'description': _descriptionController.text
                      });
                    });
                    _texteditController.text = "";
                    _descriptionController.text = "";
                    Navigator.pop(context);
                  },
                  child: const Text("Save"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: _myList.isEmpty
          ? const Center(
              child: Text(
                'No tasks added.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _myList.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      _myList[index]['title']!,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        _myList[index]['description']!,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    leading: const Icon(
                      Icons.check_circle_outline,
                      color: Color.fromARGB(255, 190, 236, 98),
                      size: 32,
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTodoHandle(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

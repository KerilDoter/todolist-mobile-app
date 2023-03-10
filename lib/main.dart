import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'To DO List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _todos = <Task>[
    Task(
        description: 'Subscribe to Flutter From Scratch on Instagram',
        completed: false),
    Task(description: 'Follow me on Medium', completed: false),
    Task(
        description:
        'Copy paste this code sample into VS Code or Android Studio and run it on your phone',
        completed: false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _todos.clear();
              });
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: ListView(
        children: _todos
            .map((e) => CheckboxListTile(
          value: e.completed,
          title: Text(e.description),
          onChanged: (val) {
            setState(() {
              e.completed = !e.completed; // toggle the completion
            });
          },
        ))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<Task>(
            context: context,
            builder: (context) {
              final _textController = TextEditingController();

              return AlertDialog(
                title: Text('Add a new task'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _textController,
                      decoration:
                      InputDecoration(labelText: 'Type here...'),
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(
                            context,
                            Task(
                                description: _textController.text,
                                completed: false),
                          );
                        },
                        icon: Icon(Icons.add),
                        label: Text("Add Task"))
                  ],
                ),
              );
            },
          ).then((value) {
            setState(() {
              if (value != null) {
                _todos.add(value);
              }
            });
          });
        },
        tooltip: 'Add task',
        child: Icon(Icons.add),
      ),
    );
  }
}

class Task {
  String description;
  bool completed;

  Task({
    required this.description,
    required this.completed,
  });
}
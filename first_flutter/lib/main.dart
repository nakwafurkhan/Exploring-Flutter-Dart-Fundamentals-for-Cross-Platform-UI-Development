import 'package:flutter/material.dart';

void main() {
  runApp(const TaskEaseApp());
}

class TaskEaseApp extends StatelessWidget {
  const TaskEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const TodoListScreen(),
    );
  }
}

// --- STATEFUL WIDGET: Manages the entire list logic ---
class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<String> _tasks = ['Buy groceries', 'Complete Flutter lesson', 'Fix iOS lag'];
  final TextEditingController _controller = TextEditingController();

  void _addTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _tasks.insert(0, _controller.text); // Updates the list state
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TaskEase Productivity')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(labelText: 'New Task'),
                  ),
                ),
                IconButton(icon: const Icon(Icons.add), onPressed: _addTask),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                // Returns a specialized widget for each task
                return TaskTile(taskName: _tasks[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// --- LOCALIZED STATE: Only this widget rebuilds when checked ---
class TaskTile extends StatefulWidget {
  final String taskName;
  const TaskTile({super.key, required this.taskName});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    // Note: When setState is called here, the REST of the list does NOT rebuild.
    return ListTile(
      title: Text(
        widget.taskName,
        style: TextStyle(
          decoration: _isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      leading: Checkbox(
        value: _isCompleted,
        onChanged: (bool? value) {
          setState(() {
            _isCompleted = value!;
          });
        },
      ),
    );
  }
}
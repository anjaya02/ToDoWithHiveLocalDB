import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/data/db.dart';
import 'package:todo/utils/dialog_box.dart';
import 'package:todo/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Reference the hive box
  final _mybox = Hive.box('mybox');
  final TextEditingController _controller = TextEditingController();
  TodoDataBase db = TodoDataBase();

  @override
  void initState() {
    super.initState();

    // Initialize data
    if (_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = value ?? false;
    });
    db.updateDb();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: () {
            setState(() {
              if (_controller.text.isNotEmpty) {
                db.toDoList.add([_controller.text, false]);
                _controller.clear(); // Clear the text field
              }
            });
            db.updateDb();
          },
          onCancel: () {
            _controller.clear(); // Clear the text field
          },
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[200],
      appBar: AppBar(
        title: const Text("Todo"),
        elevation: 0,
        backgroundColor: Colors.purple,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Colors.purple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        elevation: 8,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.toDoList[index][0] as String,
            taskCompleted: db.toDoList[index][1] as bool,
            onChanged: (bool? value) {
              checkBoxChanged(value, index);
            },
            deleteFunction: () => deleteTask(index),
          );
        },
      ),
    );
  }
}

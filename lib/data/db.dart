import 'package:hive/hive.dart';

class TodoDataBase {
  List toDoList = [];

  // Reference our box
  final _mybox = Hive.box('mybox');

  // Run this method if this is the first time ever opening this app
  void createInitialData() {
    toDoList = [
      ['Watch Tutorials', false],
      ['Do Exercises', false],
    ];
    // Save initial data to the database
    _mybox.put('TODOLIST', toDoList);
  }

  // Load the data from the database
  void loadData() {
    var storedData = _mybox.get("TODOLIST");
    if (storedData != null) {
      toDoList = List.from(storedData);
    } else {
      toDoList = [];
    }
  }

  // Update the Hive database
  void updateDb() {
    _mybox.put("TODOLIST", toDoList);
  }
}

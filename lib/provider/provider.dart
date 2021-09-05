import 'package:flutter/cupertino.dart';
import 'package:todo/models/todo_item.dart';

class ListProvider with ChangeNotifier {
// ignore: non_constant_identifier_names
  List<TodoItem> todoList = [
    // TodoItem("PickupFriend", false),
    // TodoItem("Check-up Appointment @5", false),
    // TodoItem("Buy Grocceries", false),
  ];

  addToDoItem(String title, bool isDone) {
    todoList.add(TodoItem(title, isDone));
    notifyListeners();
  }

  deleteItem(TodoItem item) {
    todoList.remove(item);
    notifyListeners();
  }

  isTaskDone(int i) {
    todoList.elementAt(i).isDone = true;
  }

  searchItem(String val) {
    final List<TodoItem> searchList = todoList
        .where((title) =>
            title.toString().toLowerCase().contains(val.toLowerCase()))
        .toList();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:mvvm_api/model/todo.dart';
import 'package:mvvm_api/repository/todo_repository.dart';

class TodoViewModel with ChangeNotifier {
  final TodoRepository _todoRepository = TodoRepository();
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  Future<List<Todo>> fetchTodos(BuildContext context) async {
    try {
      _todos = await _todoRepository.fetchTodos(context);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to save todo');
    }
    return _todos;
  }
}

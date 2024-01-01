import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_api/todos_api.dart';

class LocalStorageTodosApi extends TodosApi {
  final SharedPreferences _plugIn;

  LocalStorageTodosApi({required SharedPreferences plugIn}) : _plugIn = plugIn {
    _init();
  }

  void _init() {
    final todoJson = _getvalue(todosKey);
    if (todoJson != null) {
      final todos = List.from(json.decode(todoJson) as List<dynamic>)
          .map<Todo>((t) => Todo.fromJson(JsonMap.from(t)))
          .cast<Todo>()
          .toList();
      _todoStreamController.sink.add(todos);
    } else {
      _todoStreamController.sink.add(const []);
    }
  }

  final _todoStreamController = BehaviorSubject<List<Todo>>.seeded(const []);

  static const todosKey = "_todosKey_";

  //!for to save the LocalStorage
  String? _getvalue(String key) => _plugIn.getString(key);

  Future<void> _setValue(String key, String value) =>
      _plugIn.setString(key, value);

  @override
  Stream<List<Todo>> getTodos() => _todoStreamController.asBroadcastStream();

  @override
  Future<void> saveTodo(Todo todo) {
    final todos = [..._todoStreamController.value];
    final todoIndex = todos.indexWhere((t) => t.todoId == todo.todoId);
    if (todoIndex >= 0) {
      todos[todoIndex] = todo;
    } else {
      todos.add(todo);
    }
    _todoStreamController.add(todos);
    return _setValue(todosKey, json.encode(todos));
  }

  @override
  Future<void> deleteTodo(String todoId) {
    final todos = [..._todoStreamController.value];
    final todoIndex = todos.indexWhere((t) => t.todoId == todoId);
    if (todoIndex == -1) {
      throw TodosNotFoundException();
    } else {
      todos.removeAt(todoIndex);
      _todoStreamController.add(todos);
      return _setValue(todosKey, json.encode(todos));
    }
  }

  @override
  Future<int> clearCompleted() async {
    final todos = [..._todoStreamController.value];
    final completedTodosAmount = todos.where((t) => t.isCompleted).length;
    todos.removeWhere((t) => t.isCompleted);
    _todoStreamController.add(todos);
    await _setValue(todosKey, json.encode(todos));
    return completedTodosAmount;
  }

  @override
  Future<int> completeAll({required bool isCompleted}) async {
    final todos = [..._todoStreamController.value];
    final changedTodosAmount =
        todos.where((t) => t.isCompleted != isCompleted).length;
    final newTodos = [
      for (final todo in todos) todo.copyWith(isCompleted: isCompleted)
    ];
    _todoStreamController.add(newTodos);
    await _setValue(todosKey, json.encode(newTodos));
    return changedTodosAmount;
  }
}

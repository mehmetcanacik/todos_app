import 'package:todos_api/todos_api.dart';

abstract class TodosApi {
  const TodosApi();

  Stream<List<Todo>> getTodos();

  Future<void> saveTodo(Todo todo);
  Future<void> deleteTodo(String todoId);
  Future<int> clearCompleted();
  Future<int> completeAll({required bool isCompleted});
}

class TodosNotFoundException implements Exception {
  final String error;

  const TodosNotFoundException({ this.error="Todos not found"});
}

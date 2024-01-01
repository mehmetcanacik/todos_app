import 'package:todos_api/todos_api.dart';

class TodosRepository extends TodosApi {
  final TodosApi _todosApi;

  TodosRepository({required TodosApi todosApi}) : _todosApi = todosApi;

  @override
  Future<int> clearCompleted() => _todosApi.clearCompleted();

  @override
  Future<int> completeAll({required bool isCompleted}) =>
      _todosApi.completeAll(isCompleted: isCompleted);

  @override
  Future<void> deleteTodo(String todoId) => _todosApi.deleteTodo(todoId);

  @override
  Stream<List<Todo>> getTodos() => _todosApi.getTodos();

  @override
  Future<void> saveTodo(Todo todo) => _todosApi.saveTodo(todo);
}

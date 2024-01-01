part of 'todos_bloc.dart';

enum TodoStatus { initial, loading, success, failure }

final class TodoState extends Equatable {
  final List<Todo> todos;
  final Todo? lastDeletedTodo;
  final TodoStatus status;

  const TodoState({
    this.todos = const [],
     this.lastDeletedTodo,
    this.status = TodoStatus.initial,
  });

  TodoState copyWith(
      {TodoStatus Function()? status,
      List<Todo> Function()? todos,
      Todo? Function()? lastDeletedTodo}) {
    return TodoState(
      status: status != null ? status() : this.status,
      todos: todos != null ? todos() : this.todos,
      lastDeletedTodo:
          lastDeletedTodo != null ? lastDeletedTodo() : this.lastDeletedTodo,
    );
  }

  @override
  List<Object?> get props => [todos, status, lastDeletedTodo];
}

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_repository/todos_repository.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodosRepository _todosRepository;

  TodoBloc({required TodosRepository todosRepository})
      : _todosRepository = todosRepository,
        super(
          const TodoState(),
        ) {
    on<GetAllTodosEvent>(_getAllTodos);
    on<TodoCompletionToggledEvent>(_todoCompletionToggled);
    on<TodoDeletedEvent>(_todoDeleted);
    on<UndoDeletionTodoEvent>(_undoDeletionTodo);
    on<ToggleAllTodosEvent>(_toggleAllTodos);
    on<ClearCompletedTodosEvent>(_clearCompletedTodos);
  }

  Future<void> _getAllTodos(
      GetAllTodosEvent event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: () => TodoStatus.loading));

    await emit.forEach(
      _todosRepository.getTodos(),
      onData: (todos) => state.copyWith(
        status: () => TodoStatus.success,
        todos: () => todos,
      ),
      onError: (error, stackTrace) =>
          state.copyWith(status: () => TodoStatus.failure),
    );
  }

  Future<void> _todoCompletionToggled(
      TodoCompletionToggledEvent event, Emitter<TodoState> emit) async {
    final newTodo = event.todo.copyWith(isCompleted: event.isCompleted);
    await _todosRepository.saveTodo(newTodo);
  }

  Future<void> _todoDeleted(
      TodoDeletedEvent event, Emitter<TodoState> emit) async {
    emit(state.copyWith(lastDeletedTodo: () => event.todo));
    await _todosRepository.deleteTodo(event.todo.todoId);
  }

  Future<void> _undoDeletionTodo(
      UndoDeletionTodoEvent event, Emitter<TodoState> emit) async {
    final todo = state.lastDeletedTodo!;
    emit(state.copyWith(lastDeletedTodo: () => null));
    await _todosRepository.saveTodo(todo);
  }

  Future<void> _toggleAllTodos(
      ToggleAllTodosEvent event, Emitter<TodoState> emit) async {
    final completed = state.todos.every((todo) => todo.isCompleted);
    await _todosRepository.completeAll(isCompleted: !completed);
  }

  Future<void> _clearCompletedTodos(
      ClearCompletedTodosEvent event, Emitter<TodoState> emit) async {
    await _todosRepository.clearCompleted();
  }
}

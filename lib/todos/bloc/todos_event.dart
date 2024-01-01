part of 'todos_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}


final class GetAllTodosEvent extends TodoEvent {
  const GetAllTodosEvent();
}


final class TodoCompletionToggledEvent extends TodoEvent {
  final Todo todo;
  final bool isCompleted;

  const TodoCompletionToggledEvent({
    required this.todo,
    required this.isCompleted,
  });
  @override
  List<Object?> get props => [todo, isCompleted];
}



final class TodoDeletedEvent extends TodoEvent {
  const TodoDeletedEvent({required this.todo});
  final Todo todo;

  @override
  List<Object?> get props => [todo];
}

final class UndoDeletionTodoEvent extends TodoEvent {
  const UndoDeletionTodoEvent();
}

class ToggleAllTodosEvent extends TodoEvent {
  const ToggleAllTodosEvent();
}

class ClearCompletedTodosEvent extends TodoEvent {
  const ClearCompletedTodosEvent();
}

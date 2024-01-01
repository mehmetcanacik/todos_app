import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/todos/bloc/todos_bloc.dart';
import 'package:todos_app/todos/widgets/todo_list_tile.dart';
import 'package:todos_repository/todos_repository.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoBloc>(
      create: (context) => TodoBloc(
        todosRepository: context.read<TodosRepository>(),
      )..add(
          const GetAllTodosEvent(),
        ),
      child: const TodosView(),
    );
  }
}

class TodosView extends StatelessWidget {
  const TodosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Todos"),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<TodoBloc, TodoState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == TodoStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text("Todo Error"),
                    ),
                  );
              }
            },
          ),
          BlocListener<TodoBloc, TodoState>(
            listenWhen: (previous, current) =>
                previous.lastDeletedTodo != current.lastDeletedTodo &&
                current.lastDeletedTodo != null,
            listener: (context, state) {
              final deletedTodo = state.lastDeletedTodo!;
              final messenger = ScaffoldMessenger.of(context);
              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(deletedTodo.title),
                    action: SnackBarAction(
                      label: "Undo Deletion Todo",
                      onPressed: () {
                        messenger.hideCurrentSnackBar();
                        context.read<TodoBloc>().add(
                              const UndoDeletionTodoEvent(),
                            );
                      },
                    ),
                  ),
                );
            },
          )
        ],
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state.todos.isEmpty) {
              if (state.status == TodoStatus.loading) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              } else if (state.status != TodoStatus.success) {
                return const SizedBox.shrink();
              } else {
                return const Center(
                  child: Text("Empty Todo",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16.0)),
                );
              }
            }
            return CupertinoScrollbar(
              child: ListView(
                children: [
                  for (final todo in state.todos)
                    TodoListTile(
                      todo: todo,
                      onToggleCompleted: (isCompleted) {
                        context.read<TodoBloc>().add(
                              TodoCompletionToggledEvent(
                                  todo: todo, isCompleted: isCompleted),
                            );
                      },
                      onDismissed: (_) {
                        context
                            .read<TodoBloc>()
                            .add(TodoDeletedEvent(todo: todo));
                      },
                      onTap: () {
                        
                      },
                    )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:todos_api/todos_api.dart';
import 'package:todos_app/app/app.dart';
import 'package:todos_repository/todos_repository.dart';

void bootStrap({required TodosApi todosApi}) {
  final todosRepository = TodosRepository(todosApi: todosApi);
  runApp(
    App(
      todosRepository: todosRepository,
    ),
  );
}

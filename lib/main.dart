import 'package:flutter/material.dart';
import 'package:local_storage_todos_api/local_storage_todos_api.dart';
import 'package:todos_app/bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final todosApi = LocalStorageTodosApi(
    plugIn: await SharedPreferences.getInstance(),
  );
  bootStrap(todosApi: todosApi);
}

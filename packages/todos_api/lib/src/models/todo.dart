import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:todos_api/src/models/json_map.dart';
import 'package:uuid/uuid.dart';

part 'todo.g.dart';

@immutable
@JsonSerializable()
class Todo extends Equatable {
  final String todoId;
  final String title;
  final String description;
  final bool isCompleted;

  Todo(
      {String? todoId,
      required this.title,
      this.description = "",
      this.isCompleted = false})
      : todoId = todoId ?? const Uuid().v4();

  Todo copyWith(
      {String? todoId, String? title, String? description, bool? isCompleted}) {
    return Todo(
      todoId: todoId ?? this.todoId,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  static Todo fromJson(JsonMap json) => _$TodoFromJson(json);
  
  JsonMap toJson() => _$TodoToJson(this);

  @override
  List<Object?> get props => [todoId, title, description, isCompleted];
}

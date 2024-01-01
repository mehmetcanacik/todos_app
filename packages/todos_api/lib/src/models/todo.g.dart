// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
      todoId: json['todoId'] as String?,
      title: json['title'] as String,
      description: json['description'] as String? ?? "",
      isCompleted: json['isCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'todoId': instance.todoId,
      'title': instance.title,
      'description': instance.description,
      'isCompleted': instance.isCompleted,
    };

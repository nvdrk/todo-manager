import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'todo.freezed.dart';
part 'todo.g.dart';

List<Todo> todoFromJson(String str) => List<Todo>.from(json.decode(str).map((x) => Todo.fromJson(x)));

String todoToJson(List<Todo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class Todo with _$Todo {
  const factory Todo({
    required int userId,
    required int id,
    required String title,
    required bool completed,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}

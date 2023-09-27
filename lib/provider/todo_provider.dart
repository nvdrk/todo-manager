import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_manager/data/api/repository/todo_repository.dart';

import '../data/api/entities/todo.dart';

final todoProvider = FutureProvider<List<Todo>>((ref) async {
  final todoList = await TodoRepository(baseURL: 'https://jsonplaceholder.typicode.com/').getBlogPosts();
  return todoList;
});

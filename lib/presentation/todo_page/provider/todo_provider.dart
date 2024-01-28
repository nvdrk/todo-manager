import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_manager/data/api/repository/todo_repository.dart';
import 'package:todo_manager/data/api/entities/todo.dart';

final todoProvider = AutoDisposeFutureProvider((ref) async {
  final todoList = await ref.read(Dependency.todoRepository).getTodos();
  return todoList;
});

/// Api takes userId as query param
final todoProviderByUser = AutoDisposeFutureProvider.family<List<Todo>, int?>((ref, userId) async {
  final todoList = await ref.read(Dependency.todoRepository).getTodos(userId);
  return todoList;
});

final todoNotifierProvider =
    AsyncNotifierProvider<TodoNotifier, List<Todo>>((TodoNotifier.new));

class TodoNotifier extends AsyncNotifier<List<Todo>> {

  void addTodo(String text, [int? userId]) {
    final todoList = state.value ?? [];
    final lastId = state.value?.last.id ?? 0;
    final todo = Todo(
      userId: userId ?? 0,
      id: lastId + 1,
      title: text,
      completed: false,
    );
    todoList.add(todo);
    state = AsyncData(todoList);
  }

  void removeTodo(int id) {
    final todoList = state.value!;
    todoList.removeWhere((element) => element.id == id);
    state = AsyncData(todoList);
  }

  void toggleCheckMark(int id) {
    final todoList = state.value!;
    final index = todoList.indexWhere((element) => element.id == id);
    final todo = todoList.where((element) => element.id == id).first;
    todoList[index] = todo.copyWith(completed: !todo.completed);
    state = AsyncData(todoList);
  }

  @override
  FutureOr<List<Todo>> build() {
    return ref.read(todoProvider.future);
  }
}

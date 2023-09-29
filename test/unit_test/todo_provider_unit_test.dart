import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_manager/data/api/entities/todo.dart';
import 'package:todo_manager/provider/todo_provider.dart';

void main() {
  test('TodoProvider fetches todos successfully', () async {

    final container = ProviderContainer(
      overrides: [
        todoProvider.overrideWith((ref) => [
          const Todo(id: 1, title: 'Task 1', completed: false, userId: 0),
          const Todo(id: 2, title: 'Task 2', completed: true, userId: 0),
        ])
      ]
    );

    final todos = container.read(todoProvider);

    expect(todos, isA<AsyncValue<List<Todo>>>());
    expect(todos.value!.length, 2);

    container.dispose();
  });

  test('TodoNotifier adds a new todo successfully', () async {

    final container = ProviderContainer(
        overrides: [
          todoProvider.overrideWith((ref) => [
            const Todo(id: 1, title: 'Task 1', completed: false, userId: 0),
            const Todo(id: 2, title: 'Task 2', completed: true, userId: 0),
          ])
        ]
    );

    final todoNotifier = container.read(todoNotifierProvider.notifier);

    todoNotifier.addTodo('Task 3');
    final todos = container.read(todoProvider);

    expect(todos, isA<AsyncValue<List<Todo>>>());
    expect(todos.value!.length, 3);
    expect(todos.value![2].title, 'Task 3');
    expect(todos.value![2].id, 3);

    container.dispose();
  });

  test('Toggle checkmark successfully', () async {

    final container = ProviderContainer(
        overrides: [
          todoProvider.overrideWith((ref) => [
            const Todo(id: 1, title: 'Task 1', completed: false, userId: 0),
            const Todo(id: 2, title: 'Task 2', completed: true, userId: 0),
          ])
        ]
    );

    final todoNotifier = container.read(todoNotifierProvider.notifier);

    todoNotifier.toggleCheckMark(1);

    final todos = container.read(todoProvider);

    expect(todos, isA<AsyncValue<List<Todo>>>());
    expect(todos.value!.length, 2);
    expect(todos.value![0].completed, true);

    container.dispose();
  });

  test('Remove Todo Successfully', () async {

    final container = ProviderContainer(
        overrides: [
          todoProvider.overrideWith((ref) => [
            const Todo(id: 1, title: 'Task 1', completed: false, userId: 0),
            const Todo(id: 2, title: 'Task 2', completed: true, userId: 0),
          ])
        ]
    );

    final todoNotifier = container.read(todoNotifierProvider.notifier);

    todoNotifier.removeTodo(2);

    final todos = container.read(todoProvider);

    expect(todos, isA<AsyncValue<List<Todo>>>());
    expect(todos.value!.length, 1);

    container.dispose();
  });
}

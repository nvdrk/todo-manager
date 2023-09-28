import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_manager/data/api/entities/todo.dart';
import 'package:todo_manager/presentation/shared/error_layout.dart';
import 'package:todo_manager/presentation/shared/loading_layout.dart';
import 'package:todo_manager/provider/todo_provider.dart';
import 'layouts/todo_layout.dart';

class TodoPage extends ConsumerWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Todo>> todos = ref.watch(todoNotifierProvider);

    return SafeArea(
      top: false,
      child: todos.when(
        data: (todos) => TodoLayout(todos: todos),
        error: ErrorLayout.new,
        loading: LoadingLayout.new,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_manager/application/colors.dart';
import '../data/api/entities/todo.dart';
import '../provider/todo_provider.dart';

class TodoList extends ConsumerWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Todo>> posts = ref.watch(todoProvider);

    return SafeArea(
      child: posts.when(
          data: (posts) => DataLayout(todos: posts),
          error: ErrorLayout.new,
          loading: LoadingLayout.new),
    );
  }
}

class DataLayout extends ConsumerWidget {
  const DataLayout({Key? key, required this.todos}) : super(key: key);

  final List<Todo> todos;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: greyTint.shade400,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: greyTint.shade600,
            forceElevated: true,
            pinned: true,
            shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(40, 200))),
            title: Text("Todo Manager", style: TextStyle(color: greyTint.shade50),),
            actions: [
              IconButton(icon: Icon(Icons.apps), onPressed: () {}),
            ],
            expandedHeight: 2.5 * kToolbarHeight,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: kToolbarHeight),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 16),
                      child: ElevatedButton(child: Text("Add"), onPressed: () {}),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 16),
                      child: ElevatedButton(child: Text("Refresh"), onPressed: () {}),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                childCount: todos.length,
                (_, int index) {
              return ItemListTile(todo: todos[index]);
            }),
          )
        ],
      ),
    );
  }
}

class ErrorLayout extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ErrorLayout(this.error, [this.stackTrace]);

  final Object error;

  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class LoadingLayout extends StatelessWidget {
  const LoadingLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class ItemListTile extends StatelessWidget {
  const ItemListTile({Key? key, required this.todo}) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Dismissible(
        key: Key(todo.toString()),
        child: Card(
          child: ListTile(
            title: Text(todo.title),
            subtitle: Text(todo.completed.toString()),
            trailing: IconButton(
              icon: const Icon(Icons.check_box_outline_blank),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_manager/data/api/entities/todo.dart';
import 'package:todo_manager/provider/todo_provider.dart';

class ItemListTile extends ConsumerWidget {
  const ItemListTile({Key? key, required this.todo}) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(todo.id.toString()),
      onDismissed: (direction) =>
          ref.read(todoNotifierProvider.notifier).removeTodo(todo.id),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: ListTile(
            title: Text(
              todo.id.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              todo.title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              icon: todo.completed
                  ? const Icon(Icons.check_box_outlined)
                  : const Icon(Icons.check_box_outline_blank_outlined),
              onPressed: () => ref
                  .read(todoNotifierProvider.notifier)
                  .toggleCheckMArk(todo.id),
            ),
          ),
        ),
      ),
    );
  }
}

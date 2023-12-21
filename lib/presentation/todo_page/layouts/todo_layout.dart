import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:todo_manager/application/colors.dart';
import 'package:todo_manager/data/api/entities/todo.dart';
import 'package:todo_manager/presentation/shared/app_bar.dart';
import 'package:todo_manager/presentation/todo_page/provider/todo_provider.dart';
import 'package:todo_manager/presentation/shared/background_painter.dart';
import 'package:todo_manager/presentation/todo_page/components/item_tile.dart';

class TodoLayout extends ConsumerStatefulWidget {
  const TodoLayout({Key? key, required this.todos}) : super(key: key);

  final List<Todo> todos;

  @override
  ConsumerState<TodoLayout> createState() => _DataLayoutState();
}

class _DataLayoutState extends ConsumerState<TodoLayout> {
  late ScrollController _controller;
  bool _floatingButtonVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.offset > 10 && _floatingButtonVisible == false) {
        setState(() {
          _floatingButtonVisible = true;
        });
      } else if (_controller.offset <= 10 && _floatingButtonVisible == true) {
        setState(() {
          _floatingButtonVisible = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyTint.shade400,
      body: BackgroundPainter(
        child: Stack(
          children: [
            CustomScrollView(
              controller: _controller,
              slivers: [
                TodoAppBar(
                    title: 'TodoManager',
                    controller: _controller,
                    buttonOnPressed: () => _showDialogWithFields(),
                    buttonText: 'Add Todo',
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: 128),
                  sliver: SliverFixedExtentList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: widget.todos.length, (_, int index) {
                      return ItemListTile(todo: widget.todos[index], key: UniqueKey(),);
                    }),
                    itemExtent: 120,
                  ),
                )
              ],
            ),
            Visibility(
              visible: _floatingButtonVisible,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      height: 80,
                      width: 80,
                      child: FloatingActionButton(
                          backgroundColor: greyTint.shade400,
                          child: Icon(
                            Icons.arrow_circle_up,
                            color: greyTint.shade200,
                            size: 35,
                          ),
                          onPressed: () => _controller.animateTo(0,
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.ease)),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialogWithFields() {
    showDialog(
      context: context,
      builder: (_) {
        var textController = TextEditingController();
        return AlertDialog(
          title: const Text('Add Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: textController,
                decoration:
                    const InputDecoration(hintText: 'What would you like to do?'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                var text = textController.text;
                ref.read(todoNotifierProvider.notifier).addTodo(text);
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

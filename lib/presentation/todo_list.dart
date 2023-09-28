import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_manager/application/colors.dart';
import 'package:todo_manager/presentation/shared/background_painter.dart';
import '../data/api/entities/todo.dart';
import '../provider/todo_provider.dart';



class TodoList extends ConsumerWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final AsyncValue<List<Todo>> posts = ref.watch(todoNotifierProvider);

    return SafeArea(
      top: false,
      child: posts.when(
          data: (posts) => DataLayout(todos: posts),
          error: ErrorLayout.new,
          loading: LoadingLayout.new),
    );
  }
}

class DataLayout extends ConsumerStatefulWidget {
  const DataLayout({Key? key, required this.todos}) : super(key: key);

  final List<Todo> todos;

  @override
  ConsumerState<DataLayout> createState() => _DataLayoutState();
}

class _DataLayoutState extends ConsumerState<DataLayout> {
  
  late ScrollController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
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
                SliverAppBar(
                  backgroundColor: greyTint.shade600,
                  pinned: true,
                  shape: const ContinuousRectangleBorder(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(40))),
                  title: Text("Todo Manager", style: TextStyle(color: greyTint.shade50),),
                  actions: [
                    IconButton(icon: const Icon(Icons.apps), onPressed: () {}),
                  ],
                  expandedHeight: 2.5 * kToolbarHeight,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.only(top: kToolbarHeight * 2),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 16),
                            child: ElevatedButton(child: const Text("Add"), onPressed: () {}),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 16),
                            child: ElevatedButton(child: const Text("Refresh"), onPressed: () {}),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: widget.todos.length,
                      (_, int index) {
                    return ItemListTile(todo: widget.todos[index]);
                  }),
                )
              ],
            ),
            Padding(
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
                        onPressed: () => _controller.animateTo(0, duration: const Duration(milliseconds: 1000), curve: Curves.ease)),
                  )),
            ),
          ],
        ),
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

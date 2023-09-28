import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_manager/data/api/repository/todo_repository.dart';
import 'package:todo_manager/data/api/entities/todo.dart';

final todoProvider = FutureProvider<List<Todo>>((ref) async {
  final todoList = await ref.read(Dependency.todoRepository).getTodos();
  return todoList;
});

final todoNotifierProvider = StateNotifierProvider<TodoNotifier, AsyncValue<List<Todo>>>((ref) {
  return TodoNotifier(ref);
});

class TodoNotifier extends StateNotifier<AsyncValue<List<Todo>>> {
  TodoNotifier(this.ref)
      : super(const AsyncValue.loading()) {
    loadTodos();
  }

  final Ref ref;

  void loadTodos() async {
    state = const AsyncLoading();
    final todoList = ref.watch(todoProvider);
    state = todoList;
  }

  void addTodo(String text) async {
    final todoList = state.value ?? [];
    final lastId = state.value?.last.id ?? 0;
    final todo = Todo(
        userId: state.value?.first.userId ?? 0,
        id: lastId + 1,
        title: text,
        completed: false,
    );
    todoList.add(todo);
    state = AsyncData(todoList);

  }

  void toggleCheckMArk() async {

  }

}
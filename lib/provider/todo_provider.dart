import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_manager/data/api/repository/todo_repository.dart';
import 'package:todo_manager/data/api/entities/todo.dart';

final todoProvider = AutoDisposeFutureProvider<List<Todo>>((ref) async {
  final todoList = await ref.read(Dependency.todoRepository).getTodos();
  return todoList;
});

final todoNotifierProvider =
    StateNotifierProvider<TodoNotifier, AsyncValue<List<Todo>>>((ref) {
  return TodoNotifier(ref);
});

class TodoNotifier extends StateNotifier<AsyncValue<List<Todo>>> {
  TodoNotifier(this.ref) : super(const AsyncLoading()) {
    loadTodos();
  }

  final Ref ref;

  void loadTodos() async {
    final todoList = AsyncValue.guard(() {
      return ref.read(todoProvider.future);
    });
    state = await todoList;
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

  void removeTodo(int id) {
    final todoList = state.value!;
    todoList.removeWhere((element) => element.id == id);
    state = AsyncData(todoList);
  }

  void toggleCheckMark(int id) async {
    final todoList = state.value!;
    final index = todoList.indexWhere((element) => element.id == id);
    final todo = todoList.where((element) => element.id == id).first;
    todoList[index] = todo.copyWith(completed: !todo.completed);
    state = AsyncData(todoList);
  }
}

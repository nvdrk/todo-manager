import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_manager/data/api/client.dart';
import 'package:todo_manager/data/api/entities/todo.dart';

class TodoRepository extends HttpClientInterface {
  TodoRepository({required super.baseURL});

  Future<List<Todo>> getBlogPosts() async {
    try {
      final response = await get<String>('todos');
      return todoFromJson(response.json);
    } on Exception catch (e, _) {
      rethrow;
    }
  }
}

  abstract class Dependency {
  static Provider<TodoRepository> get postRepository => postRepo;
  }

  final postRepo = Provider<TodoRepository>(
  (ref) => TodoRepository(baseURL: 'https://jsonplaceholder.typicode.com/'));



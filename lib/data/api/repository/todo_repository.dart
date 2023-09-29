import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_manager/data/api/http_client.dart';
import 'package:todo_manager/data/api/entities/todo.dart';

class TodoRepository extends HttpClientInterface {
  TodoRepository({required super.baseURL});

  Future<List<Todo>> getTodos([int? id]) async {
    try {
      final response = await get<String>('todos',
          queryParameters: id != null ?{'userId': id} : null);
      return todoFromJson(response.json);
    } on Exception catch (e, _) {
      rethrow;
    }
  }
}

abstract class Dependency {
  static Provider<TodoRepository> get todoRepository => todoRepo;
}

final todoRepo = Provider<TodoRepository>(
    (ref) => TodoRepository(baseURL: 'https://jsonplaceholder.typicode.com/'));

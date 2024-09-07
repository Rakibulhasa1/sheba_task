import '../models/todo.dart';
import '../utils/local_storage.dart';

class TodoService {
  static Future<List<Todo>> getTodos() async {
    final todosData = await LocalStorage.getTodos();
    return todosData;
  }

  static Future<void> addTodo(Todo todo) async {
    final todos = await getTodos();
    todos.add(todo);
    await LocalStorage.saveTodos(todos);
  }

  static Future<void> updateTodo(Todo todo) async {
    final todos = await getTodos();
    final index = todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      todos[index] = todo;
      await LocalStorage.saveTodos(todos);
    }
  }

  static Future<void> deleteTodo(String id) async {
    final todos = await getTodos();
    todos.removeWhere((t) => t.id == id);
    await LocalStorage.saveTodos(todos);
  }
}

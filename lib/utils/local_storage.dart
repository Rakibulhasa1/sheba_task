import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/todo.dart';
import 'dart:io';

class LocalStorage {
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') != null;
  }

  static Future<void> saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> todosMap = todos.map((todo) => todo.toMap()).toList();
    prefs.setString('todos', jsonEncode(todosMap));
  }

  static Future<List<Todo>> getTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todosString = prefs.getString('todos') ?? '[]';
    final List<dynamic> todosJson = jsonDecode(todosString);
    return todosJson.map((json) => Todo.fromMap(json)).toList();
  }


  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
}

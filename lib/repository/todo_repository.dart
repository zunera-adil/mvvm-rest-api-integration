import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm_api/api/http.dart';
import 'package:mvvm_api/model/todo.dart';
import 'package:mvvm_api/res/api_url.dart';

class TodoRepository {
  Future<List<Todo>> fetchTodos(BuildContext context) async {
    try {
      final response = await getJson(ApiEndPoints.todoEndPoint, context);
      final jsonData = response as List<dynamic>;
      return jsonData.map((item) => Todo.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Failed to fetch todos');
    }
  }
  Future<void> saveTodo(Map<String, dynamic> todo, BuildContext context) async {
    try {
      await postJson(ApiEndPoints.todoEndPoint, todo, context);
    } catch (e) {
      throw Exception('Failed to save todo');
    }
  }

  Future<void> deleteTodo(String id, BuildContext context) async {
    try {
      final url = '${ApiEndPoints.todoEndPoint}/$id';
      await http.delete(Uri.parse(url));
    } catch (e) {
      throw Exception('Failed to delete todo');
    }
  }
  Future<void> updateTodo(Map<String, dynamic> todo, String id, BuildContext context) async {
    try {
      final url = '${ApiEndPoints.todoEndPoint}/$id';
      await putJson(url, todo, context);
    } catch (e) {
      throw Exception('Failed to update todo');
    }
  }
}

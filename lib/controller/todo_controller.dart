import 'dart:async';
import 'dart:core';
import 'package:flutter_rest_api/models/todo.dart';
import 'package:flutter_rest_api/repository/repository.dart';

class TodoController {
  final Repository _repository;

  TodoController(this._repository);

  Future<List<Todo>> fetchTodoList() async {
    return _repository.getTodoList();
  }

  Future<String> updatePatchCompleted(Todo todo) async {
    return _repository.patchCompleted(todo);
  }
}

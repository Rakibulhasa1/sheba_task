import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../pages/todo_detail_page.dart';
import '../services/todo_service.dart';

class TodoItemWidget extends StatelessWidget {
  final Todo todo;

  TodoItemWidget({required this.todo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        todo.title,
        style: TextStyle(
          decoration: todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      subtitle: Text('Due: ${todo.dueDate}'),
      trailing: IconButton(
        icon: Icon(todo.isDone ? Icons.check_box : Icons.check_box_outline_blank),
        onPressed: () async {
          todo.isDone = !todo.isDone;
          await TodoService.updateTodo(todo);
        },
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TodoDetailPage(todo: todo)),
        );
      },
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/todo_service.dart';
import 'add_edit_todo_page.dart';

class TodoDetailPage extends StatelessWidget {
  final Todo todo;

  TodoDetailPage({required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditTodoPage(todo: todo),
                ),
              ).then((_) {
                Navigator.pop(context);
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              bool? confirmDelete = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Delete Todo'),
                    content: Text('Are you sure you want to delete this todo?'),
                    actions: [
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      TextButton(
                        child: Text('Delete'),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ],
                  );
                },
              );

              if (confirmDelete == true) {
                await TodoService.deleteTodo(todo.id);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.title,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'Due Date: ${todo.dueDate}',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.category, size: 18, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'Category: ${todo.category}',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Description:',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              todo.description.isNotEmpty
                  ? todo.description
                  : 'No description provided.',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),
            todo.imageUrl.isNotEmpty
                ? ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.file(
                File(todo.imageUrl),
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            )
                : Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey[200],
              ),
              child: Center(
                child: Text(
                  'No image',
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ),
            ),
          ],
        ),
      )

    );
  }
}

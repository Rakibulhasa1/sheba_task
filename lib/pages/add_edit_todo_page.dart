import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/todo.dart';
import '../services/notification_service.dart';
import '../services/todo_service.dart';

class AddEditTodoPage extends StatefulWidget {
  final Todo? todo;

  AddEditTodoPage({this.todo});

  @override
  _AddEditTodoPageState createState() => _AddEditTodoPageState();
}

class _AddEditTodoPageState extends State<AddEditTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  final NotificationService notificationService = NotificationService();
  DateTime? dueDate;
  String? imageUrl;
  String? selectedCategory;
  List<String> categories = ['Work', 'Personal', 'Shopping', 'Fitness', 'Others'];

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      titleController.text = widget.todo!.title;
      descriptionController.text = widget.todo!.description ?? '';
      categoryController.text = widget.todo!.category ?? '';
      dueDate = widget.todo!.dueDate;
      imageUrl = widget.todo!.imageUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo == null ? 'Add Todo' : 'Edit Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.grey.shade50,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                maxLines: 4,
              ),

              SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              items: categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    imageUrl = pickedFile?.path;
                  });
                },
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.5,
                    ),
                  ),
                  child: imageUrl == null
                      ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.photo, size: 50, color: Colors.grey),
                      SizedBox(height: 10),
                      Text(
                        "Drag a photo here or select photos",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(imageUrl!),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  final todo = Todo(
                    id: widget.todo?.id ?? DateTime.now().toString(),
                    title: titleController.text,
                    description: descriptionController.text,
                    category: categoryController.text,
                    dueDate: dueDate ?? DateTime.now(),
                    imageUrl: imageUrl ?? '',
                  );
                  if (widget.todo == null) {
                    await TodoService.addTodo(todo);
                  } else {
                    await TodoService.updateTodo(todo);
                  }
                  Navigator.pop(context);
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff4CAF50),
                        Color(0xff046A08),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.todo == null ? 'Add' : 'Update',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

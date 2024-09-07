import 'dart:convert';

class Todo {
  final String id;
  final String title;
  final String description;
  final String category;
  final DateTime dueDate;
  final String imageUrl;
  bool isDone; // Add this field to represent the completion status

  Todo({
    required this.id,
    required this.title,
    this.description = '',
    this.category = '',
    required this.dueDate,
    this.imageUrl = '',
    this.isDone = false, // Default value for new todos
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'dueDate': dueDate.toIso8601String(),
      'imageUrl': imageUrl,
      'isDone': isDone,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      dueDate: DateTime.parse(map['dueDate']),
      imageUrl: map['imageUrl'] ?? '',
      isDone: map['isDone'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));

  // Method to create a copy with updated values
  Todo copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    DateTime? dueDate,
    String? imageUrl,
    bool? isDone,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      dueDate: dueDate ?? this.dueDate,
      imageUrl: imageUrl ?? this.imageUrl,
      isDone: isDone ?? this.isDone,
    );
  }
}

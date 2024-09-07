import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/todo.dart';
import '../../services/todo_service.dart';
import 'todo_event.dart';
import 'todo_state.dart';


class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<LoadTodo>(_onLoadTodo);
    on<AddTodo>(_onAddTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
  }

  Future<void> _onLoadTodo(LoadTodo event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      final todos = await TodoService.getTodos();
      emit(TodoLoaded(todos));
    } catch (e) {
      emit(TodoError("Failed to load todos"));
    }
  }

  Future<void> _onAddTodo(AddTodo event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      try {
        await TodoService.addTodo(event.todo);
        final updatedTodos = List<Todo>.from((state as TodoLoaded).todos)..add(event.todo);
        emit(TodoLoaded(updatedTodos));
      } catch (e) {
        emit(TodoError("Failed to add todo"));
      }
    }
  }

  Future<void> _onUpdateTodo(UpdateTodo event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      try {
        await TodoService.updateTodo(event.todo);
        final updatedTodos = (state as TodoLoaded).todos.map((todo) {
          return todo.id == event.todo.id ? event.todo : todo;
        }).toList();
        emit(TodoLoaded(updatedTodos));
      } catch (e) {
        emit(TodoError("Failed to update todo"));
      }
    }
  }

  Future<void> _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      try {
        await TodoService.deleteTodo(event.todoId);
        final updatedTodos = (state as TodoLoaded).todos.where((todo) => todo.id != event.todoId).toList();
        emit(TodoLoaded(updatedTodos));
      } catch (e) {
        emit(TodoError("Failed to delete todo"));
      }
    }
  }
}

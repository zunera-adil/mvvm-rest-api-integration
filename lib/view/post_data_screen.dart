import 'package:flutter/material.dart';
import 'package:mvvm_api/model/todo.dart';
import 'package:mvvm_api/repository/todo_repository.dart';
import 'package:mvvm_api/view_model/todo_view_model.dart';

class PostDataScreen extends StatefulWidget {
  final TodoViewModel? todoViewModel;
  final Todo? todo;

  const PostDataScreen({
    Key? key,
    this.todoViewModel,
    this.todo,
  }) : super(key: key);

  @override
  PostDataScreenState createState() => PostDataScreenState();
}

class PostDataScreenState extends State<PostDataScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todo?.taskTitle ?? '');
    _descriptionController = TextEditingController(text: widget.todo?.taskDescription ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveTodo() async {
    final newTodoData = {
      "task_title": _titleController.text,
      "task_description": _descriptionController.text,
    };
    final newTodoDataForUpdate = {
      "task_title": _titleController.text,
      "task_description": _descriptionController.text,
    };

    try {
      if (widget.todo != null) {
        await TodoRepository().updateTodo(newTodoDataForUpdate,widget.todo?.id ?? '',context);

      } else {
        await TodoRepository().saveTodo(newTodoData,context);
      }
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } catch (e) {
      throw Exception('Failed to save todo');    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: _saveTodo,
              child:  Text(widget.todo != null ? 'Update' : 'Add'),
            ),
          ],
        ),
      ),
    );
  }
}



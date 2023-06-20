import 'package:flutter/material.dart';
import 'package:mvvm_api/repository/todo_repository.dart';
import 'package:mvvm_api/view/post_data_screen.dart';
import 'package:mvvm_api/view_model/todo_view_model.dart';
import 'package:provider/provider.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todoViewModel = Provider.of<TodoViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: FutureBuilder(
        future: todoViewModel.fetchTodos(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount:todoViewModel.todos.length,
              itemBuilder: (context, index) {
                final todo = todoViewModel.todos[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    tileColor:Colors.blue.withOpacity(0.3) ,
                    title: Text(todo.taskTitle,style: const TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text(todo.taskDescription,style: const TextStyle(fontWeight: FontWeight.normal),),
                    trailing:  Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: ()  {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostDataScreen(todo: todo),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit, color: Colors.green),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () => TodoRepository().deleteTodo(todo.id,context),
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostDataScreen(todoViewModel: todoViewModel,),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
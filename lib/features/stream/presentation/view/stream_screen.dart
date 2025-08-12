import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:practice_stream/features/stream/domain/entities/todo_entities.dart';
import 'package:practice_stream/features/stream/presentation/widget/todo_field.dart';

import '../controller/todo_bloc.dart';

class StreamScreen extends StatefulWidget {
  const StreamScreen({super.key});

  @override
  State<StreamScreen> createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {
  List<TodoEntities> todos = [];

  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(GetTodosEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  void addTodo(TodoEntities todoData) {
    context.read<TodoBloc>().add(AddTodoEvent(todoData));
  }

  void updateTodo(TodoEntities todoData) {
    context.read<TodoBloc>().add(UpdateTodoEvent(todoData));
  }

  void deleteTodo(TodoEntities todoData) {
    context.read<TodoBloc>().add(DeleteTodoEvent(todoData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stream')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocListener<TodoBloc, TodoState>(
            listener: (context, state) {
              if (state is TodoLoadedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Center(
                      child: Text(
                        state.successMessage,
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                );
              }
            },
            child: Container(),
          ),
          BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              if (state is TodoInitialState) {
                return const Text('No Data');
              } else if (state is TodoLoadingState) {
                return SizedBox(
                  height: 500,
                  width: 50,
                  child: Center(child: const CircularProgressIndicator()),
                );
              } else if (state is TodoLoadedState) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.todoListEntities.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: TodoField(
                                    todoData: state.todoListEntities[index],
                                    onSubmitted: (todo) {
                                      updateTodo(todo);
                                      Navigator.pop(context);
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          title: Text(state.todoListEntities[index].title),
                          leading: Checkbox(
                            value: state.todoListEntities[index].completed,
                            onChanged: (value) {},
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              deleteTodo(state.todoListEntities[index]);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (state is TodoErrorState) {
                return Text(state.message);
              } else {
                return const SizedBox.shrink();
              }
            },
          ),

          Column(
            children: [
              const SizedBox(height: 10),
              Center(
                child: FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: TodoField(
                            onSubmitted: (todo) {
                              addTodo(todo);
                              Navigator.pop(context);
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}

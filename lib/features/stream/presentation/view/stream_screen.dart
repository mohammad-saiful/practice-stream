import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_stream/core/di/setup_dependencies.dart';

import 'package:practice_stream/features/stream/domain/entities/todo_entities.dart';
import 'package:practice_stream/features/stream/presentation/widget/todo_field.dart';

import '../cubit/todo_cubit.dart';

class StreamScreen extends StatefulWidget {
  const StreamScreen({super.key});

  @override
  State<StreamScreen> createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {
  List<TodoEntities> todos = [];
  final _todoCubit = getIt<TodoCubit>();

  @override
  void initState() {
    super.initState();
    _todoCubit.fetchTodos();
  }

  @override
  void dispose() {
    super.dispose();
    _todoCubit.close();
  }

  void addTodo(TodoEntities todoData) {
    _todoCubit.addTodo(todoData);
  }

  void updateTodo(TodoEntities todoData) {
    _todoCubit.updateTodo(todoData);
  }

  void deleteTodo(TodoEntities todoData) {
    _todoCubit.deleteTodo(todoData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stream')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocListener<TodoCubit, TodoState>(
            bloc: _todoCubit,
            listener: (context, state) {
              if (state.status.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Center(
                      child: Text(
                        state.message!,
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                );
              }
            },
            child: Container(),
          ),
          BlocBuilder<TodoCubit, TodoState>(
            bloc: _todoCubit,
            builder: (context, state) {
              if (state.status.isInitial) {
                return const Text('No Data');
              } else if (state.status.isLoading) {
                return SizedBox(
                  height: 500,
                  width: 50,
                  child: Center(child: const CircularProgressIndicator()),
                );
              } else if (state.status.isSuccess) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.todos!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: TodoField(
                                    todoData: state.todos![index],
                                    onSubmitted: (todo) {
                                      updateTodo(todo);
                                      Navigator.pop(context);
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          title: Text(state.todos![index].title),
                          leading: Checkbox(
                            value: state.todos![index].completed,
                            onChanged: (value) {},
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              deleteTodo(state.todos![index]);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (state.status.isError) {
                return Text(state.message!);
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

import 'package:flutter/material.dart';

import 'package:practice_stream/features/stream/domain/entities/todo_entities.dart';
import 'package:practice_stream/features/stream/presentation/controller/todo_controller.dart';
import 'package:practice_stream/features/stream/presentation/widget/todo_field.dart';

class StreamScreen extends StatefulWidget {
  const StreamScreen({super.key});

  @override
  State<StreamScreen> createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {
  List<TodoEntities> todos = [];
  late TodoController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TodoController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.init();
    });
  }

  void addTodo(TodoEntities todoData) {
    _controller.add(todoData);
  }

  void updateTodo(TodoEntities todoData) {
    _controller.update(todoData);
  }

  void deleteTodo(TodoEntities todoData) {
    _controller.delete(todoData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stream')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder<Status>(
            stream: _controller.loadingStateStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == Status.initial) {
                  return const Text('No Data');
                } else if (snapshot.data == Status.loading) {
                  return SizedBox(
                    height: 500,
                    width: 50,
                    child: Center(child: const CircularProgressIndicator()),
                  );
                } else if (snapshot.data == Status.success) {
                  return StreamBuilder<List<TodoEntities>>(
                    stream: _controller.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Expanded(
                          child:
                              snapshot.data!.isEmpty
                                  ? const Center(child: Text('No Data Found'))
                                  : ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        child: ListTile(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: TodoField(
                                                    todoData:
                                                        snapshot.data![index],
                                                    onSubmitted: (todo) {
                                                      updateTodo(todo);
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          title: Text(
                                            snapshot.data![index].title,
                                          ),
                                          leading: Checkbox(
                                            value:
                                                snapshot.data![index].completed,
                                            onChanged: (value) {},
                                          ),
                                          trailing: IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed: () {
                                              deleteTodo(snapshot.data![index]);
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  );
                } else if (snapshot.data == Status.error) {
                  return const Text('Error');
                } else {
                  return const SizedBox.shrink();
                }
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const Text('No Data');
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

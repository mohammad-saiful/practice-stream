import 'package:flutter/material.dart';

import 'package:practice_stream/features/stream/domain/entities/todo_entities.dart';
import 'package:practice_stream/features/stream/presentation/controller/todo_controller.dart';

import '../../domain/entities/loading_state.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_)  {
      _controller.startListeningToTodos();
    });
    _controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stream')),
      body: StreamBuilder<LoadingStateData>(
        stream: _controller.loadingStateStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.initial) {
              return const Text('No Data Found');
            } else if (snapshot.data!.loading) {
              return const CircularProgressIndicator();
            } else if (snapshot.data!.success) {
              return StreamBuilder<List<TodoEntities>>(
                stream: _controller.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length + 1,
                      itemBuilder: (context, index) {
                        if (index == snapshot.data!.length) {
                          return Column(
                            children: [
                              const SizedBox(height: 10),
                              FloatingActionButton(
                                child: const Icon(Icons.add),
                                onPressed: () {
                                  _controller.add(
                                    TodoEntities(
                                      id: 0,
                                      title: "this is title",
                                      completed: false,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        }
                        return Card(
                          child: ListTile(
                            title: Text(snapshot.data![index].title),
                            trailing: Checkbox(
                              value: snapshot.data![index].completed,
                              onChanged: (value) {},
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Text('No Data');
                  }
                },
              );
            } else if (snapshot.data!.error) {
              return const Text('Error');
            } else {
              return const SizedBox.shrink();
            }
          } else {
            return const Text('No Data');
          }
        },
      ),
    );
  }
}

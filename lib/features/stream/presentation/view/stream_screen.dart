import 'package:flutter/material.dart';

import 'package:practice_stream/features/stream/domain/entities/todo_entities.dart';
import 'package:practice_stream/features/stream/presentation/controller/todo_controller.dart';

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
    _controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stream')),
      body: StreamBuilder<TodoEntities>(
        stream: _controller.stream,
        builder: (context, snapshot) {
        if (snapshot.hasData) {
            todos.add(snapshot.data!);

            return ListView.builder(
              itemCount: todos.length + 1,
              itemBuilder: (context, index) {
                if (index == todos.length) {
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
                    ],
                  );
                }

                return Card(
                  child: ListTile(
                    title: Text(todos[index].title),
                    trailing: Checkbox(
                      value: todos[index].completed,
                      onChanged: (value) {},
                    ),
                  ),
                );

               // return Text(todos[index].title);
              },
            );
          } else {
            return const Text('No Data');
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:practice_stream/core/di/dependency_inject.dart';

import 'features/stream/presentation/view/stream_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: SafeArea(child: const StreamScreen()),
    );
  }
}

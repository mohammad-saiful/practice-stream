import 'package:flutter/material.dart';
import 'package:practice_stream/core/di/setup_dependencies.dart';

import 'features/stream/presentation/view/stream_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SetupDependencies.init();
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

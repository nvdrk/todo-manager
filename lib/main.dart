import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_manager/presentation/todo_list.dart';
import 'application/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: greyTint,
        iconTheme: IconThemeData(color: greyTint.shade800)
      ),
      home: const ProviderScope(child: TodoList()),
    );
  }
}



import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_manager/presentation/todo_page/todo_page.dart';
import 'application/colors.dart';

void main() {
  runZonedGuarded(
    () => runApp(const TodoManager()),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

class TodoManager extends StatelessWidget {
  const TodoManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Manager',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: greyTint,
      ),
      home: const ProviderScope(child: TodoPage()),
    );
  }
}

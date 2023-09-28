import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: greyTint,
      ),
      home: const ProviderScope(child: TodoPage()),
    );
  }
}

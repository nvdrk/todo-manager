import 'package:flutter/material.dart';

class ErrorLayout extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ErrorLayout(this.error, [this.stackTrace]);

  final Object error;

  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error.toString()),
    );
  }
}
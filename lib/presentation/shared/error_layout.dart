import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:todo_manager/application/colors.dart';
import 'package:todo_manager/provider/todo_provider.dart';
import 'app_bar.dart';
import 'background_painter.dart';

class ErrorLayout extends ConsumerWidget {
  // ignore: use_key_in_widget_constructors
  const ErrorLayout(this.error, [this.stackTrace]);

  final Object error;

  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: greyTint.shade400,
      body: BackgroundPainter(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                const TodoAppBar(
                  title: 'TodoManager',
                ),
                SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Something went wrong',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        kDebugMode
                            ? Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  error.toString(),
                                  style: const TextStyle(fontSize: 16),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 20,
                                ),
                              )
                            : const SizedBox.shrink(),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              ref.invalidate(todoNotifierProvider);
                            },
                            child: const Text('Reload'),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

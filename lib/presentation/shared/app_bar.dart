import 'package:flutter/material.dart';
import 'package:todo_manager/application/colors.dart';

class TodoAppBar extends StatelessWidget {
  const TodoAppBar({super.key, this.controller, this.buttonOnPressed, this.buttonText, required this.title});

  final String title;
  final ScrollController? controller;
  final VoidCallback? buttonOnPressed;
  final String? buttonText;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: greyTint.shade600,
      pinned: true,
      collapsedHeight: 60,
      shape: const ContinuousRectangleBorder(
          borderRadius:
          BorderRadius.vertical(bottom: Radius.circular(40))),
      title: Text(
        title,
        style: TextStyle(color: greyTint.shade50),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.arrow_circle_down),
          onPressed: () => controller != null ? controller!.animateTo(
              controller!.position.maxScrollExtent,
              duration: const Duration(milliseconds: 1500),
              curve: Curves.fastOutSlowIn) : null,
        ),
      ],
      expandedHeight: kToolbarHeight * 2.5,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: kToolbarHeight * 2),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (buttonOnPressed != null && buttonText != null) ? ElevatedButton(
                  onPressed: buttonOnPressed,
                  child: Text(buttonText!)) : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

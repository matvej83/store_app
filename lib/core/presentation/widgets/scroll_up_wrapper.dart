import 'package:flutter/material.dart';
import 'package:store_app/core/presentation/widgets/scroll_up_button.dart';

class ScrollUpWrapper extends StatelessWidget {
  const ScrollUpWrapper({
    super.key,
    required this.controller,
    required this.child,
  });

  final ScrollController controller;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: ScrollUpButton(scrollController: controller),
        ),
      ],
    );
  }
}

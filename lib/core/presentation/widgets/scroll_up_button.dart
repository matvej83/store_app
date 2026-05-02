import 'package:flutter/material.dart';

class ScrollUpButton extends StatefulWidget {
  const ScrollUpButton({
    super.key,
    required this.scrollController,
    this.threshold = 280.0,
  });

  final ScrollController scrollController;
  final double threshold;

  @override
  State<ScrollUpButton> createState() => _ScrollUpButtonState();
}

class _ScrollUpButtonState extends State<ScrollUpButton> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final shouldShow =
        widget.scrollController.position.pixels > widget.threshold;

    if (shouldShow != _visible) {
      setState(() => _visible = shouldShow);
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        );

        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -0.7),
            end: Offset.zero,
          ).animate(curved),
          child: FadeTransition(opacity: curved, child: child),
        );
      },
      child: _visible
          ? Padding(
              key: const ValueKey('scrollUpButton'),
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                child: IconButton.outlined(
                  padding: const EdgeInsets.all(8.0),
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(const CircleBorder()),
                    backgroundColor: WidgetStateProperty.all(
                      theme.unselectedWidgetColor.withValues(alpha: 0.8),
                    ),
                  ),
                  onPressed: () {
                    widget.scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOut,
                    );
                  },
                  icon: const Icon(Icons.arrow_upward_outlined, size: 24),
                ),
              ),
            )
          : const SizedBox(key: ValueKey('empty')),
    );
  }
}

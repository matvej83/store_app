import 'package:flutter/material.dart';

import '../../utils.dart';

class CategorySearch extends StatefulWidget {
  const CategorySearch({
    super.key,
    required this.title,
    required this.onSearchStarted,
  });

  final String title;
  final Function(String) onSearchStarted;

  @override
  State<CategorySearch> createState() => _CategorySearchState();
}

class _CategorySearchState extends State<CategorySearch> {
  bool isActive = false;

  void _toggleSearch() {
    setState(() {
      isActive = !isActive;
    });
    if (!isActive) {
      widget.onSearchStarted('');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      spacing: 4.0,
      children: [
        Row(
          spacing: 4.0,
          children: [
            Text(widget.title, style: textTheme.titleMedium),
            ProductsUtils.getSearchCategoryButton(
              context,
              isActive: isActive,
              onTap: _toggleSearch,
            ),
          ],
        ),

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          transitionBuilder: (child, animation) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(0, -0.2),
              end: Offset.zero,
            ).animate(animation);

            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: offsetAnimation,
                child: SizeTransition(
                  sizeFactor: animation,
                  alignment: const Alignment(0.0, -1.0),
                  child: child,
                ),
              ),
            );
          },
          child: isActive
              ? Row(
                  key: const ValueKey('search'),
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40.0,
                        child: SearchBar(
                          leading: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          onTapOutside: (PointerDownEvent event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          onChanged: widget.onSearchStarted,
                        ),
                      ),
                    ),
                  ],
                )
              : const SizedBox(key: ValueKey('empty')),
        ),
      ],
    );
  }
}

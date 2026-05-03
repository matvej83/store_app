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
        if (isActive)
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40.0,
                  child: SearchBar(
                    leading: const Icon(Icons.search, color: Colors.white),
                    onTapOutside: (PointerDownEvent event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    onChanged: widget.onSearchStarted,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

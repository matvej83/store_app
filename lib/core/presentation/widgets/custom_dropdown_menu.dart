import 'package:flutter/material.dart';

class CustomDropdownMenu<T> extends StatelessWidget {
  const CustomDropdownMenu({
    super.key,
    required this.initialValue,
    required this.onChanged,
    required this.entries,
    this.leadingIcon,
    this.trailingIcon,
    this.selectedTrailingIcon,
  });

  final T initialValue;
  final ValueChanged<T?> onChanged;
  final List<DropdownMenuEntry<T>> entries;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final Widget? selectedTrailingIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IconButtonTheme(
      data: IconButtonThemeData(
        style: IconButton.styleFrom(
          backgroundColor: theme.colorScheme.surfaceTint,
        ),
      ),
      child: DropdownMenu<T>(
        initialSelection: initialValue,
        onSelected: (T? value) {
          if (value != null) {
            onChanged(value);
          }
        },
        dropdownMenuEntries: entries,
        leadingIcon: leadingIcon,
        trailingIcon: trailingIcon,
        selectedTrailingIcon: selectedTrailingIcon,
        requestFocusOnTap: false,
        selectOnly: true,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppDialog {
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String text,
    required String cancelText,
    required String okText,
  }) async {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: textTheme.titleMedium),
        content: Text(text, style: textTheme.bodyMedium),
        actions: [
          TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.grey),
            onPressed: () => context.pop(false),
            child: Text(
              cancelText,
              style: textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: theme.colorScheme.error,
            ),
            onPressed: () => context.pop(true),
            child: Text(
              okText,
              style: textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );

    return result ?? false;
  }
}

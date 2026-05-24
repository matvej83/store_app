import 'package:flutter/material.dart';
import 'package:store_app/utils.dart';

class AvatarPlaceholder extends StatelessWidget {
  const AvatarPlaceholder({
    super.key,
    this.size,
    required this.firstName,
    required this.lastName,
    this.backgroundColor,
  });

  final double? size;
  final String firstName;
  final String lastName;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    return Container(
      width: size,
      height: size,
      color: backgroundColor,
      child: Row(
        children: [
          Text(
            AppUtils.getFirstLetter(firstName).toUpperCase(),
            style: textStyle,
          ),
          Text(
            AppUtils.getFirstLetter(lastName).toUpperCase(),
            style: textStyle,
          ),
        ],
      ),
    );
  }
}

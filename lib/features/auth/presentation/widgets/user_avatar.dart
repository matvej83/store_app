import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture_test/core/presentation/widgets/avatar_placeholder.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.avatar,
    this.size = 40.0,
    this.firstName,
    this.lastName,
  });

  final String avatar;
  final String? firstName;
  final String? lastName;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CircleAvatar(
      radius: size,
      backgroundImage: CachedNetworkImageProvider(avatar),
      backgroundColor: theme.unselectedWidgetColor,
      onBackgroundImageError: (o, s) => AvatarPlaceholder(
        firstName: firstName ?? '',
        lastName: lastName ?? '',
      ),
    );
  }
}

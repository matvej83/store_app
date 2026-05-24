import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/core/presentation/widgets/scroll_up_wrapper.dart';
import 'package:store_app/features/auth/domain/entity/user_entity.dart';
import 'package:store_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:store_app/features/auth/presentation/widgets/user_avatar.dart';
import 'package:store_app/features/users/presentation/bloc/users_bloc.dart';
import 'package:store_app/features/users/presentation/bloc/users_event.dart';
import 'package:store_app/utils.dart';

import '../../../../navigation/pages.dart';

class UsersList extends StatelessWidget {
  const UsersList({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UsersBloc>();
    final theme = Theme.of(context);
    final state = context.watch<UsersBloc>().state;
    final authState = context.read<AuthBloc>().state;
    return ScrollUpWrapper(
      controller: scrollController,
      child: ListView.separated(
        controller: scrollController,
        itemCount: state.users.length,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        itemBuilder: (context, index) {
          final user = state.users[index];
          if (index >= state.users.length - 5) {
            bloc.add(const MoreUsersLoaded());
          }
          if (index < state.users.length) {
            return ListItem(
              key: ValueKey(user.id),
              areYou: authState.user?.id == user.id,
              onTap: () {
                context.go('${Pages.users}/${user.id}');
              },
              user: user,
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
        separatorBuilder: (context, index) => Divider(
          height: 16.0,
          thickness: 1.0,
          color: theme.unselectedWidgetColor,
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.onTap,
    this.areYou = false,
    required this.user,
  });

  final UserEntity user;
  final bool areYou;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final firstName = AppUtils.getFirstName(user.name);
    final lastName = AppUtils.getLastName(user.name);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          spacing: 8.0,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UserAvatar(
              avatar: user.avatar,
              firstName: firstName,
              lastName: lastName,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user.name}${areYou ? ' (${'you'.tr()})' : ''}',
                    style: textTheme.bodyMedium,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    maxLines: 2,
                  ),
                  Text(user.email, style: textTheme.bodySmall),
                ],
              ),
            ),
            Text(
              user.role,
              style: textTheme.bodySmall?.copyWith(color: Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }
}

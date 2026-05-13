import 'package:carousel_slider/carousel_controller.dart';
import 'package:clean_architecture_test/features/auth/presentation/widgets/user_avatar.dart';
import 'package:clean_architecture_test/features/users/presentation/bloc/users_bloc.dart';
import 'package:clean_architecture_test/features/users/presentation/bloc/users_event.dart';
import 'package:clean_architecture_test/features/users/presentation/bloc/users_state.dart';
import 'package:clean_architecture_test/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key, required this.id});

  final String id;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final controller = CarouselSliderController();

  @override
  void initState() {
    context.read<UsersBloc>().add(UserFetched(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Container(
      color: theme.scaffoldBackgroundColor,
      child: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          final avatar = state.user?.avatar ?? '';
          final name = state.user?.name ?? '';
          final firstName = AppUtils.getFirstName(name);
          final lastName = AppUtils.getLastName(name);
          return state.isUserLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      spacing: 24.0,
                      children: [
                        UserAvatar(
                          avatar: avatar,
                          size: 120.0,
                          firstName: firstName,
                          lastName: lastName,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          spacing: 8.0,
                          children: [
                            Text(
                              state.user?.email ?? '',
                              style: textTheme.bodyMedium,
                            ),
                            Text(
                              state.user?.name ?? '',
                              style: textTheme.bodyLarge,
                            ),
                            Text(
                              state.user?.role ?? '',
                              style: textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}

import 'package:clean_architecture_test/features/users/presentation/bloc/users_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/users_bloc.dart';
import '../bloc/users_state.dart';
import '../widgets/users_list.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final _scrollController = ScrollController();
  final _showScrollUp = ValueNotifier<bool>(false);

  void _onScroll() {
    _showScrollUp.value = _scrollController.position.pixels > 280.0;
  }

  @override
  void initState() {
    context.read<UsersBloc>().add(const UsersFetched());
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _showScrollUp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        return state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : UsersList(
                scrollController: _scrollController,
                showScrollUp: _showScrollUp,
              );
      },
    );
  }
}

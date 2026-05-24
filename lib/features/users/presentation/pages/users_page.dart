import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/users/presentation/bloc/users_event.dart';

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

  @override
  void initState() {
    context.read<UsersBloc>().add(const UsersFetched());
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        return state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : UsersList(scrollController: _scrollController);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/core/constants/app_strings.dart';
import 'package:store_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:store_app/features/auth/presentation/bloc/auth_event.dart';

import '../../../../core/presentation/widgets/infinite_scroll_background.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(const AuthCheckRequested());
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: InfiniteScrollingBackground(
          animationHeight: 250.0,
          foregroundImageSize: 160.0,
          backgroundImage: AppStrings.wall,
          foregroundImage: AppStrings.cart,
        ),
      ),
    );
  }
}

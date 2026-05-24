import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:store_app/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:store_app/features/theme/cubit/state.dart';
import 'package:store_app/features/users/presentation/bloc/users_bloc.dart';
import 'package:store_app/navigation/pages.dart';
import 'package:store_app/navigation/router.dart';

import 'core/di/injection.dart';
import 'core/services/auth_session_manager.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/products/presentation/bloc/products_bloc.dart';
import 'features/theme/cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await configureDependencies();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ru')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final StreamSubscription _sessionSub;
  final appRouter = getIt<AppRouter>();
  final authBloc = getIt<AuthBloc>();
  final themeCubit = getIt<ThemeCubit>();
  final sessionManager = getIt<AuthSessionManager>();
  final authRepo = getIt<AuthRepository>();

  @override
  void initState() {
    super.initState();
    sessionManager.setRepository(authRepo);
    _sessionSub = sessionManager.onSessionExpired.listen((_) async {
      await sessionManager.logout();
      appRouter.router.go(Pages.login);
    });
  }

  @override
  void dispose() {
    _sessionSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => authBloc),
        BlocProvider(create: (_) => themeCubit..loadTheme()),
        BlocProvider(create: (_) => getIt<ProductsBloc>(), lazy: true),
        BlocProvider(create: (_) => getIt<UsersBloc>(), lazy: true),
        BlocProvider(create: (_) => getIt<LocationsBloc>(), lazy: true),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Store App',
            routerConfig: appRouter.router,
            debugShowCheckedModeBanner: false,
            theme: state.theme,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
          );
        },
      ),
    );
  }
}

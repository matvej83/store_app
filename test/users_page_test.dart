import 'dart:async';

import 'package:clean_architecture_test/features/auth/domain/entity/user_entity.dart';
import 'package:clean_architecture_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_architecture_test/features/auth/presentation/bloc/auth_event.dart';
import 'package:clean_architecture_test/features/auth/presentation/bloc/auth_state.dart';
import 'package:clean_architecture_test/features/users/presentation/bloc/users_bloc.dart';
import 'package:clean_architecture_test/features/users/presentation/bloc/users_event.dart';
import 'package:clean_architecture_test/features/users/presentation/bloc/users_state.dart';
import 'package:clean_architecture_test/features/users/presentation/pages/users_page.dart';
import 'package:clean_architecture_test/features/users/presentation/widgets/users_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUsersBloc extends Mock implements UsersBloc {}

class MockAuthBloc extends Mock implements AuthBloc {}

class FakeUsersState extends Fake implements UsersState {}

class FakeAuthState extends Fake implements AuthState {}

class FakeUsersEvent extends Fake implements UsersEvent {}

class FakeAuthEvent extends Fake implements AuthEvent {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerFallbackValue(FakeUsersState());
    registerFallbackValue(FakeUsersEvent());
    registerFallbackValue(FakeAuthState());
    registerFallbackValue(FakeAuthEvent());
  });

  late MockUsersBloc usersBloc;
  late MockAuthBloc authBloc;
  late StreamController<UsersState> usersController;
  late StreamController<AuthState> authController;

  setUp(() {
    usersBloc = MockUsersBloc();
    authBloc = MockAuthBloc();
    usersController = StreamController<UsersState>.broadcast();
    authController = StreamController<AuthState>.broadcast();
  });

  tearDown(() {
    usersController.close();
    authController.close();
  });

  Widget createWidget() {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      startLocale: const Locale('en'),
      path: 'assets/translations/en.json',
      fallbackLocale: const Locale('en'),
      child: MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<UsersBloc>.value(value: usersBloc),
            BlocProvider<AuthBloc>.value(value: authBloc),
          ],
          child: const UsersPage(),
        ),
      ),
    );
  }

  group('UsersPage Tests', () {
    testWidgets('UsersPage displays loading indicator when loading', (
      tester,
    ) async {
      when(() => usersBloc.state).thenReturn(const UsersState(isLoading: true));
      when(() => usersBloc.stream).thenAnswer((_) => usersController.stream);
      when(() => authBloc.state).thenReturn(const AuthState());
      when(() => authBloc.stream).thenAnswer((_) => authController.stream);

      await tester.pumpWidget(createWidget());
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('UsersPage displays users list when data is available', (
      tester,
    ) async {
      final users = [
        const UserEntity(
          id: '1',
          email: 'user1@example.com',
          name: 'User One',
          role: 'admin',
          avatar: 'avatar1.jpg',
        ),
        const UserEntity(
          id: '2',
          email: 'user2@example.com',
          name: 'User Two',
          role: 'user',
          avatar: 'avatar2.jpg',
        ),
      ];

      when(() => usersBloc.state).thenReturn(UsersState(users: users));
      when(() => usersBloc.stream).thenAnswer((_) => usersController.stream);
      when(() => authBloc.state).thenReturn(const AuthState());
      when(() => authBloc.stream).thenAnswer((_) => authController.stream);

      await tester.pumpWidget(createWidget());
      await tester.pumpAndSettle();

      expect(find.byType(UsersList), findsOneWidget);
      expect(find.text('User One'), findsOneWidget);
      expect(find.text('User Two'), findsOneWidget);
    });

    testWidgets('UsersPage triggers UsersFetched on init', (tester) async {
      when(() => usersBloc.state).thenReturn(const UsersState());
      when(() => usersBloc.stream).thenAnswer((_) => usersController.stream);
      when(() => authBloc.state).thenReturn(const AuthState());
      when(() => authBloc.stream).thenAnswer((_) => authController.stream);

      await tester.pumpWidget(createWidget());
      await tester.pump();

      verify(() => usersBloc.add(const UsersFetched())).called(1);
    });
  });
}

import 'dart:async';

import 'package:clean_architecture_test/core/presentation/widgets/image_box.dart';
import 'package:clean_architecture_test/features/auth/domain/entity/user_entity.dart';
import 'package:clean_architecture_test/features/users/presentation/bloc/users_bloc.dart';
import 'package:clean_architecture_test/features/users/presentation/bloc/users_event.dart';
import 'package:clean_architecture_test/features/users/presentation/bloc/users_state.dart';
import 'package:clean_architecture_test/features/users/presentation/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mocks
class MockUsersBloc extends Mock implements UsersBloc {}

class FakeUsersState extends Fake implements UsersState {}

class FakeUsersEvent extends Fake implements UsersEvent {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerFallbackValue(FakeUsersState());
    registerFallbackValue(FakeUsersEvent());
  });

  late MockUsersBloc usersBloc;
  late StreamController<UsersState> usersController;

  setUp(() {
    usersBloc = MockUsersBloc();
    usersController = StreamController<UsersState>.broadcast();
  });

  tearDown(() {
    usersController.close();
  });

  Widget createWidget({required String userId}) {
    return MaterialApp(
      home: BlocProvider<UsersBloc>.value(
        value: usersBloc,
        child: UserPage(id: userId),
      ),
    );
  }

  testWidgets('UserPage shows loading indicator when loading', (tester) async {
    when(
      () => usersBloc.state,
    ).thenReturn(const UsersState(isUserLoading: true));
    when(() => usersBloc.stream).thenAnswer((_) => usersController.stream);

    await tester.pumpWidget(createWidget(userId: '1'));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('UserPage displays user information when data is available', (
    tester,
  ) async {
    final user = const UserEntity(
      id: '1',
      email: 'john@example.com',
      name: 'John Doe',
      role: 'admin',
      avatar: 'https://example.com/avatar.jpg',
    );

    when(() => usersBloc.state).thenReturn(UsersState(user: user));

    when(() => usersBloc.stream).thenAnswer((_) => usersController.stream);

    await tester.pumpWidget(createWidget(userId: '1'));

    // not pumpAndSettle!
    await tester.pump();

    // Verify that ImageBox is displayed with the correct image URL
    final imageBoxFinder = find.byWidgetPredicate(
      (widget) => widget is ImageBox && widget.imageUrl == user.avatar,
    );

    expect(imageBoxFinder, findsOneWidget);

    // Verify text fields
    expect(find.text(user.email), findsOneWidget);
    expect(find.text(user.name), findsOneWidget);
    expect(find.text(user.role), findsOneWidget);
  });
}

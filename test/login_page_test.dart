import 'package:bloc_test/bloc_test.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:store_app/core/presentation/widgets/app_text_form_field.dart';
import 'package:store_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:store_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:store_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:store_app/features/auth/presentation/pages/login_page.dart';

class MockAuthBloc extends Mock implements AuthBloc {}

class FakeAuthState extends Fake implements AuthState {}

class FakeAuthEvent extends Fake implements AuthEvent {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerFallbackValue(FakeAuthState());
    registerFallbackValue(FakeAuthEvent());
  });

  late MockAuthBloc mockBloc;

  Widget createWidget() {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      startLocale: const Locale('en'),
      path: 'assets/translations/en.json',
      fallbackLocale: const Locale('en'),
      child: MaterialApp(
        home: BlocProvider<AuthBloc>.value(
          value: mockBloc,
          child: const LoginPage(),
        ),
      ),
    );
  }

  setUp(() {
    mockBloc = MockAuthBloc();

    when(() => mockBloc.state).thenReturn(
      const AuthState(status: AuthStatus.unauthenticated, isLoading: false),
    );

    whenListen(
      mockBloc,
      Stream<AuthState>.fromIterable([
        const AuthState(status: AuthStatus.unauthenticated, isLoading: false),
      ]),
    );
  });

  testWidgets('LoginPage renders correctly', (tester) async {
    await tester.pumpWidget(createWidget());
    await tester.pumpAndSettle();

    expect(find.byType(LoginPage), findsOneWidget);
  });

  testWidgets('LoginPage has email and password fields', (tester) async {
    await tester.pumpWidget(createWidget());
    await tester.pumpAndSettle();

    expect(find.byType(AppTextFormField), findsNWidgets(2));
  });

  testWidgets('LoginPage has login button', (tester) async {
    await tester.pumpWidget(createWidget());
    await tester.pumpAndSettle();

    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('Shows loader inside button when loading', (tester) async {
    when(() => mockBloc.state).thenReturn(
      const AuthState(status: AuthStatus.unauthenticated, isLoading: true),
    );

    whenListen(
      mockBloc,
      Stream.value(
        const AuthState(status: AuthStatus.unauthenticated, isLoading: true),
      ),
    );

    await tester.pumpWidget(createWidget());
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Login with valid data triggers AuthLoginRequested', (
    tester,
  ) async {
    await tester.pumpWidget(createWidget());
    await tester.pumpAndSettle();

    // Enter email
    await tester.enterText(
      find.byType(AppTextFormField).at(0),
      'john@mail.com',
    );

    // Enter пароль
    await tester.enterText(find.byType(AppTextFormField).at(1), 'changeme');

    // Oush the button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Check that event is sent
    verify(
      () => mockBloc.add(
        any(
          that: isA<AuthLoginRequested>()
              .having((e) => e.email, 'email', 'john@mail.com')
              .having((e) => e.password, 'password', 'changeme'),
        ),
      ),
    ).called(1);
  });
}

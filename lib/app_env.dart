class AppEnv {
  static String get baseUrl => const String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://api.escuelajs.co/api/v1/',
  );
}

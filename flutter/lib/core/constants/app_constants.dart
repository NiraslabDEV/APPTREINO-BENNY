import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  AppConstants._();

  static String get apiBaseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'http://localhost:8000';

  static String get googleClientId =>
      dotenv.env['GOOGLE_CLIENT_ID'] ?? '';

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Storage keys — nunca guardar senha em texto puro
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userRoleKey = 'user_role';
  static const String userIdKey = 'user_id';

  // Roles
  static const String roleTrainer = 'personal_trainer';
  static const String roleAluno = 'aluno';

  // Timer padrão de descanso (segundos)
  static const int defaultRestSeconds = 60;

  // Limite de campos (segurança — evitar payloads gigantes)
  static const int maxNameLength = 100;
  static const int maxDescriptionLength = 500;
  static const int maxNotesLength = 300;
}

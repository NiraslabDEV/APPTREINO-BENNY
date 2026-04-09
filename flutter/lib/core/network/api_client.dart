import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../constants/app_constants.dart';

/// Cliente HTTP central com interceptors de JWT e tratamento de erro
class ApiClient {
  late final Dio _dio;
  final FlutterSecureStorage _storage;

  ApiClient(this._storage) {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.apiBaseUrl,
        connectTimeout: AppConstants.connectTimeout,
        receiveTimeout: AppConstants.receiveTimeout,
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.addAll([
      _AuthInterceptor(_storage, _dio),
      // Logger apenas em debug — nunca em produção
      if (const bool.fromEnvironment('dart.vm.product') == false)
        PrettyDioLogger(
          requestHeader: false,
          requestBody: true,
          responseBody: true,
          error: true,
        ),
    ]);
  }

  Dio get instance => _dio;
}

/// Interceptor que injeta o Bearer token e faz refresh automático
class _AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage;
  final Dio _dio;

  _AuthInterceptor(this._storage, this._dio);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.read(key: AppConstants.accessTokenKey);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      // Token expirado — tenta refresh
      final refreshed = await _tryRefreshToken();
      if (refreshed) {
        // Repete a requisição original com o novo token
        final token =
            await _storage.read(key: AppConstants.accessTokenKey);
        err.requestOptions.headers['Authorization'] = 'Bearer $token';
        try {
          final response = await _dio.fetch(err.requestOptions);
          handler.resolve(response);
          return;
        } catch (_) {}
      }
      // Refresh falhou — apaga tokens (força re-login)
      await _storage.deleteAll();
    }
    handler.next(err);
  }

  Future<bool> _tryRefreshToken() async {
    final refreshToken =
        await _storage.read(key: AppConstants.refreshTokenKey);
    if (refreshToken == null) return false;

    try {
      final response = await _dio.post(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
      );
      final newToken = response.data['access_token'] as String;
      await _storage.write(
          key: AppConstants.accessTokenKey, value: newToken);
      return true;
    } catch (_) {
      return false;
    }
  }
}

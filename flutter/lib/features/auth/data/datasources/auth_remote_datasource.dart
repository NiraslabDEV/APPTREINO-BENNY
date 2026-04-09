import 'package:dio/dio.dart';
import '../models/auth_response_model.dart';
import '../../../../core/constants/app_constants.dart';

abstract class AuthRemoteDatasource {
  Future<AuthResponseModel> loginWithEmail(String email, String password);
  Future<AuthResponseModel> loginWithGoogle(String googleToken);
  Future<void> logout();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Dio _dio;

  AuthRemoteDatasourceImpl(this._dio);

  @override
  Future<AuthResponseModel> loginWithEmail(
      String email, String password) async {
    // Validação de tamanho antes de enviar — segurança client-side
    if (email.length > 254 || password.length > 128) {
      throw DioException(
        requestOptions: RequestOptions(path: '/auth/email'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/auth/email'),
          statusCode: 400,
        ),
      );
    }

    final response = await _dio.post(
      '/auth/email',
      data: {'email': email.trim(), 'password': password},
    );
    return AuthResponseModel.fromJson(
        response.data as Map<String, dynamic>);
  }

  @override
  Future<AuthResponseModel> loginWithGoogle(String googleToken) async {
    final response = await _dio.post(
      '/auth/google',
      data: {'token': googleToken},
    );
    return AuthResponseModel.fromJson(
        response.data as Map<String, dynamic>);
  }

  @override
  Future<void> logout() async {
    // Endpoint de logout revoga o refresh token no servidor
    await _dio.post('/auth/logout');
  }
}

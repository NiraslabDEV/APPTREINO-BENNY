import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../datasources/auth_remote_datasource.dart';
import '../../domain/entities/user_entity.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> loginWithEmail(
      String email, String password);
  Future<Either<Failure, UserEntity>> loginWithGoogle(String googleToken);
  Future<Either<Failure, UserEntity>> register(
      String email, String password, String name, String role);
  Future<Either<Failure, void>> logout();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _datasource;
  final FlutterSecureStorage _storage;

  AuthRepositoryImpl(this._datasource, this._storage);

  @override
  Future<Either<Failure, UserEntity>> loginWithEmail(
      String email, String password) async {
    try {
      final response = await _datasource.loginWithEmail(email, password);
      await _persistSession(response.accessToken, response.refreshToken,
          response.user.role, response.user.id);
      return Right(response.user.toEntity());
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    } catch (_) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register(
      String email, String password, String name, String role) async {
    try {
      final response =
          await _datasource.register(email, password, name, role);
      await _persistSession(response.accessToken, response.refreshToken,
          response.user.role, response.user.id);
      return Right(response.user.toEntity());
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        return const Left(
            UnauthorizedFailure('Não foi possível criar a conta.'));
      }
      return Left(_mapDioError(e));
    } catch (_) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithGoogle(
      String googleToken) async {
    try {
      final response = await _datasource.loginWithGoogle(googleToken);
      await _persistSession(response.accessToken, response.refreshToken,
          response.user.role, response.user.id);
      return Right(response.user.toEntity());
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    } catch (_) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _datasource.logout();
    } catch (_) {
      // Ignora erro de rede no logout — limpa local de qualquer forma
    }
    await _storage.deleteAll();
    return const Right(null);
  }

  Future<void> _persistSession(
    String accessToken,
    String refreshToken,
    String role,
    String userId,
  ) async {
    await Future.wait([
      _storage.write(key: AppConstants.accessTokenKey, value: accessToken),
      _storage.write(key: AppConstants.refreshTokenKey, value: refreshToken),
      _storage.write(key: AppConstants.userRoleKey, value: role),
      _storage.write(key: AppConstants.userIdKey, value: userId),
    ]);
  }

  Failure _mapDioError(DioException e) {
    return switch (e.response?.statusCode) {
      401 => const UnauthorizedFailure(
          'E-mail ou senha incorretos.'), // mensagem genérica intencional
      403 => const ForbiddenFailure(),
      422 => const ValidationFailure(),
      _ => const ServerFailure(),
    };
  }
}

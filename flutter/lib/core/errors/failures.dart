import 'package:equatable/equatable.dart';

/// Hierarquia de falhas para uso nos BLoCs (nunca expor erros internos ao UI)
abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Erro de conexão. Verifique sua internet.']);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([super.message = 'Sessão expirada. Faça login novamente.']);
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure([super.message = 'Acesso negado.']);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Recurso não encontrado.']);
}

/// Mensagem genérica — nunca revelar detalhes de validação para o usuário
class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Dados inválidos. Verifique os campos.']);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Erro no servidor. Tente novamente mais tarde.']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Erro ao acessar dados locais.']);
}

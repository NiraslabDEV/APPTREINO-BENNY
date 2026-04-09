import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final String role; // 'personal_trainer' | 'aluno'
  final String? photoUrl;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.photoUrl,
  });

  bool get isTrainer => role == 'personal_trainer';
  bool get isAluno => role == 'aluno';

  @override
  List<Object?> get props => [id, email, name, role, photoUrl];
}

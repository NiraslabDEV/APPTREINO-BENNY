import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

// --- Models ---
class StudentModel extends Equatable {
  final String id;
  final String name;
  final String? goal;
  final String? photoUrl;
  final double adrPercent;
  final String? lastWorkout;

  const StudentModel({
    required this.id,
    required this.name,
    this.goal,
    this.photoUrl,
    required this.adrPercent,
    this.lastWorkout,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        id: json['id'] as String,
        name: json['name'] as String,
        goal: json['goal'] as String?,
        photoUrl: json['photo_url'] as String?,
        adrPercent: (json['adr_percent'] as num).toDouble(),
        lastWorkout: json['last_workout'] as String?,
      );

  @override
  List<Object?> get props => [id, name, adrPercent];
}

class WorkoutLog extends Equatable {
  final String workoutName;
  final double totalVolumeKg;
  final int durationMin;
  final String date;

  const WorkoutLog({
    required this.workoutName,
    required this.totalVolumeKg,
    required this.durationMin,
    required this.date,
  });

  factory WorkoutLog.fromJson(Map<String, dynamic> json) => WorkoutLog(
        workoutName: json['workout_name'] as String,
        totalVolumeKg: (json['total_volume_kg'] as num).toDouble(),
        durationMin: json['duration_min'] as int,
        date: json['date'] as String,
      );

  @override
  List<Object> get props => [workoutName, date];
}

class StudentProfileModel extends Equatable {
  final String id;
  final String name;
  final String? photoUrl;
  final double weeklyVolumeKg;
  final double bodyWeightKg;
  final double adrPercent;
  final List<WorkoutLog> recentLogs;

  const StudentProfileModel({
    required this.id,
    required this.name,
    this.photoUrl,
    required this.weeklyVolumeKg,
    required this.bodyWeightKg,
    required this.adrPercent,
    required this.recentLogs,
  });

  factory StudentProfileModel.fromJson(Map<String, dynamic> json) =>
      StudentProfileModel(
        id: json['id'] as String,
        name: json['name'] as String,
        photoUrl: json['photo_url'] as String?,
        weeklyVolumeKg: (json['weekly_volume_kg'] as num).toDouble(),
        bodyWeightKg: (json['body_weight_kg'] as num).toDouble(),
        adrPercent: (json['adr_percent'] as num).toDouble(),
        recentLogs: (json['recent_logs'] as List)
            .map((e) => WorkoutLog.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  @override
  List<Object?> get props => [id];
}

// --- Events ---
abstract class StudentsEvent extends Equatable {
  const StudentsEvent();
  @override
  List<Object?> get props => [];
}

class LoadStudents extends StudentsEvent {}

class SearchStudents extends StudentsEvent {
  final String query;
  const SearchStudents(this.query);
  @override
  List<Object> get props => [query];
}

class LoadStudentProfile extends StudentsEvent {
  final String studentId;
  const LoadStudentProfile(this.studentId);
  @override
  List<Object> get props => [studentId];
}

// --- States ---
abstract class StudentsState extends Equatable {
  const StudentsState();
  @override
  List<Object?> get props => [];
}

class StudentsInitial extends StudentsState {}

class StudentsLoading extends StudentsState {}

class StudentsLoaded extends StudentsState {
  final List<StudentModel> students;
  const StudentsLoaded(this.students);
  @override
  List<Object> get props => [students];
}

class StudentProfileLoaded extends StudentsState {
  final StudentProfileModel profile;
  const StudentProfileLoaded(this.profile);
  @override
  List<Object> get props => [profile];
}

class StudentsError extends StudentsState {
  final String message;
  const StudentsError(this.message);
  @override
  List<Object> get props => [message];
}

// --- BLoC ---
class StudentsBloc extends Bloc<StudentsEvent, StudentsState> {
  final Dio _dio;
  List<StudentModel> _allStudents = [];

  StudentsBloc(this._dio) : super(StudentsInitial()) {
    on<LoadStudents>(_onLoad);
    on<SearchStudents>(_onSearch);
    on<LoadStudentProfile>(_onLoadProfile);
  }

  Future<void> _onLoad(
    LoadStudents event,
    Emitter<StudentsState> emit,
  ) async {
    emit(StudentsLoading());
    try {
      final response = await _dio.get('/students');
      _allStudents = (response.data as List)
          .map((e) => StudentModel.fromJson(e as Map<String, dynamic>))
          .toList();
      emit(StudentsLoaded(_allStudents));
    } on DioException {
      emit(const StudentsError('Erro ao carregar alunos.'));
    }
  }

  void _onSearch(SearchStudents event, Emitter<StudentsState> emit) {
    final q = event.query.toLowerCase();
    if (q.isEmpty) {
      emit(StudentsLoaded(_allStudents));
      return;
    }
    final filtered = _allStudents
        .where((s) =>
            s.name.toLowerCase().contains(q) ||
            (s.goal?.toLowerCase().contains(q) ?? false))
        .toList();
    emit(StudentsLoaded(filtered));
  }

  Future<void> _onLoadProfile(
    LoadStudentProfile event,
    Emitter<StudentsState> emit,
  ) async {
    emit(StudentsLoading());
    try {
      final response = await _dio.get('/students/${event.studentId}/profile');
      emit(StudentProfileLoaded(
          StudentProfileModel.fromJson(
              response.data as Map<String, dynamic>)));
    } on DioException catch (e) {
      // 403/404 — não revelar se aluno pertence a outro trainer
      final status = e.response?.statusCode;
      if (status == 403 || status == 404) {
        emit(const StudentsError('Aluno não encontrado.'));
      } else {
        emit(const StudentsError('Erro ao carregar perfil.'));
      }
    }
  }
}

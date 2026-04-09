import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

// --- Models ---
class DashboardMetrics extends Equatable {
  final int activeStudents;
  final int trainedToday;
  final int inactiveStudents;

  const DashboardMetrics({
    required this.activeStudents,
    required this.trainedToday,
    required this.inactiveStudents,
  });

  factory DashboardMetrics.fromJson(Map<String, dynamic> json) =>
      DashboardMetrics(
        activeStudents: json['active_students'] as int,
        trainedToday: json['trained_today'] as int,
        inactiveStudents: json['inactive_students'] as int,
      );

  @override
  List<Object> get props =>
      [activeStudents, trainedToday, inactiveStudents];
}

class RecentActivity extends Equatable {
  final String studentName;
  final String? studentPhotoUrl;
  final String workoutName;
  final double totalVolumeKg;
  final String completedAt;

  const RecentActivity({
    required this.studentName,
    this.studentPhotoUrl,
    required this.workoutName,
    required this.totalVolumeKg,
    required this.completedAt,
  });

  factory RecentActivity.fromJson(Map<String, dynamic> json) =>
      RecentActivity(
        studentName: json['student_name'] as String,
        studentPhotoUrl: json['student_photo_url'] as String?,
        workoutName: json['workout_name'] as String,
        totalVolumeKg: (json['total_volume_kg'] as num).toDouble(),
        completedAt: json['completed_at'] as String,
      );

  @override
  List<Object?> get props =>
      [studentName, workoutName, totalVolumeKg, completedAt];
}

// --- Events ---
abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
  @override
  List<Object?> get props => [];
}

class LoadDashboardMetrics extends DashboardEvent {}

class NudgeInactiveStudents extends DashboardEvent {}

// --- States ---
abstract class DashboardState extends Equatable {
  const DashboardState();
  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final String trainerName;
  final DashboardMetrics metrics;
  final List<RecentActivity> recentActivities;

  const DashboardLoaded({
    required this.trainerName,
    required this.metrics,
    required this.recentActivities,
  });

  @override
  List<Object> get props => [trainerName, metrics, recentActivities];
}

class DashboardError extends DashboardState {
  final String message;
  const DashboardError(this.message);
  @override
  List<Object> get props => [message];
}

// --- BLoC ---
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final Dio _dio;

  DashboardBloc(this._dio) : super(DashboardInitial()) {
    on<LoadDashboardMetrics>(_onLoad);
    on<NudgeInactiveStudents>(_onNudge);
  }

  Future<void> _onLoad(
    LoadDashboardMetrics event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    try {
      final responses = await Future.wait([
        _dio.get('/dashboard/metrics'),
        _dio.get('/dashboard/activity'),
        _dio.get('/me'),
      ]);

      final metrics = DashboardMetrics.fromJson(
          responses[0].data as Map<String, dynamic>);
      final activities = (responses[1].data as List)
          .map((e) => RecentActivity.fromJson(e as Map<String, dynamic>))
          .toList();
      final trainerName =
          (responses[2].data as Map<String, dynamic>)['name'] as String;

      emit(DashboardLoaded(
        trainerName: trainerName,
        metrics: metrics,
        recentActivities: activities,
      ));
    } on DioException {
      emit(const DashboardError(
          'Erro ao carregar dados. Tente novamente.'));
    }
  }

  Future<void> _onNudge(
    NudgeInactiveStudents event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      await _dio.post('/students/nudge-all');
      // Recarrega após nudge
      add(LoadDashboardMetrics());
    } catch (_) {
      // Silencia — o nudge é best-effort
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

// --- Models ---
class TodayWorkoutModel extends Equatable {
  final String workoutId;
  final String workoutName;
  final int estimatedMinutes;
  final int exerciseCount;
  final String? imageUrl;

  const TodayWorkoutModel({
    required this.workoutId,
    required this.workoutName,
    required this.estimatedMinutes,
    required this.exerciseCount,
    this.imageUrl,
  });

  factory TodayWorkoutModel.fromJson(Map<String, dynamic> json) =>
      TodayWorkoutModel(
        workoutId: json['id'] as String,
        workoutName: json['name'] as String,
        estimatedMinutes: json['estimated_minutes'] as int? ?? 45,
        exerciseCount: json['exercise_count'] as int? ?? 0,
        imageUrl: json['image_url'] as String?,
      );

  @override
  List<Object?> get props => [workoutId];
}

class PRModel extends Equatable {
  final String exerciseName;
  final double weightKg;
  final int reps;

  const PRModel({
    required this.exerciseName,
    required this.weightKg,
    required this.reps,
  });

  factory PRModel.fromJson(Map<String, dynamic> json) => PRModel(
        exerciseName: json['exercise_name'] as String,
        weightKg: (json['weight_kg'] as num).toDouble(),
        reps: json['reps'] as int,
      );

  @override
  List<Object> get props => [exerciseName, weightKg, reps];
}

// --- Events ---
abstract class AlunoHomeEvent extends Equatable {
  const AlunoHomeEvent();
  @override
  List<Object?> get props => [];
}

class LoadTodayWorkout extends AlunoHomeEvent {}

// --- States ---
abstract class AlunoHomeState extends Equatable {
  const AlunoHomeState();
  @override
  List<Object?> get props => [];
}

class AlunoHomeInitial extends AlunoHomeState {}

class AlunoHomeLoading extends AlunoHomeState {}

class AlunoHomeLoaded extends AlunoHomeState {
  final String alunoName;
  final TodayWorkoutModel? todayWorkout;
  final List<PRModel> recentPRs;

  const AlunoHomeLoaded({
    required this.alunoName,
    this.todayWorkout,
    required this.recentPRs,
  });

  @override
  List<Object?> get props => [alunoName, todayWorkout, recentPRs];
}

class AlunoHomeError extends AlunoHomeState {
  final String message;
  const AlunoHomeError(this.message);
  @override
  List<Object> get props => [message];
}

// --- BLoC ---
class AlunoHomeBloc extends Bloc<AlunoHomeEvent, AlunoHomeState> {
  final Dio _dio;

  AlunoHomeBloc(this._dio) : super(AlunoHomeInitial()) {
    on<LoadTodayWorkout>(_onLoad);
  }

  Future<void> _onLoad(
    LoadTodayWorkout event,
    Emitter<AlunoHomeState> emit,
  ) async {
    emit(AlunoHomeLoading());
    try {
      final responses = await Future.wait([
        _dio.get('/me'),
        _dio.get('/me/workouts/today'),
        _dio.get('/me/personal-records?limit=3'),
      ]);

      final me = responses[0].data as Map<String, dynamic>;
      final name = me['name'] as String;

      TodayWorkoutModel? todayWorkout;
      if (responses[1].statusCode == 200 && responses[1].data != null) {
        todayWorkout = TodayWorkoutModel.fromJson(
            responses[1].data as Map<String, dynamic>);
      }

      final prs = (responses[2].data as List? ?? [])
          .map((e) => PRModel.fromJson(e as Map<String, dynamic>))
          .toList();

      emit(AlunoHomeLoaded(
        alunoName: name,
        todayWorkout: todayWorkout,
        recentPRs: prs,
      ));
    } on DioException {
      emit(const AlunoHomeError('Erro ao carregar. Tente novamente.'));
    }
  }
}

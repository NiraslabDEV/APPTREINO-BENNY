import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

// --- Models ---
class SetState extends Equatable {
  final int targetSets;
  final int targetReps;
  final int restSeconds;
  final int rpeTarget;
  final double? loggedWeight;
  final int? loggedReps;
  final int? loggedRpe;
  final bool isDone;

  const SetState({
    required this.targetSets,
    required this.targetReps,
    required this.restSeconds,
    required this.rpeTarget,
    this.loggedWeight,
    this.loggedReps,
    this.loggedRpe,
    this.isDone = false,
  });

  SetState complete(double weight, int reps, int rpe) => SetState(
        targetSets: targetSets,
        targetReps: targetReps,
        restSeconds: restSeconds,
        rpeTarget: rpeTarget,
        loggedWeight: weight,
        loggedReps: reps,
        loggedRpe: rpe,
        isDone: true,
      );

  @override
  List<Object?> get props =>
      [targetReps, loggedWeight, loggedReps, isDone];
}

class SessionExercise extends Equatable {
  final String exerciseId;
  final String exerciseName;
  final int sets;
  final int reps;
  final int restSeconds;
  final int rpeTarget;

  const SessionExercise({
    required this.exerciseId,
    required this.exerciseName,
    required this.sets,
    required this.reps,
    required this.restSeconds,
    required this.rpeTarget,
  });

  factory SessionExercise.fromJson(Map<String, dynamic> json) =>
      SessionExercise(
        exerciseId: json['exercise_id'] as String,
        exerciseName: json['exercise_name'] as String,
        sets: json['sets'] as int,
        reps: json['reps'] as int,
        restSeconds: json['rest_seconds'] as int? ?? 60,
        rpeTarget: json['rpe_target'] as int? ?? 8,
      );

  @override
  List<Object> get props => [exerciseId];
}

// --- Events ---
abstract class SessionEvent extends Equatable {
  const SessionEvent();
  @override
  List<Object?> get props => [];
}

class StartSession extends SessionEvent {
  final String workoutId;
  const StartSession(this.workoutId);
  @override
  List<Object> get props => [workoutId];
}

class LogSet extends SessionEvent {
  final int setNumber;
  final double weightKg;
  final int reps;
  final int rpe;
  const LogSet(
      {required this.setNumber,
      required this.weightKg,
      required this.reps,
      required this.rpe});
  @override
  List<Object> get props => [setNumber, weightKg, reps, rpe];
}

class SkipRest extends SessionEvent {}

class _RestTick extends SessionEvent {}

class FinishSession extends SessionEvent {}

// --- States ---
abstract class SessionState extends Equatable {
  const SessionState();
  @override
  List<Object?> get props => [];
}

class SessionIdle extends SessionState {}

class SessionLoading extends SessionState {}

class SessionInProgress extends SessionState {
  final String sessionId;
  final List<SessionExercise> exercises;
  final int currentExerciseIndex;
  final int activeSetIndex;
  final List<SetState> setsToLog;
  final bool isResting;
  final int restSecondsRemaining;
  final int restSecondsTotal;

  const SessionInProgress({
    required this.sessionId,
    required this.exercises,
    required this.currentExerciseIndex,
    required this.activeSetIndex,
    required this.setsToLog,
    this.isResting = false,
    this.restSecondsRemaining = 0,
    this.restSecondsTotal = 60,
  });

  SessionExercise get currentExercise =>
      exercises[currentExerciseIndex];
  int get totalExercises => exercises.length;
  double get progress =>
      totalExercises > 0 ? currentExerciseIndex / totalExercises : 0;

  SessionInProgress copyWith({
    int? currentExerciseIndex,
    int? activeSetIndex,
    List<SetState>? setsToLog,
    bool? isResting,
    int? restSecondsRemaining,
    int? restSecondsTotal,
  }) =>
      SessionInProgress(
        sessionId: sessionId,
        exercises: exercises,
        currentExerciseIndex:
            currentExerciseIndex ?? this.currentExerciseIndex,
        activeSetIndex: activeSetIndex ?? this.activeSetIndex,
        setsToLog: setsToLog ?? this.setsToLog,
        isResting: isResting ?? this.isResting,
        restSecondsRemaining:
            restSecondsRemaining ?? this.restSecondsRemaining,
        restSecondsTotal: restSecondsTotal ?? this.restSecondsTotal,
      );

  @override
  List<Object?> get props => [
        sessionId,
        currentExerciseIndex,
        activeSetIndex,
        setsToLog,
        isResting,
        restSecondsRemaining,
      ];
}

class SessionCompleted extends SessionState {
  final double totalVolumeKg;
  final int durationMin;
  final List<String> newPRs;

  const SessionCompleted({
    required this.totalVolumeKg,
    required this.durationMin,
    required this.newPRs,
  });

  @override
  List<Object> get props => [totalVolumeKg, durationMin, newPRs];
}

class SessionError extends SessionState {
  final String message;
  const SessionError(this.message);
  @override
  List<Object> get props => [message];
}

// --- BLoC ---
class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final Dio _dio;
  Timer? _restTimer;
  DateTime? _sessionStartedAt;

  SessionBloc(this._dio) : super(SessionIdle()) {
    on<StartSession>(_onStart);
    on<LogSet>(_onLogSet);
    on<SkipRest>(_onSkipRest);
    on<_RestTick>(_onRestTick);
    on<FinishSession>(_onFinish);
  }

  Future<void> _onStart(
    StartSession event,
    Emitter<SessionState> emit,
  ) async {
    emit(SessionLoading());
    try {
      // Inicia a sessão no backend
      final startResponse = await _dio.post(
        '/sessions',
        data: {'workout_id': event.workoutId},
      );
      final sessionId =
          (startResponse.data as Map<String, dynamic>)['id'] as String;

      // Busca detalhes do workout para montar a lista de exercícios
      final workoutResponse =
          await _dio.get('/workouts/${event.workoutId}');
      final exercises =
          (workoutResponse.data['exercises'] as List)
              .map((e) => SessionExercise.fromJson(
                  e as Map<String, dynamic>))
              .toList();

      _sessionStartedAt = DateTime.now();

      final firstExercise = exercises.first;
      final sets = List.generate(
        firstExercise.sets,
        (_) => SetState(
          targetSets: firstExercise.sets,
          targetReps: firstExercise.reps,
          restSeconds: firstExercise.restSeconds,
          rpeTarget: firstExercise.rpeTarget,
        ),
      );

      emit(SessionInProgress(
        sessionId: sessionId,
        exercises: exercises,
        currentExerciseIndex: 0,
        activeSetIndex: 0,
        setsToLog: sets,
      ));
    } on DioException {
      emit(const SessionError('Erro ao iniciar treino. Tente novamente.'));
    }
  }

  Future<void> _onLogSet(
    LogSet event,
    Emitter<SessionState> emit,
  ) async {
    if (state is! SessionInProgress) return;
    final s = state as SessionInProgress;

    // Persiste no backend
    try {
      await _dio.post(
        '/sessions/${s.sessionId}/sets',
        data: {
          'exercise_id': s.currentExercise.exerciseId,
          'set_number': event.setNumber,
          'weight_kg': event.weightKg,
          'reps': event.reps,
          'rpe': event.rpe,
        },
      );
    } catch (_) {
      // Se falhar, continua local — sync posterior (offline-first básico)
    }

    // Marca a série como concluída
    final updatedSets = List<SetState>.from(s.setsToLog);
    updatedSets[s.activeSetIndex] =
        updatedSets[s.activeSetIndex].complete(
      event.weightKg,
      event.reps,
      event.rpe,
    );

    final allSetsDone = updatedSets.every((s) => s.isDone);

    if (allSetsDone) {
      // Avança para o próximo exercício
      final nextIndex = s.currentExerciseIndex + 1;
      if (nextIndex >= s.exercises.length) {
        // Treino completo
        add(FinishSession());
        return;
      }

      final nextExercise = s.exercises[nextIndex];
      final nextSets = List.generate(
        nextExercise.sets,
        (_) => SetState(
          targetSets: nextExercise.sets,
          targetReps: nextExercise.reps,
          restSeconds: nextExercise.restSeconds,
          rpeTarget: nextExercise.rpeTarget,
        ),
      );

      // Inicia timer de descanso entre exercícios
      _startRestTimer(s.currentExercise.restSeconds);
      emit(s.copyWith(
        currentExerciseIndex: nextIndex,
        activeSetIndex: 0,
        setsToLog: nextSets,
        isResting: true,
        restSecondsRemaining: s.currentExercise.restSeconds,
        restSecondsTotal: s.currentExercise.restSeconds,
      ));
    } else {
      // Avança para a próxima série do mesmo exercício
      final nextSetIndex = s.activeSetIndex + 1;
      _startRestTimer(s.currentExercise.restSeconds);
      emit(s.copyWith(
        activeSetIndex: nextSetIndex,
        setsToLog: updatedSets,
        isResting: true,
        restSecondsRemaining: s.currentExercise.restSeconds,
        restSecondsTotal: s.currentExercise.restSeconds,
      ));
    }
  }

  void _startRestTimer(int seconds) {
    _restTimer?.cancel();
    _restTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      add(_RestTick());
    });
  }

  void _onRestTick(_RestTick event, Emitter<SessionState> emit) {
    if (state is! SessionInProgress) return;
    final s = state as SessionInProgress;
    if (!s.isResting) return;

    final remaining = s.restSecondsRemaining - 1;
    if (remaining <= 0) {
      _restTimer?.cancel();
      emit(s.copyWith(isResting: false, restSecondsRemaining: 0));
    } else {
      emit(s.copyWith(restSecondsRemaining: remaining));
    }
  }

  void _onSkipRest(SkipRest event, Emitter<SessionState> emit) {
    _restTimer?.cancel();
    if (state is SessionInProgress) {
      emit((state as SessionInProgress)
          .copyWith(isResting: false, restSecondsRemaining: 0));
    }
  }

  Future<void> _onFinish(
    FinishSession event,
    Emitter<SessionState> emit,
  ) async {
    if (state is! SessionInProgress) return;
    final s = state as SessionInProgress;
    _restTimer?.cancel();

    try {
      final response = await _dio.patch(
        '/sessions/${s.sessionId}/complete',
      );
      final data = response.data as Map<String, dynamic>;
      final duration = _sessionStartedAt != null
          ? DateTime.now()
              .difference(_sessionStartedAt!)
              .inMinutes
          : 0;

      emit(SessionCompleted(
        totalVolumeKg:
            (data['total_volume_kg'] as num?)?.toDouble() ?? 0,
        durationMin: duration,
        newPRs: (data['new_prs'] as List?)
                ?.map((e) => e as String)
                .toList() ??
            [],
      ));
    } on DioException {
      // Ainda mostra conclusão mesmo se falhar
      emit(const SessionCompleted(
          totalVolumeKg: 0, durationMin: 0, newPRs: []));
    }
  }

  @override
  Future<void> close() {
    _restTimer?.cancel();
    return super.close();
  }
}

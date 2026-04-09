import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

// --- Models ---
class WorkoutExerciseItem extends Equatable {
  final String exerciseId;
  final String exerciseName;
  final int sets;
  final int reps;
  final int restSeconds;
  final int rpeTarget;
  final String? notes;

  const WorkoutExerciseItem({
    required this.exerciseId,
    required this.exerciseName,
    this.sets = 3,
    this.reps = 10,
    this.restSeconds = 60,
    this.rpeTarget = 8,
    this.notes,
  });

  factory WorkoutExerciseItem.fromJson(Map<String, dynamic> json) =>
      WorkoutExerciseItem(
        exerciseId: json['exercise_id'] as String,
        exerciseName: json['exercise_name'] as String,
        sets: json['sets'] as int,
        reps: json['reps'] as int,
        restSeconds: json['rest_seconds'] as int,
        rpeTarget: json['rpe_target'] as int,
        notes: json['notes'] as String?,
      );

  WorkoutExerciseItem copyWith({
    int? sets,
    int? reps,
    int? restSeconds,
    int? rpeTarget,
    String? notes,
  }) =>
      WorkoutExerciseItem(
        exerciseId: exerciseId,
        exerciseName: exerciseName,
        sets: sets ?? this.sets,
        reps: reps ?? this.reps,
        restSeconds: restSeconds ?? this.restSeconds,
        rpeTarget: rpeTarget ?? this.rpeTarget,
        notes: notes ?? this.notes,
      );

  @override
  List<Object?> get props =>
      [exerciseId, sets, reps, restSeconds, rpeTarget];
}

class ExerciseLibraryItem extends Equatable {
  final String id;
  final String name;
  final String muscleGroup;
  final String? gifUrl;

  const ExerciseLibraryItem({
    required this.id,
    required this.name,
    required this.muscleGroup,
    this.gifUrl,
  });

  factory ExerciseLibraryItem.fromJson(Map<String, dynamic> json) =>
      ExerciseLibraryItem(
        id: json['id'] as String,
        name: json['name'] as String,
        muscleGroup: json['muscle_group'] as String,
        gifUrl: json['gif_url'] as String?,
      );

  @override
  List<Object?> get props => [id];
}

class AssignStudentItem extends Equatable {
  final String id;
  final String name;
  const AssignStudentItem({required this.id, required this.name});

  factory AssignStudentItem.fromJson(Map<String, dynamic> json) =>
      AssignStudentItem(
          id: json['id'] as String, name: json['name'] as String);

  @override
  List<Object> get props => [id];
}

// --- Events ---
abstract class WorkoutBuilderEvent extends Equatable {
  const WorkoutBuilderEvent();
  @override
  List<Object?> get props => [];
}

class LoadWorkoutForEdit extends WorkoutBuilderEvent {
  final String workoutId;
  const LoadWorkoutForEdit(this.workoutId);
  @override
  List<Object> get props => [workoutId];
}

class SaveWorkout extends WorkoutBuilderEvent {
  final String name;
  final String description;
  final String level;
  const SaveWorkout(
      {required this.name,
      required this.description,
      required this.level});
  @override
  List<Object> get props => [name, description, level];
}

class AddExerciseFromLibrary extends WorkoutBuilderEvent {
  final ExerciseLibraryItem exercise;
  const AddExerciseFromLibrary(this.exercise);
  @override
  List<Object> get props => [exercise];
}

class RemoveExercise extends WorkoutBuilderEvent {
  final int index;
  const RemoveExercise(this.index);
  @override
  List<Object> get props => [index];
}

class ReorderExercises extends WorkoutBuilderEvent {
  final int oldIndex;
  final int newIndex;
  const ReorderExercises({required this.oldIndex, required this.newIndex});
  @override
  List<Object> get props => [oldIndex, newIndex];
}

class LoadExerciseLibrary extends WorkoutBuilderEvent {}

class SearchExercises extends WorkoutBuilderEvent {
  final String query;
  const SearchExercises(this.query);
  @override
  List<Object> get props => [query];
}

class LoadStudentsForAssign extends WorkoutBuilderEvent {}

class AssignWorkoutToStudents extends WorkoutBuilderEvent {
  final List<String> studentIds;
  const AssignWorkoutToStudents(this.studentIds);
  @override
  List<Object> get props => [studentIds];
}

// --- States ---
abstract class WorkoutBuilderState extends Equatable {
  const WorkoutBuilderState();
  @override
  List<Object?> get props => [];
}

class WorkoutBuilderInitial extends WorkoutBuilderState {}

class WorkoutBuilderLoading extends WorkoutBuilderState {}

class WorkoutBuilderEditing extends WorkoutBuilderState {
  final String? workoutId;
  final List<WorkoutExerciseItem> exercises;
  final List<ExerciseLibraryItem> libraryExercises;
  final List<AssignStudentItem> availableStudents;

  const WorkoutBuilderEditing({
    this.workoutId,
    this.exercises = const [],
    this.libraryExercises = const [],
    this.availableStudents = const [],
  });

  WorkoutBuilderEditing copyWith({
    String? workoutId,
    List<WorkoutExerciseItem>? exercises,
    List<ExerciseLibraryItem>? libraryExercises,
    List<AssignStudentItem>? availableStudents,
  }) =>
      WorkoutBuilderEditing(
        workoutId: workoutId ?? this.workoutId,
        exercises: exercises ?? this.exercises,
        libraryExercises: libraryExercises ?? this.libraryExercises,
        availableStudents: availableStudents ?? this.availableStudents,
      );

  @override
  List<Object?> get props =>
      [workoutId, exercises, libraryExercises, availableStudents];
}

class WorkoutSaved extends WorkoutBuilderState {
  final String workoutId;
  const WorkoutSaved(this.workoutId);
  @override
  List<Object> get props => [workoutId];
}

class WorkoutAssigned extends WorkoutBuilderState {}

class WorkoutBuilderError extends WorkoutBuilderState {
  final String message;
  const WorkoutBuilderError(this.message);
  @override
  List<Object> get props => [message];
}

// --- BLoC ---
class WorkoutBuilderBloc
    extends Bloc<WorkoutBuilderEvent, WorkoutBuilderState> {
  final Dio _dio;
  List<ExerciseLibraryItem> _allLibraryExercises = [];

  WorkoutBuilderBloc(this._dio) : super(const WorkoutBuilderEditing()) {
    on<LoadWorkoutForEdit>(_onLoad);
    on<SaveWorkout>(_onSave);
    on<AddExerciseFromLibrary>(_onAddExercise);
    on<RemoveExercise>(_onRemoveExercise);
    on<ReorderExercises>(_onReorder);
    on<LoadExerciseLibrary>(_onLoadLibrary);
    on<SearchExercises>(_onSearch);
    on<LoadStudentsForAssign>(_onLoadStudents);
    on<AssignWorkoutToStudents>(_onAssign);
  }

  WorkoutBuilderEditing get _currentEditing =>
      state is WorkoutBuilderEditing
          ? state as WorkoutBuilderEditing
          : const WorkoutBuilderEditing();

  Future<void> _onLoad(
    LoadWorkoutForEdit event,
    Emitter<WorkoutBuilderState> emit,
  ) async {
    emit(WorkoutBuilderLoading());
    try {
      final response = await _dio.get('/workouts/${event.workoutId}');
      final data = response.data as Map<String, dynamic>;
      final exercises = (data['exercises'] as List)
          .map((e) =>
              WorkoutExerciseItem.fromJson(e as Map<String, dynamic>))
          .toList();
      emit(WorkoutBuilderEditing(
          workoutId: event.workoutId, exercises: exercises));
    } on DioException catch (e) {
      // 403/404 — não revelar detalhes
      emit(const WorkoutBuilderError('Treino não encontrado.'));
    }
  }

  Future<void> _onSave(
    SaveWorkout event,
    Emitter<WorkoutBuilderState> emit,
  ) async {
    final current = _currentEditing;
    try {
      final exercisePayload = current.exercises
          .asMap()
          .entries
          .map((e) => {
                'exercise_id': e.value.exerciseId,
                'order': e.key + 1,
                'sets': e.value.sets,
                'reps': e.value.reps,
                'rest_seconds': e.value.restSeconds,
                'rpe_target': e.value.rpeTarget,
                'notes': e.value.notes,
              })
          .toList();

      final payload = {
        'name': event.name,
        'description': event.description,
        'level': event.level,
        'exercises': exercisePayload,
      };

      late String workoutId;
      if (current.workoutId == null) {
        final response = await _dio.post('/workouts', data: payload);
        workoutId =
            (response.data as Map<String, dynamic>)['id'] as String;
      } else {
        await _dio.put('/workouts/${current.workoutId}', data: payload);
        workoutId = current.workoutId!;
      }

      emit(WorkoutSaved(workoutId));
      emit(current.copyWith(workoutId: workoutId));
    } on DioException {
      emit(const WorkoutBuilderError('Erro ao salvar treino.'));
    }
  }

  void _onAddExercise(
    AddExerciseFromLibrary event,
    Emitter<WorkoutBuilderState> emit,
  ) {
    final current = _currentEditing;
    final newItem = WorkoutExerciseItem(
      exerciseId: event.exercise.id,
      exerciseName: event.exercise.name,
    );
    emit(current.copyWith(
        exercises: [...current.exercises, newItem]));
  }

  void _onRemoveExercise(
    RemoveExercise event,
    Emitter<WorkoutBuilderState> emit,
  ) {
    final current = _currentEditing;
    final updated = List<WorkoutExerciseItem>.from(current.exercises)
      ..removeAt(event.index);
    emit(current.copyWith(exercises: updated));
  }

  void _onReorder(
    ReorderExercises event,
    Emitter<WorkoutBuilderState> emit,
  ) {
    final current = _currentEditing;
    final list = List<WorkoutExerciseItem>.from(current.exercises);
    final item = list.removeAt(event.oldIndex);
    final newIndex = event.newIndex > event.oldIndex
        ? event.newIndex - 1
        : event.newIndex;
    list.insert(newIndex, item);
    emit(current.copyWith(exercises: list));
  }

  Future<void> _onLoadLibrary(
    LoadExerciseLibrary event,
    Emitter<WorkoutBuilderState> emit,
  ) async {
    if (_allLibraryExercises.isNotEmpty) {
      emit(_currentEditing.copyWith(
          libraryExercises: _allLibraryExercises));
      return;
    }
    try {
      final response = await _dio.get('/exercises');
      _allLibraryExercises = (response.data as List)
          .map((e) =>
              ExerciseLibraryItem.fromJson(e as Map<String, dynamic>))
          .toList();
      emit(_currentEditing.copyWith(
          libraryExercises: _allLibraryExercises));
    } catch (_) {}
  }

  void _onSearch(
    SearchExercises event,
    Emitter<WorkoutBuilderState> emit,
  ) {
    final q = event.query.toLowerCase();
    final filtered = q.isEmpty
        ? _allLibraryExercises
        : _allLibraryExercises
            .where((e) =>
                e.name.toLowerCase().contains(q) ||
                e.muscleGroup.toLowerCase().contains(q))
            .toList();
    emit(_currentEditing.copyWith(libraryExercises: filtered));
  }

  Future<void> _onLoadStudents(
    LoadStudentsForAssign event,
    Emitter<WorkoutBuilderState> emit,
  ) async {
    try {
      final response = await _dio.get('/students');
      final students = (response.data as List)
          .map((e) =>
              AssignStudentItem.fromJson(e as Map<String, dynamic>))
          .toList();
      emit(_currentEditing.copyWith(availableStudents: students));
    } catch (_) {}
  }

  Future<void> _onAssign(
    AssignWorkoutToStudents event,
    Emitter<WorkoutBuilderState> emit,
  ) async {
    final current = _currentEditing;
    if (current.workoutId == null) {
      emit(const WorkoutBuilderError(
          'Salve o treino antes de atribuir.'));
      return;
    }
    try {
      await _dio.post(
        '/workouts/${current.workoutId}/assign',
        data: {'student_ids': event.studentIds},
      );
      emit(WorkoutAssigned());
      emit(current);
    } on DioException {
      emit(const WorkoutBuilderError('Erro ao atribuir treino.'));
    }
  }
}

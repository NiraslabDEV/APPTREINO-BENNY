import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import '../bloc/workout_builder_bloc.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/validators.dart';

class WorkoutBuilderScreen extends StatefulWidget {
  final String? workoutId; // null = novo treino
  const WorkoutBuilderScreen({super.key, required this.workoutId});

  @override
  State<WorkoutBuilderScreen> createState() =>
      _WorkoutBuilderScreenState();
}

class _WorkoutBuilderScreenState extends State<WorkoutBuilderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedLevel = 'hypertrophy';

  final List<String> _levels = [
    'hypertrophy',
    'strength',
    'endurance',
    'mobility',
  ];

  final Map<String, String> _levelLabels = {
    'hypertrophy': 'Hipertrofia',
    'strength': 'Força',
    'endurance': 'Resistência',
    'mobility': 'Mobilidade',
  };

  @override
  void initState() {
    super.initState();
    if (widget.workoutId != null) {
      context
          .read<WorkoutBuilderBloc>()
          .add(LoadWorkoutForEdit(widget.workoutId!));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkoutBuilderBloc, WorkoutBuilderState>(
      listener: (context, state) {
        if (state is WorkoutSaved) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Treino salvo!')),
          );
        }
        if (state is WorkoutAssigned) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Treino atribuído com sucesso!')),
          );
        }
        if (state is WorkoutBuilderError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: KineticColors.errorContainer,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: KineticColors.background,
        appBar: AppBar(
          backgroundColor: KineticColors.background,
          title: Text(
            widget.workoutId == null ? 'Novo Treino' : 'Editar Treino',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          elevation: 0,
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nome
                      TextFormField(
                        controller: _nameController,
                        maxLength: 100,
                        decoration: const InputDecoration(
                          labelText: 'Nome do Treino',
                          counterText: '',
                        ),
                        validator: Validators.requiredText,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: KineticColors.onSurface),
                      ),
                      const SizedBox(height: 16),

                      // Descrição
                      TextFormField(
                        controller: _descriptionController,
                        maxLength: 500,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Descrição (opcional)',
                          counterText: '',
                          alignLabelWithHint: true,
                        ),
                        validator: (v) =>
                            Validators.optionalText(v, maxLength: 500),
                      ),
                      const SizedBox(height: 16),

                      // Nível
                      Text('NÍVEL',
                          style: Theme.of(context).textTheme.labelLarge),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: _levels.map((level) {
                          final selected = level == _selectedLevel;
                          return ChoiceChip(
                            label: Text(_levelLabels[level]!),
                            selected: selected,
                            selectedColor: KineticColors.primaryContainer,
                            onSelected: (_) =>
                                setState(() => _selectedLevel = level),
                            labelStyle: TextStyle(
                              color: selected
                                  ? KineticColors.onPrimary
                                  : KineticColors.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),

                      // Exercícios
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('EXERCÍCIOS',
                              style:
                                  Theme.of(context).textTheme.labelLarge),
                          TextButton.icon(
                            onPressed: () =>
                                _showExerciseLibrary(context),
                            icon: const Icon(Icons.add,
                                color: KineticColors.primaryContainer),
                            label: const Text(
                              'Adicionar',
                              style: TextStyle(
                                  color: KineticColors.primaryContainer),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Lista drag-and-drop de exercícios
                      BlocBuilder<WorkoutBuilderBloc, WorkoutBuilderState>(
                        builder: (context, state) {
                          final exercises = state is WorkoutBuilderEditing
                              ? state.exercises
                              : <WorkoutExerciseItem>[];

                          if (exercises.isEmpty) {
                            return const _EmptyExerciseList();
                          }

                          return ReorderableListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            onReorder: (oldIndex, newIndex) {
                              context.read<WorkoutBuilderBloc>().add(
                                  ReorderExercises(
                                      oldIndex: oldIndex,
                                      newIndex: newIndex));
                            },
                            itemCount: exercises.length,
                            itemBuilder: (context, index) =>
                                _ExerciseListTile(
                              key: ValueKey(exercises[index].exerciseId),
                              item: exercises[index],
                              index: index,
                              onDelete: () => context
                                  .read<WorkoutBuilderBloc>()
                                  .add(RemoveExercise(index)),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Rodapé com botões
              _BottomBar(
                onSave: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<WorkoutBuilderBloc>().add(
                          SaveWorkout(
                            name: _nameController.text.trim(),
                            description:
                                _descriptionController.text.trim(),
                            level: _selectedLevel,
                          ),
                        );
                  }
                },
                onAssign: () => _showAssignDialog(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showExerciseLibrary(BuildContext context) {
    context
        .read<WorkoutBuilderBloc>()
        .add(LoadExerciseLibrary());
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: KineticColors.surfaceContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<WorkoutBuilderBloc>(),
        child: const _ExerciseLibrarySheet(),
      ),
    );
  }

  void _showAssignDialog(BuildContext context) {
    context.read<WorkoutBuilderBloc>().add(LoadStudentsForAssign());
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: KineticColors.surfaceContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<WorkoutBuilderBloc>(),
        child: const _AssignSheet(),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  final VoidCallback onSave;
  final VoidCallback onAssign;
  const _BottomBar({required this.onSave, required this.onAssign});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: KineticColors.surfaceContainerLow,
        border: Border(
            top: BorderSide(color: KineticColors.outlineVariant)),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                    color: KineticColors.primaryContainer),
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: onSave,
              child: const Text(
                'Salvar Template',
                style:
                    TextStyle(color: KineticColors.primaryContainer),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: onAssign,
              child: const Text('Atribuir Aluno'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExerciseListTile extends StatelessWidget {
  final WorkoutExerciseItem item;
  final int index;
  final VoidCallback onDelete;

  const _ExerciseListTile({
    super.key,
    required this.item,
    required this.index,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: KineticColors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Número
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: KineticColors.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                  color: KineticColors.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ),
          const SizedBox(width: 12),
          // Info exercício
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.exerciseName,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w600)),
                Text(
                  '${item.sets}x${item.reps} • ${item.restSeconds}s descanso • RPE ${item.rpeTarget}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          // Drag handle
          const Icon(Icons.drag_handle,
              color: KineticColors.outlineVariant),
          IconButton(
            icon: const Icon(Icons.delete_outline,
                color: KineticColors.error, size: 20),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}

class _EmptyExerciseList extends StatelessWidget {
  const _EmptyExerciseList();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: KineticColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: KineticColors.outlineVariant,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        children: [
          const Icon(Icons.fitness_center,
              size: 40, color: KineticColors.outlineVariant),
          const SizedBox(height: 12),
          Text(
            'Adicione exercícios da biblioteca',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _ExerciseLibrarySheet extends StatefulWidget {
  const _ExerciseLibrarySheet();

  @override
  State<_ExerciseLibrarySheet> createState() =>
      _ExerciseLibrarySheetState();
}

class _ExerciseLibrarySheetState extends State<_ExerciseLibrarySheet> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      expand: false,
      builder: (_, scrollController) => Column(
        children: [
          const SizedBox(height: 8),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: KineticColors.outlineVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Buscar exercício...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (q) => context
                  .read<WorkoutBuilderBloc>()
                  .add(SearchExercises(q)),
            ),
          ),
          Expanded(
            child: BlocBuilder<WorkoutBuilderBloc, WorkoutBuilderState>(
              builder: (context, state) {
                final exercises = state is WorkoutBuilderEditing
                    ? state.libraryExercises
                    : <ExerciseLibraryItem>[];
                return ListView.builder(
                  controller: scrollController,
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    final ex = exercises[index];
                    return ListTile(
                      title: Text(ex.name),
                      subtitle: Text(ex.muscleGroup),
                      trailing: IconButton(
                        icon: const Icon(Icons.add_circle,
                            color: KineticColors.primaryContainer),
                        onPressed: () {
                          context.read<WorkoutBuilderBloc>().add(
                              AddExerciseFromLibrary(ex));
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AssignSheet extends StatefulWidget {
  const _AssignSheet();

  @override
  State<_AssignSheet> createState() => _AssignSheetState();
}

class _AssignSheetState extends State<_AssignSheet> {
  final Set<String> _selectedIds = {};

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      expand: false,
      builder: (_, scrollController) => Column(
        children: [
          const SizedBox(height: 8),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: KineticColors.outlineVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Atribuir a Alunos',
                style: Theme.of(context).textTheme.headlineMedium),
          ),
          Expanded(
            child: BlocBuilder<WorkoutBuilderBloc, WorkoutBuilderState>(
              builder: (context, state) {
                final students = state is WorkoutBuilderEditing
                    ? state.availableStudents
                    : <AssignStudentItem>[];
                return ListView.builder(
                  controller: scrollController,
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final s = students[index];
                    return CheckboxListTile(
                      value: _selectedIds.contains(s.id),
                      onChanged: (v) => setState(() {
                        if (v == true) {
                          _selectedIds.add(s.id);
                        } else {
                          _selectedIds.remove(s.id);
                        }
                      }),
                      title: Text(s.name),
                      activeColor: KineticColors.primaryContainer,
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedIds.isEmpty
                    ? null
                    : () {
                        context.read<WorkoutBuilderBloc>().add(
                            AssignWorkoutToStudents(
                                _selectedIds.toList()));
                        Navigator.pop(context);
                      },
                child: Text('Atribuir (${_selectedIds.length})'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

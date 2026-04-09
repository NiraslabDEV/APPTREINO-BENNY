import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../bloc/session_bloc.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/validators.dart';

class SessionScreen extends StatefulWidget {
  final String workoutId;
  const SessionScreen({super.key, required this.workoutId});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  @override
  void initState() {
    super.initState();
    // Mantém tela ligada durante o treino
    WakelockPlus.enable();
    context.read<SessionBloc>().add(StartSession(widget.workoutId));
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionBloc, SessionState>(
      listener: (context, state) {
        if (state is SessionCompleted) {
          _showCompletionSheet(context, state);
        }
      },
      child: Scaffold(
        backgroundColor: KineticColors.background,
        body: SafeArea(
          child: BlocBuilder<SessionBloc, SessionState>(
            builder: (context, state) {
              if (state is SessionInProgress) {
                return _SessionBody(session: state);
              }
              if (state is SessionLoading) {
                return const Center(
                    child: CircularProgressIndicator(
                        color: KineticColors.primaryContainer));
              }
              if (state is SessionError) {
                return Center(
                  child: Text(state.message,
                      style:
                          const TextStyle(color: KineticColors.error)),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  void _showCompletionSheet(
      BuildContext context, SessionCompleted state) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      backgroundColor: KineticColors.surfaceContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _CompletionSheet(state: state),
    );
  }
}

class _SessionBody extends StatelessWidget {
  final SessionInProgress session;
  const _SessionBody({required this.session});

  @override
  Widget build(BuildContext context) {
    final exercise = session.currentExercise;
    return Column(
      children: [
        // Progress bar
        LinearProgressIndicator(
          value: session.progress,
          backgroundColor: KineticColors.surfaceContainerHigh,
          color: KineticColors.primaryContainer,
          minHeight: 4,
        ),

        // Header
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${session.currentExerciseIndex + 1}/${session.totalExercises}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              TextButton(
                onPressed: () => _confirmFinish(context),
                child: const Text('Encerrar',
                    style: TextStyle(color: KineticColors.error)),
              ),
            ],
          ),
        ),

        // Exercise name
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                exercise.exerciseName.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              Text(
                '${exercise.sets} séries × ${exercise.reps} reps',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),

        // Timer de descanso (aparece entre séries)
        if (session.isResting) ...[
          _RestTimer(
            seconds: session.restSecondsRemaining,
            totalSeconds: session.restSecondsTotal,
          ),
        ] else ...[
          // Logging de séries
          Expanded(
            child: _SetLogger(session: session),
          ),
        ],
      ],
    );
  }

  void _confirmFinish(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: KineticColors.surfaceContainer,
        title: const Text('Encerrar treino?'),
        content: const Text(
            'O progresso será salvo até a série atual.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continuar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<SessionBloc>().add(FinishSession());
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: KineticColors.error),
            child: const Text('Encerrar'),
          ),
        ],
      ),
    );
  }
}

class _RestTimer extends StatefulWidget {
  final int seconds;
  final int totalSeconds;
  const _RestTimer({required this.seconds, required this.totalSeconds});

  @override
  State<_RestTimer> createState() => _RestTimerState();
}

class _RestTimerState extends State<_RestTimer> {
  @override
  Widget build(BuildContext context) {
    final progress =
        widget.totalSeconds > 0 ? widget.seconds / widget.totalSeconds : 0.0;
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('DESCANSANDO',
              style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 24),
          SizedBox(
            width: 160,
            height: 160,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: progress,
                  color: KineticColors.primaryContainer,
                  backgroundColor: KineticColors.surfaceContainerHigh,
                  strokeWidth: 8,
                ),
                Text(
                  '${widget.seconds}s',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () =>
                context.read<SessionBloc>().add(SkipRest()),
            child: const Text('Pular descanso'),
          ),
        ],
      ),
    );
  }
}

class _SetLogger extends StatelessWidget {
  final SessionInProgress session;
  const _SetLogger({required this.session});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: session.setsToLog.length,
      itemBuilder: (context, index) {
        final set = session.setsToLog[index];
        return _SetRow(
          setNumber: index + 1,
          set: set,
          isActive: index == session.activeSetIndex,
          onLog: (weight, reps, rpe) {
            context.read<SessionBloc>().add(LogSet(
                  setNumber: index + 1,
                  weightKg: weight,
                  reps: reps,
                  rpe: rpe,
                ));
          },
        );
      },
    );
  }
}

class _SetRow extends StatefulWidget {
  final int setNumber;
  final SetState set;
  final bool isActive;
  final void Function(double weight, int reps, int rpe) onLog;

  const _SetRow({
    required this.setNumber,
    required this.set,
    required this.isActive,
    required this.onLog,
  });

  @override
  State<_SetRow> createState() => _SetRowState();
}

class _SetRowState extends State<_SetRow> {
  late TextEditingController _weightController;
  late TextEditingController _repsController;
  int _rpe = 8;

  @override
  void initState() {
    super.initState();
    _weightController = TextEditingController(
        text: widget.set.loggedWeight?.toString() ?? '');
    _repsController = TextEditingController(
        text: widget.set.loggedReps?.toString() ??
            widget.set.targetReps.toString());
  }

  @override
  void dispose() {
    _weightController.dispose();
    _repsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final done = widget.set.isDone;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: done
            ? KineticColors.primaryContainer.withOpacity(0.1)
            : widget.isActive
                ? KineticColors.surfaceContainerHigh
                : KineticColors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: widget.isActive && !done
            ? const Border.fromBorderSide(
                BorderSide(color: KineticColors.primaryContainer))
            : null,
      ),
      child: Row(
        children: [
          // Número da série
          SizedBox(
            width: 32,
            child: Text(
              'S${widget.setNumber}',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: done
                    ? KineticColors.primaryContainer
                    : KineticColors.onSurfaceVariant,
              ),
            ),
          ),

          // Peso
          Expanded(
            child: TextField(
              controller: _weightController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              enabled: !done && widget.isActive,
              decoration: const InputDecoration(
                labelText: 'Kg',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Reps
          Expanded(
            child: TextField(
              controller: _repsController,
              keyboardType: TextInputType.number,
              enabled: !done && widget.isActive,
              decoration: const InputDecoration(
                labelText: 'Reps',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Confirmar
          if (!done && widget.isActive)
            GestureDetector(
              onTap: () {
                final w = double.tryParse(
                    _weightController.text.replaceAll(',', '.'));
                final r = int.tryParse(_repsController.text);
                if (w != null && r != null) {
                  widget.onLog(w, r, _rpe);
                }
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: KineticColors.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check,
                    color: KineticColors.onPrimary, size: 20),
              ),
            )
          else if (done)
            const Icon(Icons.check_circle,
                color: KineticColors.primaryContainer),
        ],
      ),
    );
  }
}

class _CompletionSheet extends StatelessWidget {
  final SessionCompleted state;
  const _CompletionSheet({required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.emoji_events,
              size: 64, color: KineticColors.primaryContainer),
          const SizedBox(height: 16),
          Text('TREINO CONCLUÍDO!',
              style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 8),
          Text(
            '${state.totalVolumeKg.toStringAsFixed(0)} kg • ${state.durationMin} min',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          if (state.newPRs.isNotEmpty) ...[
            const SizedBox(height: 16),
            ...state.newPRs.map(
              (pr) => Chip(
                label: Text('🏆 PR: $pr'),
                backgroundColor: KineticColors.primaryContainer,
                labelStyle:
                    const TextStyle(color: KineticColors.onPrimary),
              ),
            ),
          ],
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Ver meu progresso'),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/students_bloc.dart';
import '../../../../../core/theme/app_theme.dart';

class StudentProfileScreen extends StatefulWidget {
  final String studentId;
  const StudentProfileScreen({super.key, required this.studentId});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<StudentsBloc>()
        .add(LoadStudentProfile(widget.studentId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KineticColors.background,
      body: BlocBuilder<StudentsBloc, StudentsState>(
        builder: (context, state) {
          if (state is StudentProfileLoaded) {
            return _ProfileBody(profile: state.profile);
          }
          if (state is StudentsLoading) {
            return const Center(
                child: CircularProgressIndicator(
                    color: KineticColors.primaryContainer));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  final StudentProfileModel profile;
  const _ProfileBody({required this.profile});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 240,
          pinned: true,
          backgroundColor: KineticColors.background,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(profile.name,
                style: Theme.of(context).textTheme.headlineMedium),
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    KineticColors.primaryContainer.withOpacity(0.15),
                    KineticColors.background,
                  ],
                ),
              ),
            ),
          ),
        ),

        // Stats
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                _StatChip(
                    label: 'Volume Semanal',
                    value:
                        '${profile.weeklyVolumeKg.toStringAsFixed(0)} kg'),
                const SizedBox(width: 12),
                _StatChip(
                    label: 'Peso Corporal',
                    value: '${profile.bodyWeightKg} kg'),
                const SizedBox(width: 12),
                _StatChip(
                    label: 'ADR',
                    value:
                        '${profile.adrPercent.toStringAsFixed(0)}%'),
              ],
            ),
          ),
        ),

        // Logs recentes
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
            child: Text('TREINOS RECENTES',
                style: Theme.of(context).textTheme.labelLarge),
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final log = profile.recentLogs[index];
              return ListTile(
                leading: const Icon(Icons.fitness_center,
                    color: KineticColors.primaryContainer),
                title: Text(log.workoutName),
                subtitle: Text(
                    '${log.totalVolumeKg.toStringAsFixed(0)} kg • ${log.durationMin} min'),
                trailing: Text(log.date,
                    style: Theme.of(context).textTheme.labelMedium),
              );
            },
            childCount: profile.recentLogs.length,
          ),
        ),

        const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: KineticColors.surfaceContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(value,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: KineticColors.primaryContainer,
                      fontSize: 20,
                    )),
            const SizedBox(height: 4),
            Text(label,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

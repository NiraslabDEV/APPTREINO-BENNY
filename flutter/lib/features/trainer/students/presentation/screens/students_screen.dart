import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../bloc/students_bloc.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/router/app_router.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<StudentsBloc>().add(LoadStudents());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KineticColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Meus Alunos',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ],
              ),
            ),

            // Busca
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Buscar por nome ou objetivo...',
                  prefixIcon: Icon(Icons.search),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onChanged: (q) =>
                    context.read<StudentsBloc>().add(SearchStudents(q)),
              ),
            ),

            // Lista
            Expanded(
              child: BlocBuilder<StudentsBloc, StudentsState>(
                builder: (context, state) {
                  if (state is StudentsLoading) {
                    return const Center(
                        child: CircularProgressIndicator(
                            color: KineticColors.primaryContainer));
                  }
                  if (state is StudentsLoaded) {
                    if (state.students.isEmpty) {
                      return const _EmptyState();
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: state.students.length,
                      itemBuilder: (context, index) =>
                          _StudentCard(student: state.students[index]),
                    );
                  }
                  if (state is StudentsError) {
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
          ],
        ),
      ),
    );
  }
}

class _StudentCard extends StatelessWidget {
  final StudentModel student;
  const _StudentCard({required this.student});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.go('/trainer/students/${student.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: KineticColors.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 28,
              backgroundColor: KineticColors.surfaceContainerHigh,
              backgroundImage: student.photoUrl != null
                  ? CachedNetworkImageProvider(student.photoUrl!)
                  : null,
              child: student.photoUrl == null
                  ? Text(
                      student.name[0].toUpperCase(),
                      style: const TextStyle(
                          color: KineticColors.primaryContainer,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  : null,
            ),
            const SizedBox(width: 16),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student.name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  if (student.goal != null) ...[
                    const SizedBox(height: 2),
                    Text(student.goal!,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                  const SizedBox(height: 6),
                  Text(
                    student.lastWorkout != null
                        ? 'Último treino: ${student.lastWorkout}'
                        : 'Nenhum treino registrado',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),

            // ADR Circle
            CircularPercentIndicator(
              radius: 28,
              lineWidth: 4,
              percent: (student.adrPercent / 100).clamp(0.0, 1.0),
              center: Text(
                '${student.adrPercent.toStringAsFixed(0)}%',
                style: const TextStyle(
                  color: KineticColors.onSurface,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              progressColor: student.adrPercent >= 70
                  ? KineticColors.primaryContainer
                  : student.adrPercent >= 40
                      ? KineticColors.tertiary
                      : KineticColors.error,
              backgroundColor: KineticColors.outlineVariant,
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.people_outline,
              size: 64, color: KineticColors.outlineVariant),
          const SizedBox(height: 16),
          Text('Nenhum aluno encontrado',
              style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}

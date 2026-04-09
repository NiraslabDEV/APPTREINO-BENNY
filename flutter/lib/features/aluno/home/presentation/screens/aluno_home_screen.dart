import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../bloc/aluno_home_bloc.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/router/app_router.dart';

class AlunoHomeScreen extends StatefulWidget {
  const AlunoHomeScreen({super.key});

  @override
  State<AlunoHomeScreen> createState() => _AlunoHomeScreenState();
}

class _AlunoHomeScreenState extends State<AlunoHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AlunoHomeBloc>().add(LoadTodayWorkout());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KineticColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          color: KineticColors.primaryContainer,
          onRefresh: () async =>
              context.read<AlunoHomeBloc>().add(LoadTodayWorkout()),
          child: CustomScrollView(
            slivers: [
              // TopBar
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'KINETIC',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(
                              color: KineticColors.primaryContainer,
                              fontStyle: FontStyle.italic,
                              letterSpacing: -1,
                            ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_outlined),
                        color: KineticColors.primaryContainer,
                      ),
                    ],
                  ),
                ),
              ),

              // Greeting
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                  child: BlocBuilder<AlunoHomeBloc, AlunoHomeState>(
                    builder: (context, state) {
                      final name = state is AlunoHomeLoaded
                          ? state.alunoName
                          : '';
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BEM-VINDO DE VOLTA',
                            style:
                                Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Hi, $name!',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(fontStyle: FontStyle.italic),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),

              // Bento Grid
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: BlocBuilder<AlunoHomeBloc, AlunoHomeState>(
                    builder: (context, state) {
                      if (state is AlunoHomeLoading) {
                        return const _HomeShimmer();
                      }
                      if (state is AlunoHomeLoaded) {
                        return Column(
                          children: [
                            // Hero card — Treino de Hoje
                            _TodayWorkoutHero(
                              workout: state.todayWorkout,
                              onStart: () => context.go(
                                '/aluno/session/${state.todayWorkout?.workoutId ?? ''}',
                              ),
                            ),
                            const SizedBox(height: 16),
                            // PRs recentes
                            if (state.recentPRs.isNotEmpty)
                              _RecentPRsCard(prs: state.recentPRs),
                          ],
                        );
                      }
                      if (state is AlunoHomeError) {
                        return Center(
                          child: Text(state.message,
                              style: const TextStyle(
                                  color: KineticColors.error)),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),

              const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
            ],
          ),
        ),
      ),
    );
  }
}

class _TodayWorkoutHero extends StatelessWidget {
  final TodayWorkoutModel? workout;
  final VoidCallback onStart;

  const _TodayWorkoutHero(
      {required this.workout, required this.onStart});

  @override
  Widget build(BuildContext context) {
    if (workout == null) {
      return Container(
        height: 200,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: KineticColors.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_outline,
                size: 48, color: KineticColors.primaryContainer),
            const SizedBox(height: 12),
            Text(
              'Nenhum treino hoje',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Bom descanso!',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: 360,
        child: Stack(
          children: [
            // Background image
            if (workout!.imageUrl != null)
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: workout!.imageUrl!,
                  fit: BoxFit.cover,
                  color: Colors.black.withOpacity(0.55),
                  colorBlendMode: BlendMode.darken,
                ),
              )
            else
              Positioned.fill(
                child: Container(
                  color: KineticColors.surfaceContainerHigh,
                ),
              ),

            // Gradient overlay
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      KineticColors.surface.withOpacity(0.9),
                    ],
                  ),
                ),
              ),
            ),

            // Content
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: KineticColors.primaryContainer,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'SESSÃO DE HOJE',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                              color: KineticColors.onPrimary,
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      workout!.workoutName.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                            fontSize: 28,
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                    Text(
                      '${workout!.estimatedMinutes} min • ${workout!.exerciseCount} exercícios',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: onStart,
                      icon: const Icon(Icons.play_arrow_rounded),
                      label: const Text('INICIAR TREINO'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: KineticColors.primaryContainer,
                        foregroundColor: KineticColors.onPrimary,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentPRsCard extends StatelessWidget {
  final List<PRModel> prs;
  const _RecentPRsCard({required this.prs});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: KineticColors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: const Border(
          left: BorderSide(color: KineticColors.secondary, width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('RECORDES RECENTES',
                  style: Theme.of(context).textTheme.labelLarge),
              const Icon(Icons.military_tech,
                  color: KineticColors.secondary),
            ],
          ),
          const SizedBox(height: 16),
          ...prs.take(3).map(
                (pr) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(pr.exerciseName,
                            style: Theme.of(context).textTheme.bodyMedium),
                      ),
                      Text(
                        '${pr.weightKg} kg × ${pr.reps}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontSize: 18,
                              color: KineticColors.secondary,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

class _HomeShimmer extends StatelessWidget {
  const _HomeShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 360,
          decoration: BoxDecoration(
            color: KineticColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 160,
          decoration: BoxDecoration(
            color: KineticColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ],
    );
  }
}

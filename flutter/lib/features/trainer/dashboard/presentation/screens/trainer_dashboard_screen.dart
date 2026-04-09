import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/dashboard_bloc.dart';
import '../widgets/metric_card.dart';
import '../widgets/activity_feed_tile.dart';
import '../../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/router/app_router.dart';

class TrainerDashboardScreen extends StatefulWidget {
  const TrainerDashboardScreen({super.key});

  @override
  State<TrainerDashboardScreen> createState() =>
      _TrainerDashboardScreenState();
}

class _TrainerDashboardScreenState extends State<TrainerDashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(LoadDashboardMetrics());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KineticColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          color: KineticColors.primaryContainer,
          onRefresh: () async =>
              context.read<DashboardBloc>().add(LoadDashboardMetrics()),
          child: CustomScrollView(
            slivers: [
              // App bar customizada
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
                        onPressed: () =>
                            context.read<AuthBloc>().add(LogoutRequested()),
                        icon: const Icon(Icons.logout_outlined),
                        color: KineticColors.onSurfaceVariant,
                      ),
                    ],
                  ),
                ),
              ),

              // Greeting
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                  child: BlocBuilder<DashboardBloc, DashboardState>(
                    builder: (context, state) {
                      final name = state is DashboardLoaded
                          ? state.trainerName
                          : 'Coach';
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BOM DIA',
                            style: Theme.of(context).textTheme.labelLarge,
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

              // Métricas
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: BlocBuilder<DashboardBloc, DashboardState>(
                    builder: (context, state) {
                      if (state is DashboardLoading) {
                        return const _MetricsShimmer();
                      }
                      if (state is DashboardLoaded) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: MetricCard(
                                    label: 'Alunos Ativos',
                                    value:
                                        '${state.metrics.activeStudents}',
                                    icon: Icons.people,
                                    color: KineticColors.primaryContainer,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: MetricCard(
                                    label: 'Treinaram Hoje',
                                    value:
                                        '${state.metrics.trainedToday}',
                                    icon: Icons.check_circle_outline,
                                    color: KineticColors.secondary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            MetricCard(
                              label: 'Inativos há +3 dias',
                              value: '${state.metrics.inactiveStudents}',
                              icon: Icons.warning_amber_outlined,
                              color: KineticColors.error,
                              fullWidth: true,
                              trailing: state.metrics.inactiveStudents > 0
                                  ? TextButton(
                                      onPressed: () {},
                                      child: const Text('Nudge All'),
                                    )
                                  : null,
                            ),
                          ],
                        );
                      }
                      if (state is DashboardError) {
                        return _ErrorCard(message: state.message);
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),

              // Activity Feed
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                  child: Text(
                    'ATIVIDADE RECENTE',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),

              BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
                  if (state is! DashboardLoaded) {
                    return const SliverToBoxAdapter(child: SizedBox.shrink());
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ActivityFeedTile(
                            activity: state.recentActivities[index]),
                      ),
                      childCount: state.recentActivities.length,
                    ),
                  );
                },
              ),

              const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go(AppRouter.trainerWorkoutBuilder),
        backgroundColor: KineticColors.primaryContainer,
        foregroundColor: KineticColors.onPrimary,
        icon: const Icon(Icons.add),
        label: const Text('Novo Treino',
            style: TextStyle(fontWeight: FontWeight.w900)),
      ),
    );
  }
}

class _MetricsShimmer extends StatelessWidget {
  const _MetricsShimmer();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(children: [
          Expanded(child: _ShimmerBox(height: 100)),
          SizedBox(width: 12),
          Expanded(child: _ShimmerBox(height: 100)),
        ]),
        SizedBox(height: 12),
        _ShimmerBox(height: 80),
      ],
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  final double height;
  const _ShimmerBox({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: KineticColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  final String message;
  const _ErrorCard({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: KineticColors.errorContainer.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: KineticColors.error.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: KineticColors.error),
          const SizedBox(width: 12),
          Expanded(
              child: Text(message,
                  style: const TextStyle(color: KineticColors.error))),
        ],
      ),
    );
  }
}

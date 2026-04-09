import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/app_constants.dart';
import '../di/injection.dart';

// Screens — serão criadas nas features
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/trainer/dashboard/presentation/screens/trainer_dashboard_screen.dart';
import '../../features/trainer/students/presentation/screens/students_screen.dart';
import '../../features/trainer/students/presentation/screens/student_profile_screen.dart';
import '../../features/trainer/workouts/presentation/screens/workout_builder_screen.dart';
import '../../features/aluno/home/presentation/screens/aluno_home_screen.dart';
import '../../features/aluno/session/presentation/screens/session_screen.dart';
import '../../features/aluno/progress/presentation/screens/progress_screen.dart';

class AppRouter {
  static const String login = '/login';

  // Trainer routes
  static const String trainerDashboard = '/trainer/dashboard';
  static const String trainerStudents = '/trainer/students';
  static const String trainerStudentProfile = '/trainer/students/:id';
  static const String trainerWorkoutBuilder = '/trainer/workouts/new';
  static const String trainerWorkoutEdit = '/trainer/workouts/:id/edit';

  // Aluno routes
  static const String alunoHome = '/aluno/home';
  static const String alunoSession = '/aluno/session/:workoutId';
  static const String alunoProgress = '/aluno/progress';

  static GoRouter router(FlutterSecureStorage storage) {
    return GoRouter(
      initialLocation: login,
      redirect: (context, state) async {
        final token = await storage.read(key: AppConstants.accessTokenKey);
        final isLoggingIn = state.matchedLocation == login;

        if (token == null && !isLoggingIn) return login;
        if (token != null && isLoggingIn) {
          final role = await storage.read(key: AppConstants.userRoleKey);
          return role == AppConstants.roleTrainer
              ? trainerDashboard
              : alunoHome;
        }
        return null;
      },
      routes: [
        GoRoute(
          path: login,
          builder: (_, __) => const LoginScreen(),
        ),

        // Trainer shell com bottom nav
        ShellRoute(
          builder: (context, state, child) => _TrainerShell(child: child),
          routes: [
            GoRoute(
              path: trainerDashboard,
              builder: (_, __) => const TrainerDashboardScreen(),
            ),
            GoRoute(
              path: trainerStudents,
              builder: (_, __) => const StudentsScreen(),
            ),
            GoRoute(
              path: trainerStudentProfile,
              builder: (_, state) =>
                  StudentProfileScreen(studentId: state.pathParameters['id']!),
            ),
            GoRoute(
              path: trainerWorkoutBuilder,
              builder: (_, __) =>
                  const WorkoutBuilderScreen(workoutId: null),
            ),
            GoRoute(
              path: trainerWorkoutEdit,
              builder: (_, state) => WorkoutBuilderScreen(
                  workoutId: state.pathParameters['id']),
            ),
          ],
        ),

        // Aluno shell com bottom nav
        ShellRoute(
          builder: (context, state, child) => _AlunoShell(child: child),
          routes: [
            GoRoute(
              path: alunoHome,
              builder: (_, __) => const AlunoHomeScreen(),
            ),
            GoRoute(
              path: alunoSession,
              builder: (_, state) => SessionScreen(
                  workoutId: state.pathParameters['workoutId']!),
            ),
            GoRoute(
              path: alunoProgress,
              builder: (_, __) => const ProgressScreen(),
            ),
          ],
        ),
      ],
      errorBuilder: (_, state) => Scaffold(
        body: Center(child: Text('Rota não encontrada: ${state.error}')),
      ),
    );
  }
}

class _TrainerShell extends StatelessWidget {
  final Widget child;
  const _TrainerShell({required this.child});

  @override
  Widget build(BuildContext context) {
    final location =
        GoRouterState.of(context).matchedLocation;

    int currentIndex = 0;
    if (location.startsWith('/trainer/students')) currentIndex = 1;
    if (location.startsWith('/trainer/workouts')) currentIndex = 2;

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (i) {
          switch (i) {
            case 0:
              context.go(AppRouter.trainerDashboard);
            case 1:
              context.go(AppRouter.trainerStudents);
            case 2:
              context.go(AppRouter.trainerWorkoutBuilder);
          }
        },
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(Icons.dashboard),
              label: 'Dashboard'),
          NavigationDestination(
              icon: Icon(Icons.people_outline),
              selectedIcon: Icon(Icons.people),
              label: 'Alunos'),
          NavigationDestination(
              icon: Icon(Icons.fitness_center_outlined),
              selectedIcon: Icon(Icons.fitness_center),
              label: 'Builder'),
        ],
      ),
    );
  }
}

class _AlunoShell extends StatelessWidget {
  final Widget child;
  const _AlunoShell({required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    int currentIndex = 0;
    if (location.startsWith('/aluno/progress')) currentIndex = 1;

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (i) {
          switch (i) {
            case 0:
              context.go(AppRouter.alunoHome);
            case 1:
              context.go(AppRouter.alunoProgress);
          }
        },
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Início'),
          NavigationDestination(
              icon: Icon(Icons.bar_chart_outlined),
              selectedIcon: Icon(Icons.bar_chart),
              label: 'Progresso'),
        ],
      ),
    );
  }
}

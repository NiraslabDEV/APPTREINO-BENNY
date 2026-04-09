import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/trainer/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'features/trainer/students/presentation/bloc/students_bloc.dart';
import 'features/trainer/workouts/presentation/bloc/workout_builder_bloc.dart';
import 'features/aluno/home/presentation/bloc/aluno_home_bloc.dart';
import 'features/aluno/session/presentation/bloc/session_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await configureDependencies();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF0E0E0E),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const KineticApp());
}

class KineticApp extends StatelessWidget {
  const KineticApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // AuthBloc é singleton — persiste em toda navegação
        BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>(),
        ),
        BlocProvider<DashboardBloc>(
          create: (_) => sl<DashboardBloc>(),
        ),
        BlocProvider<StudentsBloc>(
          create: (_) => sl<StudentsBloc>(),
        ),
        BlocProvider<WorkoutBuilderBloc>(
          create: (_) => sl<WorkoutBuilderBloc>(),
        ),
        BlocProvider<AlunoHomeBloc>(
          create: (_) => sl<AlunoHomeBloc>(),
        ),
        BlocProvider<SessionBloc>(
          create: (_) => sl<SessionBloc>(),
        ),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // Limpa BLoCs de dados ao fazer logout
          if (state is AuthUnauthenticated) {
            sl<DashboardBloc>().add(LoadDashboardMetrics());
          }
        },
        child: MaterialApp.router(
          title: 'KINETIC',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          routerConfig: AppRouter.router(sl()),
        ),
      ),
    );
  }
}

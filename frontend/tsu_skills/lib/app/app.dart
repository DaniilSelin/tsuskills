import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsu_skills/app/app_data/strategy/app_strategy.dart';
import 'package:tsu_skills/app/di/di.dart';
import 'package:tsu_skills/app/router/app_router.dart';
import 'package:tsu_skills/entities/user_role/bloc/user_role_bloc.dart';
import 'package:tsu_skills/entities/user_role/model/role_enum.dart';
import 'package:tsu_skills/features/auth/index.dart';
import 'package:tsu_skills/shared/lib/ui/theme/base_theme.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/loading/expanded_circular_progress_indicator.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserRoleBloc>(),
      child: BlocBuilder<UserRoleBloc, UserRoleState>(
        builder: (context, state) {
          return state.map(
            loading: (d) => LoadingApp(),
            loadedRole: (d) => LoadedApp(d.role),
            error: (d) => ErrorApp(d.message),
          );
        },
      ),
    );
  }
}

class LoadedApp extends StatelessWidget {
  const LoadedApp(this.role, {super.key});
  final RoleEnum role;

  @override
  Widget build(BuildContext context) {
    final strategy = AppStrategy(role);
    return MaterialApp.router(
      theme: strategy.themeData,
      routerConfig: AppRouter(strategy).config(),
    );
  }
}

class ErrorApp extends StatelessWidget {
  const ErrorApp(this.message, {super.key});
  final String message;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: baseAppTheme,
      home: Scaffold(
        body: Center(
          child: SizedBox(width: 400, child: ErrorContainer(message: message)),
        ),
      ),
    );
  }
}

class LoadingApp extends StatelessWidget {
  const LoadingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: baseAppTheme,
      home: Scaffold(body: CircularProgressIndicatorPlaceholder()),
    );
  }
}

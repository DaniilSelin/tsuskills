import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tsu_skills/app/di/di.dart';
import 'package:tsu_skills/app/router/app_router.dart';
import 'package:tsu_skills/entities/user_role/bloc/user_role_bloc.dart';
import 'package:tsu_skills/features/auth/bloc/login/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsu_skills/features/auth/ui/widgets.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/form/form.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/loading/button_circular_progress_indicator.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _goToSignUpScreen(BuildContext context) {
    if (context.mounted) {
      AutoRouter.of(context).push(const SignUpRoute());
    }
  }

  void _goToForgotPasswordScreen(BuildContext context) {
    if (context.mounted) {
      AutoRouter.of(context).push(const ForgotPasswordRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    //final textStyles = Theme.of(context).extension<AppTextStylesExtension>()!;
    final router = AutoRouter.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: 400,
              child: Card(
                child: Padding(
                  padding: EdgeInsetsGeometry.all(8),

                  child: BlocProvider(
                    create: (context) => getIt<LoginBloc>(),
                    child: BlocListener<LoginBloc, LoginState>(
                      listener: (context, state) {
                        state.mapOrNull(
                          success: (value) {
                            final roleBloc = BlocProvider.of<UserRoleBloc>(
                              context,
                            );
                            roleBloc.add(UserRoleEvent.updateRole());
                          },
                        );

                        isLoading = state.maybeMap(
                          orElse: () => false,
                          loading: (d) => true,
                        );
                      },
                      child: Builder(
                        builder: (context) {
                          final bloc = BlocProvider.of<LoginBloc>(context);

                          return Form(
                            key: _loginFormKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Logo(),
                                ),
                                BlocBuilder<LoginBloc, LoginState>(
                                  builder: (context, state) => state.maybeMap(
                                    orElse: () => SizedBox(),
                                    error: (d) =>
                                        ErrorContainer(message: d.message),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: UsernameTextField(_usernameController),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: PasswordTextField(_passwordController),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_loginFormKey.currentState!
                                              .validate() &&
                                          !isLoading) {
                                        bloc.add(
                                          LoginEvent.sendData(
                                            username: _usernameController.text,
                                            password: _passwordController.text,
                                          ),
                                        );
                                      }
                                    },
                                    child: BlocBuilder<LoginBloc, LoginState>(
                                      builder: (context, state) => state.maybeMap(
                                        orElse: () =>
                                            Center(child: Text('Войти')),
                                        loading: (d) =>
                                            ButtonCircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => _goToSignUpScreen(context),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'Нет аккаунта',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _goToForgotPasswordScreen(context),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'Забыли пароль',
                        style: TextStyle(color: Colors.blue),
                      ),
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

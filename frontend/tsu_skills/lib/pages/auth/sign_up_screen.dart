import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsu_skills/app/di/di.dart';
import 'package:tsu_skills/app/router/app_router.dart';
import 'package:tsu_skills/features/auth/bloc/sign_up/sign_up_bloc.dart';
import 'package:tsu_skills/features/auth/ui/widgets.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/form/form.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/loading/button_circular_progress_indicator.dart';

@RoutePage()
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();
  final _signUpFormKey = GlobalKey<FormState>();

  bool isLoading = false;

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
                    create: (context) => getIt<SignUpBloc>(),
                    child: BlocListener<SignUpBloc, SignUpState>(
                      listener: (context, state) {
                        state.mapOrNull(
                          success: (value) => router.replaceAll([HomeRoute()]),
                        );

                        isLoading = state.maybeMap(
                          orElse: () => false,
                          loading: (d) => true,
                        );
                      },
                      child: Builder(
                        builder: (context) {
                          final bloc = BlocProvider.of<SignUpBloc>(context);

                          return Form(
                            key: _signUpFormKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Logo(),
                                ),
                                BlocBuilder<SignUpBloc, SignUpState>(
                                  builder: (context, state) => state.maybeMap(
                                    orElse: () => SizedBox(),
                                    error: (d) =>
                                        ErrorContainer(message: d.message),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: EmailTextField(_emailController),
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
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: PasswordTextField(
                                    _repeatPasswordController,
                                    label: 'Повторите пароль',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_signUpFormKey.currentState!
                                              .validate() &&
                                          !isLoading) {
                                        bloc.add(
                                          SignUpEvent.sendData(
                                            username: _usernameController.text,
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                            repeatPassword:
                                                _repeatPasswordController.text,
                                          ),
                                        );
                                      }
                                    },
                                    child: BlocBuilder<SignUpBloc, SignUpState>(
                                      builder: (context, state) => state.maybeMap(
                                        orElse: () => Center(
                                          child: Text('Зарегистрироваться'),
                                        ),
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
        ],
      ),
    );
  }
}

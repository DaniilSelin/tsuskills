import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsu_skills/app/di/di.dart';
import 'package:tsu_skills/features/auth/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:tsu_skills/shared/lib/ui/theme/text_styles.dart';
import 'package:tsu_skills/features/auth/ui/widgets.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/form/email_text_field.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/loading/button_circular_progress_indicator.dart';

@RoutePage()
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _forgotPasswordFormKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).extension<AppTextStylesExtension>()!;
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
                    create: (context) => getIt<ForgotPasswordBloc>(),
                    child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                      builder: (context, state) {
                        final bloc = BlocProvider.of<ForgotPasswordBloc>(
                          context,
                        );

                        return state.maybeMap(
                          success: (d) => Column(
                            children: [
                              Text(
                                'Письмо успешно отправлено! Проверьте свою эл. почту.',
                                style: textStyles.heading1,
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: ElevatedButton(
                                  onPressed: () => router.back(),
                                  child: Center(child: Text('Назад')),
                                ),
                              ),
                            ],
                          ),
                          orElse: () => Form(
                            key: _forgotPasswordFormKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Logo(),
                                ),

                                BlocBuilder<
                                  ForgotPasswordBloc,
                                  ForgotPasswordState
                                >(
                                  builder: (context, state) => state.maybeMap(
                                    orElse: () => SizedBox(),
                                    error: (d) =>
                                        ErrorContainer(message: d.message),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'Укажите вашу почту. Мы отправим на неё письмо со ссылкой для сброса пароля.',
                                    style: textStyles.secondaryText,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: EmailTextField(_emailController),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_forgotPasswordFormKey.currentState!
                                              .validate() &&
                                          !isLoading) {
                                        bloc.add(
                                          ForgotPasswordEvent.sendData(
                                            _emailController.text,
                                          ),
                                        );
                                      }
                                    },
                                    child:
                                        BlocBuilder<
                                          ForgotPasswordBloc,
                                          ForgotPasswordState
                                        >(
                                          builder: (context, state) =>
                                              state.maybeMap(
                                                orElse: () => Center(
                                                  child: Text('Отправить'),
                                                ),
                                                loading: (d) =>
                                                    ButtonCircularProgressIndicator(),
                                              ),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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

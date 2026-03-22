import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsu_skills/app/di/di.dart';
import 'package:tsu_skills/features/auth/ui/error_container.dart';
import 'package:tsu_skills/features/create_resume/bloc/create_resume_bloc.dart';
import 'package:tsu_skills/features/my_resumes/index.dart';
import 'package:tsu_skills/shared/lib/ui/theme/text_styles.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/loading/expanded_circular_progress_indicator.dart';

@RoutePage()
class CreateResumeScreen extends StatefulWidget {
  const CreateResumeScreen({super.key});

  @override
  State<CreateResumeScreen> createState() => _CreateResumeScreenState();
}

class _CreateResumeScreenState extends State<CreateResumeScreen> {
  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).extension<AppTextStylesExtension>();

    if (textStyles == null) {
      return const Center(
        child: Text('Ошибка: AppTextStylesExtension не найден.'),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Создание резюме')),
      body: BlocProvider(
        create: (context) => getIt<CreateResumeBloc>(),
        child: BlocListener<CreateResumeBloc, CreateResumeState>(
          listener: (context, state) {
            state.mapOrNull(
              success: (d) {
                AutoRouter.of(context).pop<bool>(true);
              },
            );
          },
          child: BlocBuilder<CreateResumeBloc, CreateResumeState>(
            builder: (context, state) {
              return state.map(
                loading: (d) => CircularProgressIndicatorPlaceholder(),
                success: (d) => Center(child: Text('Сохранено')),
                error: (d) => Center(
                  child: SizedBox(
                    width: 400,
                    child: ErrorContainer(message: d.message),
                  ),
                ),
                initial: (d) => SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: SizedBox(
                      width: 600,
                      child: ResumeForm(
                        description: '',
                        name: '',
                        aboutMe: '',
                        skills: [],
                        onSave: (name, aboutMe, description, skills) {
                          BlocProvider.of<CreateResumeBloc>(context).add(
                            CreateResumeEvent.createResume(
                              name: name,
                              description: description,
                              aboutMe: aboutMe,
                              skills: skills,
                            ),
                          );
                        },
                        saveButtonText: 'Сохранить резюме',
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

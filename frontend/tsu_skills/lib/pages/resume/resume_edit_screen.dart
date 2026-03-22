import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsu_skills/app/di/di.dart';
import 'package:tsu_skills/features/auth/ui/error_container.dart';
import 'package:tsu_skills/features/my_resumes/index.dart';
import 'package:tsu_skills/shared/lib/ui/theme/text_styles.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/loading/expanded_circular_progress_indicator.dart';

@RoutePage()
class EditResumeScreen extends StatefulWidget {
  const EditResumeScreen({super.key, required this.resumeId});
  final String resumeId;

  @override
  State<EditResumeScreen> createState() => _EditResumeScreenState();
}

class _EditResumeScreenState extends State<EditResumeScreen> {
  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).extension<AppTextStylesExtension>();

    if (textStyles == null) {
      return const Center(
        child: Text('Ошибка: AppTextStylesExtension не найден.'),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Редактирование резюме')),
      body: BlocProvider(
        create: (context) => getIt<ResumeEditBloc>(param1: widget.resumeId),
        child: BlocListener<ResumeEditBloc, ResumeEditState>(
          listener: (context, state) {
            state.mapOrNull(
              saved: (d) {
                AutoRouter.of(context).pop<bool>(true);
              },
            );
          },
          child: BlocBuilder<ResumeEditBloc, ResumeEditState>(
            builder: (context, state) {
              return state.map(
                loading: (d) => CircularProgressIndicatorPlaceholder(),
                saved: (d) => Center(child: Text('Сохранено')),
                error: (d) => Center(
                  child: SizedBox(
                    width: 400,
                    child: ErrorContainer(message: d.message),
                  ),
                ),
                loaded: (d) => SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: SizedBox(
                      width: 600,
                      child: ResumeForm(
                        description: d.description,
                        name: d.name,
                        aboutMe: d.aboutMe,
                        skills: d.skills,
                        onSave: (name, aboutMe, description, skills) {
                          BlocProvider.of<ResumeEditBloc>(context).add(
                            ResumeEditEvent.save(
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

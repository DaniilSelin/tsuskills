import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsu_skills/app/di/di.dart';
import 'package:tsu_skills/app/router/app_router.dart';
import 'package:tsu_skills/entities/resume/index.dart';
import 'package:tsu_skills/features/auth/ui/widgets.dart';
import 'package:tsu_skills/features/my_resumes/bloc/resume_list/resume_list_bloc.dart';
import 'package:tsu_skills/shared/assets/assets.gen.dart';
import 'package:tsu_skills/shared/lib/ui/theme/text_styles.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/loading/expanded_circular_progress_indicator.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/other/header_image.dart';
import 'package:tsu_skills/entities/skill/ui/skill_chip.dart';

@RoutePage()
class UserResumesScreen extends StatelessWidget {
  const UserResumesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).extension<AppTextStylesExtension>();
    final router = AutoRouter.of(context);

    if (textStyles == null) {
      return const Center(
        child: Text('Ошибка: AppTextStylesExtension не найден.'),
      );
    }

    return BlocProvider(
      create: (context) => getIt<ResumeListBloc>(),
      child: Builder(
        builder: (context) {
          final bloc = BlocProvider.of<ResumeListBloc>(context);

          return Scaffold(
            body: BlocBuilder<ResumeListBloc, ResumeListState>(
              builder: (context, state) {
                return state.map(
                  loading: (d) => CircularProgressIndicatorPlaceholder(),
                  error: (d) => ErrorContainer(message: d.error),
                  loaded: (d) {
                    final resumes = d.resumes;

                    if (resumes.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(Assets.image.emptyResumeList.keyName),
                            Text('У вас нет резюме. Создайте его!'),
                          ],
                        ),
                      );
                    }

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          HeaderImage(
                            imgProvider:
                                Assets.image.girlWithResumes380380.keyName,
                            title: 'Мои резюме',
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 12.0,
                            ),
                            itemCount: resumes.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                key: Key(resumes[index].id),
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: _ResumeListItem(
                                  resume: resumes[index],
                                  onTap: () {
                                    router
                                        .push<bool>(
                                          ResumeDetailRoute(
                                            resumeId: resumes[index].id,
                                          ),
                                        )
                                        .then((result) {
                                          if (context.mounted &&
                                              result != null &&
                                              result) {
                                            BlocProvider.of<ResumeListBloc>(
                                              context,
                                            ).add(
                                              ResumeListEvent.fetchMyResumes(),
                                            );
                                          }
                                        });
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                final result = await router.push<bool>(CreateResumeRoute());
                if (result != null && result) {
                  bloc.add(ResumeListEvent.fetchMyResumes());
                }
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}

class _ResumeListItem extends StatelessWidget {
  final ResumeEntity resume;

  const _ResumeListItem({required this.resume, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).extension<AppTextStylesExtension>();

    if (textStyles == null) {
      return const Center(
        child: Text('Ошибка: AppTextStylesExtension не найден.'),
      );
    }

    return Card(
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.0),

        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(resume.name, style: textStyles.heading2),
              const SizedBox(height: 8.0),

              Text(
                resume.description,
                style: textStyles.secondaryText,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12.0),

              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: resume.skills
                    .map(
                      (skill) => SkillChip(
                        label: skill.name,
                        textStyle: textStyles.accentText,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

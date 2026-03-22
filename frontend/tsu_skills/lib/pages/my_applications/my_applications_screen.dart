import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsu_skills/app/router/app_router.dart';
import 'package:tsu_skills/features/auth/index.dart';
import 'package:tsu_skills/features/my_application/index.dart';
import 'package:tsu_skills/shared/assets/assets.gen.dart';
import 'package:tsu_skills/shared/lib/ui/theme/text_styles.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/loading/expanded_circular_progress_indicator.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/other/header_image.dart';

@RoutePage()
class MyApplicationsScreen extends StatelessWidget {
  const MyApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).extension<AppTextStylesExtension>()!;
    final router = AutoRouter.of(context);

    return Scaffold(
      body: BlocBuilder<MyApplicationBloc, MyApplicationState>(
        builder: (context, state) {
          return state.when(
            loading: () => CircularProgressIndicatorPlaceholder(),
            loaded: (applications) {
              if (applications.isEmpty) {
                return Center(
                  child: HeaderImage(
                    imgProvider: Assets.image.girlQuestion380380.keyName,
                    title: 'Вы пока не откликались на вакансии',
                  ),
                );
              }

              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    HeaderImage(
                      imgProvider: Assets.image.girlAndLetters380380.keyName,
                      title: 'Ваши отклики',
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(16),
                      itemCount: applications.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final application = applications[index];
                        final resume = application.resume;
                        final vacancy = application.vacancy;

                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: () {
                              router.push(
                                VacancyDetailRoute(
                                  vacancyId:
                                      applications[index].vacancy.objectId,
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // 🕒 Дата отклика
                                  Text(
                                    _formatDate(application.createdAt),
                                    style: textStyles.secondaryText,
                                  ),
                                  const SizedBox(height: 8),

                                  // 📄 Название резюме
                                  Text(resume.name, style: textStyles.heading2),
                                  const SizedBox(height: 4),

                                  // 📃 Описание резюме
                                  Text(
                                    resume.description,
                                    style: textStyles.bodyText,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 12),

                                  const Divider(),

                                  const SizedBox(height: 12),

                                  // 🏢 Вакансия
                                  Text(
                                    vacancy.title,
                                    style: textStyles.heading2,
                                  ),
                                  const SizedBox(height: 4),

                                  // Организация
                                  Text(
                                    vacancy.organization.name,
                                    style: textStyles.secondaryText,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
            error: (message) => Center(
              child: SizedBox(
                width: 400,
                child: ErrorContainer(message: message),
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.'
        '${date.month.toString().padLeft(2, '0')}.'
        '${date.year}';
  }
}

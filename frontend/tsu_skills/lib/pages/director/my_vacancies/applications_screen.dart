import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsu_skills/app/di/di.dart';
import 'package:tsu_skills/entities/skill/index.dart';
import 'package:tsu_skills/features/applications_on_vacancy/bloc/application_on_vacancy_bloc.dart';
import 'package:tsu_skills/shared/lib/ui/theme/text_styles.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/loading/expanded_circular_progress_indicator.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/other/error_placeholder.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/other/info_card.dart';

@RoutePage()
class ApplicationsScreen extends StatelessWidget {
  const ApplicationsScreen(this.vacancyId, {super.key});
  final String vacancyId;

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).extension<AppTextStylesExtension>()!;
    return BlocProvider(
      create: (_) => getIt<ApplicationOnVacancyBloc>(param1: vacancyId),
      child: Scaffold(
        appBar: AppBar(title: Text('Отклики')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child:
              BlocBuilder<ApplicationOnVacancyBloc, ApplicationOnVacancyState>(
                builder: (context, state) {
                  return state.when(
                    loading: () => CircularProgressIndicatorPlaceholder(),
                    error: (message) => ErrorPlaceholder(message),
                    load: (entities) {
                      return SizedBox(
                        width: 700,
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            final resume = entities[index].resume;
                            return ApplicationCard(
                              fullName: resume.user?.username ?? 'Ошибка',
                              photoUrl: resume.user?.userPhotoUrl,
                              skills: resume.skills,
                              aboutMe: resume.aboutMe,
                              description: resume.description,
                              telegramRef: resume.user?.telegramRef,
                              vkRef: resume.user?.vkRef,
                              phone: resume.user?.phone,
                            );
                          },
                          separatorBuilder: (_, __) => Padding(
                            padding: EdgeInsetsGeometry.all(16),
                            child: Divider(),
                          ),
                          itemCount: entities.length,
                        ),
                      );
                    },
                  );
                },
              ),
        ),
      ),
    );
  }
}

class ApplicationCard extends StatelessWidget {
  final String fullName;
  final String? photoUrl;
  final String? aboutMe;
  final String? description;
  final List<SkillEntity> skills;
  final String? vkRef;
  final String? telegramRef;
  final String? phone;

  const ApplicationCard({
    super.key,
    required this.fullName,
    required this.skills,
    this.photoUrl,
    this.aboutMe,
    this.description,
    this.vkRef,
    this.telegramRef,
    this.phone,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).extension<AppTextStylesExtension>()!;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 👤 Основная информация о пользователе
        InfoCard(
          icon: Icons.person_outline,
          title: 'Соискатель',
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Фото пользователя
              CircleAvatar(
                radius: 32,
                backgroundImage: (photoUrl != null && photoUrl!.isNotEmpty)
                    ? NetworkImage(photoUrl!)
                    : null,
                backgroundColor: Colors.grey.shade300,
                child: (photoUrl == null || photoUrl!.isEmpty)
                    ? Icon(Icons.person, size: 32, color: Colors.grey.shade600)
                    : null,
              ),
              const SizedBox(width: 16),
              // ФИО и соцсети
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(fullName, style: textStyles.heading2),
                    const SizedBox(height: 8),
                    if (vkRef != null || telegramRef != null)
                      Row(
                        children: [
                          if (vkRef != null) ...[
                            Icon(
                              Icons.link,
                              size: 16,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                vkRef!,
                                style: textStyles.accentText.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                          if (telegramRef != null) ...[
                            Icon(
                              Icons.telegram,
                              size: 16,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                telegramRef!,
                                style: textStyles.accentText.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],

                          if (phone != null) ...[
                            Icon(
                              Icons.phone,
                              size: 16,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                phone!,
                                style: textStyles.accentText.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        //О себе
        if (aboutMe != null && aboutMe!.isNotEmpty) ...[
          InfoCard(
            icon: Icons.info_outline,
            title: 'О себе',
            child: Text(aboutMe!, style: textStyles.bodyText),
          ),
          const SizedBox(height: 16),
        ],

        //Опыт
        if (description != null && description!.isNotEmpty) ...[
          InfoCard(
            icon: Icons.description_outlined,
            title: 'Опыт',
            child: Text(description!, style: textStyles.bodyText),
          ),
          const SizedBox(height: 16),
        ],

        // Навыки
        if (skills.isNotEmpty)
          InfoCard(
            icon: Icons.star_outline,
            title: 'Ключевые навыки',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: skills.map((skill) {
                return Chip(
                  label: Text(
                    skill.name,
                    style: textStyles.secondaryText.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: colorScheme.primary,
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}

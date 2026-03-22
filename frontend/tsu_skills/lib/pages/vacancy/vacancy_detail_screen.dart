import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsu_skills/app/di/di.dart';
import 'package:tsu_skills/app/router/app_router.dart';
import 'package:tsu_skills/entities/skill/ui/skill_chip.dart';
import 'package:tsu_skills/features/auth/ui/widgets.dart';
import 'package:tsu_skills/features/vacancy_detail/index.dart';
import 'package:tsu_skills/shared/lib/ui/theme/text_styles.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/loading/expanded_circular_progress_indicator.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/other/info_card.dart';

@RoutePage()
class VacancyDetailScreen extends StatelessWidget {
  const VacancyDetailScreen(this.vacancyId, {super.key, this.userMod = false});
  final bool userMod;
  final String vacancyId;

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).extension<AppTextStylesExtension>()!;
    final router = AutoRouter.of(context);

    return BlocProvider(
      create: (context) => getIt<VacancyDetailBloc>(param1: vacancyId),
      child: Scaffold(
        appBar: AppBar(title: Text("Вакансия")),
        body: LayoutBuilder(
          builder: (context, constraints) {
            // 🔹 Определяем максимальную ширину контента
            double maxContentWidth = constraints.maxWidth;
            if (maxContentWidth > 1000) {
              maxContentWidth = 700;
            } else if (maxContentWidth > 600) {
              maxContentWidth = 600;
            } // на телефоне просто занимает всю ширину

            return BlocBuilder<VacancyDetailBloc, VacancyDetailState>(
              builder: (context, state) {
                return state.map(
                  loading: (d) => CircularProgressIndicatorPlaceholder(),
                  error: (d) => Center(
                    child: SizedBox(
                      width: 400,
                      child: ErrorContainer(message: d.message),
                    ),
                  ),
                  loaded: (d) => Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxContentWidth),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // --- Шапка ---
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 32,
                                  backgroundColor: Colors.blue.withOpacity(0.1),
                                  child: const Icon(
                                    Icons.business,
                                    size: 32,
                                    color: Colors.blue,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        d.vacancy.title,
                                        style: textStyles.heading1,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        d.vacancy.organization.name,
                                        style: textStyles.secondaryText,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // --- Организация ---
                            InfoCard(
                              icon: Icons.info_outline,
                              title: "О нас",
                              child: Text(
                                d.vacancy.organization.aboutUs ?? 'Отсутствует',
                                style: textStyles.bodyText,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // --- Описание ---
                            InfoCard(
                              icon: Icons.description_outlined,
                              title: "Описание",
                              child: Text(
                                d.vacancy.description,
                                style: textStyles.bodyText,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // --- Навыки ---
                            InfoCard(
                              icon: Icons.star_border,
                              title: "Навыки",
                              child: Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: d.vacancy.skills
                                    .map(
                                      (skill) => SkillChip(
                                        label: skill.name,
                                        textStyle: textStyles.accentText,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            const SizedBox(height: 32),

                            // --- Кнопка ---
                            if (userMod)
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    router.push<bool>(
                                      CreateApplicationRoute(
                                        vacancyId: vacancyId,
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.send),
                                  label: const Text("Откликнуться"),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

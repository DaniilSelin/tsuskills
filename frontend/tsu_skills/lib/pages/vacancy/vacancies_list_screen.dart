import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsu_skills/app/di/di.dart';
import 'package:tsu_skills/app/router/app_router.dart';
import 'package:tsu_skills/entities/skill/index.dart';
import 'package:tsu_skills/features/auth/ui/error_container.dart';
import 'package:tsu_skills/features/search_vacancies/bloc/search_vacancies_bloc.dart';
import 'package:tsu_skills/features/search_vacancies/ui/search_vacancies_bottom_drawer.dart';
import 'package:tsu_skills/shared/assets/assets.gen.dart';
import 'package:tsu_skills/shared/lib/ui/theme/text_styles.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/loading/expanded_circular_progress_indicator.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/other/header_image.dart';

@RoutePage()
class VacanciesListScreen extends StatelessWidget {
  const VacanciesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).extension<AppTextStylesExtension>()!;
    final router = AutoRouter.of(context);

    return BlocProvider(
      create: (_) => getIt<SearchVacanciesBloc>(),
      child: Builder(
        builder: (context) {
          final bloc = BlocProvider.of<SearchVacanciesBloc>(context);
          return Scaffold(
            body: BlocBuilder<SearchVacanciesBloc, SearchVacanciesState>(
              builder: (context, state) {
                return state.map(
                  initial: (_) => const SizedBox.shrink(),

                  loading: (_) => const CircularProgressIndicatorPlaceholder(),

                  error: (errorState) =>
                      ErrorContainer(message: errorState.message),

                  loaded: (loadedState) {
                    final vacancies = loadedState.vacancies;

                    if (vacancies.isEmpty) {
                      return Center(
                        child: Text(
                          'Нет вакансий по выбранным критериям',
                          style: textStyles.secondaryText,
                        ),
                      );
                    }

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          HeaderImage(
                            imgProvider:
                                Assets.image.girlAndDashboard380380.keyName,
                            title: 'Вакансии',
                          ),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(16),
                            itemCount: vacancies.length,
                            itemBuilder: (context, index) {
                              final vacancy = vacancies[index];

                              return InkWell(
                                onTap: () => router.push(
                                  VacancyDetailRoute(
                                    vacancyId: vacancies[index].objectId,
                                    userMod: true,
                                  ),
                                ),
                                child: Card(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          vacancy.title,
                                          style: textStyles.heading1,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Организация: ${vacancy.organization.name}',
                                          style: textStyles.secondaryText,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          vacancy.description.isNotEmpty
                                              ? vacancy.description
                                              : 'Описание отсутствует',
                                          style: textStyles.bodyText,
                                        ),
                                        const SizedBox(height: 12),
                                        Wrap(
                                          spacing: 6,
                                          children: vacancy.skills
                                              .map(
                                                (s) => SkillChip(
                                                  label: s.name,
                                                  textStyle:
                                                      textStyles.accentText,
                                                ),
                                              )
                                              .toList(),
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
                );
              },
            ),
            floatingActionButton:
                BlocBuilder<SearchVacanciesBloc, SearchVacanciesState>(
                  builder: (context, state) {
                    return state.mapOrNull(
                          loaded: (d) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FloatingActionButton(
                                  child: const Icon(Icons.search),
                                  onPressed: () async {
                                    final filter =
                                        await CreateFilterBottomDrawer(
                                          context,
                                        )();

                                    if (filter != null && context.mounted) {
                                      bloc.add(
                                        SearchVacanciesEvent.search(
                                          name: filter.name,
                                          skillIds: filter.skills
                                              ?.map((s) => s.id)
                                              .toList(),
                                        ),
                                      );
                                    }
                                  },
                                ),

                                if (!d.isEmptyFilter) ...[
                                  SizedBox(width: 8),
                                  FloatingActionButton(
                                    backgroundColor: Colors.redAccent,
                                    child: const Icon(Icons.close),
                                    onPressed: () {
                                      bloc.add(SearchVacanciesEvent.search());
                                    },
                                  ),
                                ],
                              ],
                            );
                          },
                        ) ??
                        SizedBox();
                  },
                ),
          );
        },
      ),
    );
  }
}

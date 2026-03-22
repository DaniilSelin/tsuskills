import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsu_skills/app/di/di.dart';
import 'package:tsu_skills/app/router/app_router.dart';
import 'package:tsu_skills/features/auth/ui/error_container.dart';
import 'package:tsu_skills/features/my_vacancies/index.dart';
import 'package:tsu_skills/shared/assets/assets.gen.dart';
import 'package:tsu_skills/shared/lib/ui/theme/text_styles.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/other/header_image.dart';

@RoutePage()
class MyVacanciesScreen extends StatefulWidget {
  const MyVacanciesScreen({super.key});

  @override
  State<MyVacanciesScreen> createState() => _MyVacanciesScreenState();
}

class _MyVacanciesScreenState extends State<MyVacanciesScreen> {
  late final DeleteVacancyAlertDialog deleteAlertDialog;

  @override
  void initState() {
    deleteAlertDialog = DeleteVacancyAlertDialog(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).extension<AppTextStylesExtension>()!;
    final colorScheme = Theme.of(context).colorScheme;
    final router = AutoRouter.of(context);

    return BlocProvider(
      create: (context) => getIt<MyVacanciesBloc>(),
      child: Builder(
        builder: (context) {
          final bloc = BlocProvider.of<MyVacanciesBloc>(context);
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                final result = await router.push<bool>(CreateVacancyRoute());

                if (result != null && result && context.mounted) {
                  bloc.add(MyVacanciesEvent.fetchVacancies());
                }
              },
              child: const Icon(Icons.add),
            ),
            body: BlocBuilder<MyVacanciesBloc, MyVacanciesState>(
              builder: (context, state) {
                return state.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (message) => Center(
                    child: SizedBox(
                      width: 400,
                      child: ErrorContainer(message: message),
                    ),
                  ),
                  loaded: (vacancies) {
                    if (vacancies.isEmpty) {
                      return Center(
                        child: Text(
                          'Вы еще не создали ни одной вакансии',
                          style: textStyles.secondaryText,
                        ),
                      );
                    }

                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          HeaderImage(
                            imgProvider:
                                Assets.image.manCreateVacancy380380.keyName,
                            title: 'Мои вакансии',
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(16),
                            itemCount: vacancies.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final vacancy = vacancies[index];

                              return Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: InkWell(
                                  onTap: () {
                                    router.push(
                                      VacancyDetailRoute(
                                        vacancyId: vacancy.objectId,
                                        userMod: false,
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                vacancy.title,
                                                style: textStyles.heading2,
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                vacancy.description,
                                                style: textStyles.bodyText,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                _formatDate(vacancy.createdAt),
                                                style: textStyles.secondaryText,
                                              ),
                                            ],
                                          ),
                                        ),

                                        const SizedBox(width: 8),

                                        // Кнопки действий
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              tooltip: 'Отклики',
                                              icon: const Icon(
                                                Icons.people_outline,
                                              ),
                                              color: colorScheme.primary,
                                              onPressed: () {
                                                router.push(
                                                  ApplicationsRoute(
                                                    vacancyId: vacancies[index]
                                                        .objectId,
                                                  ),
                                                );
                                              },
                                            ),
                                            IconButton(
                                              tooltip: 'Удалить',
                                              icon: const Icon(
                                                Icons.delete_outline,
                                              ),
                                              color: colorScheme.error,
                                              onPressed: () async {
                                                final result =
                                                    await deleteAlertDialog();

                                                if (result != null && result) {}
                                              },
                                            ),
                                          ],
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

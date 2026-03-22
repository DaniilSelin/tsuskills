import 'package:auto_route/auto_route.dart';
import 'package:flutter/src/material/theme_data.dart';
import 'package:tsu_skills/app/router/app_router.dart';
import 'package:tsu_skills/shared/lib/ui/theme/director_theme.dart';
import 'app_strategy.dart';

class OrganizatorStrategy implements AppStrategy {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: '/director-home/',
      initial: true,
      page: DirectorHomeRoute.page,
      children: [
        AutoRoute(
          path: 'my-vacancies-tab',
          page: MyVacanciesTabRoute.page,
          initial: true,
          children: [
            AutoRoute(
              initial: true,
              path: 'my-vacancies',
              page: MyVacanciesRoute.page,
            ),
            AutoRoute(path: 'create-vacancy', page: CreateVacancyRoute.page),
            AutoRoute(path: 'vacancy-detail', page: VacancyDetailRoute.page),
            AutoRoute(
              path: 'vacancy-applications',
              page: ApplicationsRoute.page,
            ),
          ],
        ),
        AutoRoute(
          path: 'my-organization-tab',
          page: MyOrganizationTabRoute.page,
          children: [
            AutoRoute(
              initial: true,
              path: 'my-organization',
              page: MyOrganizationRoute.page,
            ),
            AutoRoute(
              path: 'update-my-organization',
              page: UpdateOrganizationRoute.page,
            ),
          ],
        ),
        AutoRoute(
          path: 'user-profile/',
          page: ProfileTabRoute.page,
          children: [
            AutoRoute(path: 'profile/', page: ProfileRoute.page, initial: true),
            AutoRoute(path: 'edit-profile/', page: EditProfileRoute.page),
          ],
        ),
      ],
    ),
  ];

  @override
  ThemeData get themeData => directorAppTheme;
}

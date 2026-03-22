import 'package:auto_route/auto_route.dart';
import 'package:flutter/src/material/theme_data.dart';
import 'package:tsu_skills/app/router/app_router.dart';
import 'package:tsu_skills/shared/lib/ui/theme/base_theme.dart';
import 'app_strategy.dart';

class UserStrategy implements AppStrategy {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: '/home/',
      page: HomeRoute.page,
      initial: true,
      children: [
        AutoRoute(
          path: 'vacancies/',
          page: VacanciesTabRoute.page,
          initial: true,
          children: [
            AutoRoute(
              path: 'vacancies-list/',
              page: VacanciesListRoute.page,
              initial: true,
            ),
            AutoRoute(path: 'vacancy/', page: VacancyDetailRoute.page),
            AutoRoute(
              path: 'create-application/',
              page: CreateApplicationRoute.page,
            ),
          ],
        ),
        AutoRoute(
          path: 'responses/',
          page: ResponsesTabRoute.page,
          children: [
            AutoRoute(
              initial: true,
              path: 'my-applications/',
              page: MyApplicationsRoute.page,
            ),
            AutoRoute(path: 'vacancy/', page: VacancyDetailRoute.page),
          ],
        ),
        AutoRoute(
          path: 'resumes/',
          page: ResumeTabRoute.page,
          children: [
            AutoRoute(
              path: 'my-resumes/',
              page: UserResumesRoute.page,
              initial: true,
            ),
            AutoRoute(path: 'resume', page: ResumeDetailRoute.page),
            AutoRoute(path: 'edit-resume', page: EditResumeRoute.page),
            AutoRoute(path: 'create-resume', page: CreateResumeRoute.page),
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
  ThemeData get themeData => baseAppTheme;
}

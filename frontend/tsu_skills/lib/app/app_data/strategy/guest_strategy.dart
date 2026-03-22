import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tsu_skills/app/router/app_router.dart';
import 'package:tsu_skills/shared/lib/ui/theme/base_theme.dart';

import 'app_strategy.dart';

class GuestStrategy implements AppStrategy {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: '/info-page',page: LandingRoute.page, initial: kIsWeb ),
    AutoRoute(path: '/login', page: LoginRoute.page, initial: !kIsWeb),
    AutoRoute(path: '/new_user', page: SignUpRoute.page),
    AutoRoute(path: '/forgot_password', page: ForgotPasswordRoute.page),
  ];

  @override
  ThemeData get themeData => baseAppTheme;
}

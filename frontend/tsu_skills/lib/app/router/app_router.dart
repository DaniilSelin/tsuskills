import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:tsu_skills/app/app_data/strategy/app_strategy.dart';
import 'package:tsu_skills/pages/pages.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter(this._strategy);
  final AppStrategy _strategy;

  @override
  List<AutoRoute> get routes => _strategy.routes;
}

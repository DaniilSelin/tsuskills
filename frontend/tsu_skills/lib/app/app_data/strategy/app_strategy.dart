import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tsu_skills/app/app_data/strategy/director_strategy.dart';
import 'package:tsu_skills/app/app_data/strategy/guest_strategy.dart';
import 'package:tsu_skills/app/app_data/strategy/user_strategy.dart';
import 'package:tsu_skills/entities/user_role/model/role_enum.dart';

abstract class AppStrategy {
  List<AutoRoute> get routes;
  ThemeData get themeData;

  factory AppStrategy(RoleEnum role) {
    switch (role) {
      case RoleEnum.user:
        return UserStrategy();
      case RoleEnum.organizator:
        return OrganizatorStrategy();
      case RoleEnum.guest:
        return GuestStrategy();
    }
  }
}

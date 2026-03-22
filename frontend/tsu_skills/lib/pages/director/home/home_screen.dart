import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tsu_skills/app/router/app_router.dart';

@RoutePage()
class DirectorHomeScreen extends StatelessWidget {
  const DirectorHomeScreen({super.key});

  static const buttons = {
    'Мои вакансии': Icons.description,
    'Моя организация': Icons.business,
    'Профиль': Icons.person,
  };

  static const tabs = [
    MyVacanciesTabRoute(),
    MyOrganizationTabRoute(),
    ProfileTabRoute(),
  ];

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: tabs,
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        final isLargeScreen = MediaQuery.of(context).size.width >= 600;

        if (isLargeScreen) {
          return Row(
            children: [
              NavigationRail(
                selectedIndex: tabsRouter.activeIndex,
                onDestinationSelected: tabsRouter.setActiveIndex,
                labelType: NavigationRailLabelType.all,
                destinations: buttons.entries.map((entry) {
                  return NavigationRailDestination(
                    icon: Icon(entry.value),
                    label: Text(entry.key),
                  );
                }).toList(),
              ),
              Expanded(child: child),
            ],
          );
        } else {
          return Scaffold(
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              onTap: tabsRouter.setActiveIndex,
              currentIndex: tabsRouter.activeIndex,
              items: buttons.entries.map((entry) {
                return BottomNavigationBarItem(
                  label: entry.key,
                  icon: Icon(entry.value),
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsu_skills/app/di/di.dart';
import 'package:tsu_skills/app/router/app_router.dart';
import 'package:tsu_skills/features/my_application/index.dart' show MyApplicationBloc;


@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MyApplicationBloc>(),
      child: AutoTabsRouter(
        routes: const [
          VacanciesTabRoute(),
          ResponsesTabRoute(),
          ResumeTabRoute(),
          ProfileTabRoute(),
        ],
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);
          final isLargeScreen = MediaQuery.of(context).size.width >= 600;

          // Если экран широкий, строим боковое меню
          if (isLargeScreen) {
            return Row(
              children: [
                // 1. Боковая навигационная панель (Sidebar)
                NavigationRail(
                  selectedIndex: tabsRouter.activeIndex,
                  onDestinationSelected: tabsRouter.setActiveIndex,
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.search),
                      label: Text('Вакансии'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.mail),
                      label: Text('Отклики'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.description),
                      label: Text('Резюме'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person),
                      label: Text('Профиль'),
                    ),
                  ],
                ),
                // 2. Основное содержимое вкладок
                Expanded(child: child),
              ],
            );
          } else {
            // Если экран узкий (мобильный), строим обычный Scaffold с Bottom Bar
            return Scaffold(
              body: child,
              bottomNavigationBar: BottomNavigationBar(
                onTap: tabsRouter.setActiveIndex,
                currentIndex: tabsRouter.activeIndex,
                items: const [
                  BottomNavigationBarItem(
                    label: 'Вакансии',
                    icon: Icon(Icons.search),
                  ),
                  BottomNavigationBarItem(
                    label: 'Отклики',
                    icon: Icon(Icons.mail),
                  ),
                  BottomNavigationBarItem(
                    label: 'Резюме',
                    icon: Icon(Icons.description),
                  ),
                  BottomNavigationBarItem(
                    label: 'Профиль',
                    icon: Icon(Icons.person),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsu_skills/app/di/di.dart';
import 'package:tsu_skills/app/router/app_router.dart';
import 'package:tsu_skills/features/auth/index.dart';
import 'package:tsu_skills/features/my_organization/index.dart';
import 'package:tsu_skills/shared/assets/assets.gen.dart';
import 'package:tsu_skills/shared/lib/ui/theme/text_styles.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/loading/expanded_circular_progress_indicator.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/other/error_placeholder.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/other/header_image.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/other/info_card.dart';

@RoutePage()
class MyOrganizationScreen extends StatelessWidget {
  const MyOrganizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    final textStyles = Theme.of(context).extension<AppTextStylesExtension>()!;
    return BlocProvider(
      create: (context) => getIt<MyOrganizationBloc>(),
      child: Builder(
        builder: (context) {
          final bloc = BlocProvider.of<MyOrganizationBloc>(context);
          return BlocBuilder<MyOrganizationBloc, MyOrganizationState>(
            builder: (context, state) {
              return state.when(
                error: (message) => Scaffold(body: ErrorPlaceholder(message)),
                loading: () => Scaffold(
                  body: const CircularProgressIndicatorPlaceholder(),
                ),
                loaded: (organization) {
                  return Scaffold(
                    floatingActionButton: FloatingActionButton(
                      onPressed: () async {
                        final result = await router.push<bool>(
                          UpdateOrganizationRoute(),
                        );
                        if (result != null && result) {
                          bloc.add(MyOrganizationEvent.fetchOrganization());
                        }
                      },
                      child: Icon(Icons.edit),
                    ),
                    body: Center(
                      child: SizedBox(
                        width: 700,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              HeaderImage(
                                imgProvider:
                                    Assets.image.manBuild380380.keyName,
                                title: 'Моя организация',
                              ),
                              // 🏢 Информация об организации
                              InfoCard(
                                icon: Icons.apartment,
                                title: 'Информация об организации',
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      organization.name,
                                      style: textStyles.heading2,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      organization.aboutUs ??
                                          'Описание отсутствует',
                                      style: textStyles.bodyText,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsu_skills/app/di/di.dart';
import 'package:tsu_skills/entities/organization/ui/organization_form.dart';
import 'package:tsu_skills/features/update_organization/index.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/loading/expanded_circular_progress_indicator.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/other/error_placeholder.dart';

@RoutePage()
class UpdateOrganizationScreen extends StatelessWidget {
  const UpdateOrganizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);

    return BlocProvider(
      create: (context) => getIt<UpdateOrganizationBloc>(),
      child: BlocListener<UpdateOrganizationBloc, UpdateOrganizationState>(
        listener: (context, state) {
          state.whenOrNull(
            saved: () {
              router.pop(true);
            },
          );
        },
        child: Builder(
          builder: (context) {
            final bloc = BlocProvider.of<UpdateOrganizationBloc>(context);
            return Scaffold(
              appBar: AppBar(title: const Text('Обновление организации')),
              body:
                  BlocBuilder<UpdateOrganizationBloc, UpdateOrganizationState>(
                    builder: (context, state) {
                      return state.when(
                        loading: () => CircularProgressIndicatorPlaceholder(),
                        saved: () => SizedBox(),
                        error: (message) => ErrorPlaceholder(message),
                        loaded: (entity) => Center(
                          child: SizedBox(
                            width: 600,
                            child: OrganizationForm(
                              onSave: (name, aboutUs) {
                                bloc.add(
                                  UpdateOrganizationEvent.saveOrganization(
                                    name: name,
                                    aboutUs: aboutUs,
                                  ),
                                );
                              },
                              saveButtonText: 'Сохранить',
                              name: entity.name,
                              aboutUs: entity.aboutUs,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
            );
          },
        ),
      ),
    );
  }
}

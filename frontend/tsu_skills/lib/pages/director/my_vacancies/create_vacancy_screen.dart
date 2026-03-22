import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsu_skills/app/di/di.dart';
import 'package:tsu_skills/features/create_vacancy/index.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/other/error_placeholder.dart';

@RoutePage()
class CreateVacancyScreen extends StatelessWidget {
  const CreateVacancyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);

    return BlocProvider(
      create: (context) => getIt<CreateVacancyBloc>(),
      child: BlocListener<CreateVacancyBloc, CreateVacancyState>(
        listener: (context, state) {
          state.mapOrNull(saved: (d) => router.pop(true));
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Создание вакансии'),
          ),
          body: BlocBuilder<CreateVacancyBloc, CreateVacancyState>(
            builder: (context, state) {
              final bloc = BlocProvider.of<CreateVacancyBloc>(context);

              return LayoutBuilder(
                builder: (context, constraints) {
                  // Определяем максимально допустимую ширину формы
                  double maxWidth;

                  if (constraints.maxWidth < 600) {
                    // Мобильный экран — форма на всю ширину
                    maxWidth = constraints.maxWidth * 0.8;
                  } else if (constraints.maxWidth < 1200) {
                    // Планшет
                    maxWidth = 600;
                  } else {
                    // Desktop
                    maxWidth = 800;
                  }

                  Widget content = Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 24,
                        ),
                        child: VacancyForm(
                          onSave: (name, description, skills) => bloc.add(
                            CreateVacancyEvent.createVacancy(
                              title: name,
                              description: description,
                              skills: skills,
                            ),
                          ),
                          saveButtonText: 'Опубликовать',
                        ),
                      ),
                    ),
                  );

                  return state.when(
                    initial: () => content,
                    saved: () => const SizedBox(),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (message) =>
                        Center(child: ErrorPlaceholder(message)),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

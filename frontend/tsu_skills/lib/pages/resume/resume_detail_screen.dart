import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsu_skills/app/di/di.dart';
import 'package:tsu_skills/app/router/app_router.dart';
import 'package:tsu_skills/features/auth/ui/error_container.dart';
import 'package:tsu_skills/features/my_resumes/index.dart';
import 'package:tsu_skills/shared/assets/assets.gen.dart';
import 'package:tsu_skills/shared/lib/ui/theme/text_styles.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/loading/expanded_circular_progress_indicator.dart';
import 'package:tsu_skills/entities/skill/ui/skill_chip.dart';

@RoutePage()
class ResumeDetailScreen extends StatefulWidget {
  const ResumeDetailScreen({super.key, required this.resumeId});
  final String resumeId;

  @override
  State<ResumeDetailScreen> createState() => _ResumeDetailScreenState();
}

class _ResumeDetailScreenState extends State<ResumeDetailScreen> {
  void _onDelete(BuildContext context) {
    print('Запрос на удаление');
    // Здесь обычно появляется диалоговое окно подтверждения
  }

  bool _isUpdated = false;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).extension<AppTextStylesExtension>();
    final router = AutoRouter.of(context);

    if (textStyles == null) {
      return const Center(
        child: Text('Ошибка: AppTextStylesExtension не найден.'),
      );
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          context.router.pop(_isUpdated);
        }
      },
      child: BlocProvider(
        create: (context) => getIt<ResumeDetailBloc>(param1: widget.resumeId),
        child: BlocListener<ResumeDetailBloc, ResumeDetailState>(
          listener: (context, state) {
            _isLoading = state.mapOrNull(loading: (d) => true) ?? false;

            state.mapOrNull(
              deleted: (d) {
                router.pop<bool>(true);
              },
            );
          },
          child: Scaffold(
            appBar: AppBar(title: const Text('Резюме')),
            body: BlocBuilder<ResumeDetailBloc, ResumeDetailState>(
              builder: (context, state) {
                return state.map(
                  loading: (d) => CircularProgressIndicatorPlaceholder(),
                  error: (d) => ErrorContainer(message: d.message),
                  deleted: (d) => Center(
                    child: Image.asset(Assets.image.deletedResume.keyName),
                  ),
                  loaded: (d) => Center(
                    child: SizedBox(
                      width: 600,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // --- Секция 1: Заголовок и Профессия ---
                            Text(
                              'Название',
                              style: textStyles.secondaryText.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(d.resume.name, style: textStyles.heading1),

                            const SizedBox(height: 24.0),

                            // --- Секция 2: О себе ---
                            Text(
                              'О себе',
                              style: textStyles.secondaryText.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Text(
                                // Полное описание
                                d.resume.aboutMe,
                                style: textStyles.bodyText,
                              ),
                            ),

                            const SizedBox(height: 24.0),

                            // --- Секция 2: Полное описание ---
                            Text(
                              'Опыт',
                              style: textStyles.secondaryText.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Text(
                                // Полное описание
                                d.resume.description,
                                style: textStyles.bodyText,
                              ),
                            ),

                            const SizedBox(height: 24.0),

                            // --- Секция 3: Навыки ---
                            Text(
                              'Ключевые навыки',
                              style: textStyles.secondaryText.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Wrap(
                              spacing: 8.0,
                              runSpacing: 8.0,
                              children: d.resume.skills
                                  .map(
                                    (skill) => SkillChip(
                                      label: skill.name,
                                      textStyle: textStyles.accentText,
                                    ),
                                  )
                                  .toList(),
                            ),

                            // Дополнительное место внизу для отступа
                            const SizedBox(height: 40.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            floatingActionButton: Builder(
              builder: (context) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    child: Icon(Icons.edit),
                    onPressed: () async {
                      if (_isLoading) return;

                      final result = await router.push<bool>(
                        EditResumeRoute(resumeId: widget.resumeId),
                      );

                      if (result != null && result && context.mounted) {
                        _isUpdated = true;
                        BlocProvider.of<ResumeDetailBloc>(
                          context,
                        ).add(ResumeDetailEvent.fetchResume());
                      }
                    },
                  ),
                  SizedBox(width: 8),
                  FloatingActionButton(
                    backgroundColor: Colors.redAccent,
                    onPressed: () async {
                      if (_isLoading) return;

                      BlocProvider.of<ResumeDetailBloc>(
                        context,
                      ).add(ResumeDetailEvent.deleteResume());
                    },
                    child: Icon(Icons.delete_forever, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

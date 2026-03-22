import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsu_skills/app/di/di.dart';
import 'package:tsu_skills/entities/resume/index.dart';
import 'package:tsu_skills/features/auth/ui/error_container.dart';
import 'package:tsu_skills/features/create_application/index.dart';
import 'package:tsu_skills/features/my_application/index.dart';
import 'package:tsu_skills/shared/assets/assets.gen.dart';
import 'package:tsu_skills/shared/lib/ui/theme/text_styles.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/loading/expanded_circular_progress_indicator.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/other/header_image.dart';
import 'package:choice/choice.dart';

@RoutePage()
class CreateApplicationScreen extends StatefulWidget {
  const CreateApplicationScreen({super.key, required this.vacancyId});
  final String vacancyId;

  @override
  State<CreateApplicationScreen> createState() =>
      _CreateApplicationScreenState();
}

class _CreateApplicationScreenState extends State<CreateApplicationScreen> {
  ResumeEntity? selectedResume;

  void _setSelectedValue(ResumeEntity? resume) {
    setState(() => selectedResume = resume);
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).extension<AppTextStylesExtension>()!;
    final router = AutoRouter.of(context);

    return BlocProvider(
      create: (context) =>
          getIt<CreateApplicationBloc>(param1: widget.vacancyId),
      child: Scaffold(
        appBar: AppBar(title: const Text('Отклик')),
        body: BlocBuilder<CreateApplicationBloc, CreateApplicationState>(
          builder: (context, state) {
            return state.when(
              loading: () => CircularProgressIndicatorPlaceholder(),
              error: (message) => Center(
                child: SizedBox(
                  width: 400,
                  child: ErrorContainer(message: message),
                ),
              ),
              createdApplication: (newApplication) {
                BlocProvider.of<MyApplicationBloc>(
                  context,
                ).add(MyApplicationEvent.addApplication(newApplication));

                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HeaderImage(
                        imgProvider:
                            Assets.image.girlSendApplication380380.keyName,
                        title: 'Резюме отправлено!',
                      ),
                      ElevatedButton(
                        onPressed: () => router.pop(),
                        child: Text('Назад'),
                      ),
                    ],
                  ),
                );
              },
              loaded: (resumes) {
                if (resumes.isEmpty) {
                  return Center(
                    child: HeaderImage(
                      imgProvider: Assets.image.girlQuestion380380.keyName,
                      title: 'У вас нет резюме, которым можно откликнуться!',
                    ),
                  );
                }

                return LayoutBuilder(
                  builder: (context, constraints) {
                    double maxContentWidth = constraints.maxWidth;

                    if (maxContentWidth > 1000) {
                      maxContentWidth = 600;
                    } else if (maxContentWidth > 600) {
                      maxContentWidth = 500;
                    }

                    return Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: maxContentWidth),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Выберите резюме, которое хотите отправить',
                              style: textStyles.secondaryText,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            InlineChoice<ResumeEntity>.single(
                              value: selectedResume,
                              onChanged: _setSelectedValue,
                              itemCount: resumes.length,
                              itemBuilder: (state, i) {
                                return ChoiceChip(
                                  selected: state.selected(resumes[i]),
                                  onSelected: state.onSelected(resumes[i]),
                                  label: Text(
                                    resumes[i].name,
                                    style: textStyles.bodyText,
                                  ),
                                );
                              },
                              listBuilder: ChoiceList.createScrollable(
                                spacing: 10,
                                runSpacing: 10,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 25,
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsetsGeometry.only(
                                top: 8,
                                bottom: 16,
                              ),
                              child: Divider(),
                            ),

                            if (selectedResume != null)
                              ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<CreateApplicationBloc>(
                                    context,
                                  ).add(
                                    CreateApplicationEvent.createApplication(
                                      selectedResume!.id,
                                    ),
                                  );
                                },
                                child: Text('Отправить'),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class ChoiceResumeList extends StatefulWidget {
  const ChoiceResumeList({super.key});

  @override
  State<ChoiceResumeList> createState() => _ChoiceResumeListState();
}

class _ChoiceResumeListState extends State<ChoiceResumeList> {
  ResumeEntity? selectedResume;

  void _setSelectedValue(ResumeEntity? resume) =>
      setState(() => selectedResume = resume);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(leading: Icon(Icons.check, color: Colors.green));
      },
    );
  }
}

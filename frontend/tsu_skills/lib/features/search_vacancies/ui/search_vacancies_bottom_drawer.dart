import 'package:flutter/material.dart';
import 'package:tsu_skills/entities/skill/index.dart';
import 'package:tsu_skills/entities/skill/ui/add_skills_widget.dart';
import 'package:tsu_skills/features/search_vacancies/bloc/vacancy_filter.dart';
import 'package:tsu_skills/shared/lib/ui/theme/text_styles.dart';

class CreateFilterBottomDrawer {
  CreateFilterBottomDrawer(this.context);
  final BuildContext context;

  Future<VacancyFilter?> call({
    String? initialName,
    List<SkillEntity>? initialSkills,
  }) async {
    final controller = TextEditingController(text: initialName ?? '');
    final skillsController = SkillsController([...?initialSkills]);

    return await showModalBottomSheet<VacancyFilter>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          top: 16,
        ),
        child: _BottomDrawerContent(
          nameController: controller,
          skillsController: skillsController,
        ),
      ),
    );
  }
}

class _BottomDrawerContent extends StatefulWidget {
  final TextEditingController nameController;
  final SkillsController skillsController;

  const _BottomDrawerContent({
    required this.nameController,
    required this.skillsController,
  });

  @override
  State<_BottomDrawerContent> createState() => _BottomDrawerContentState();
}

class _BottomDrawerContentState extends State<_BottomDrawerContent> {
  void _onApply() {
    final name = widget.nameController.text.trim();
    final filter = VacancyFilter(
      name: name.isEmpty ? null : name,
      skills: widget.skillsController.skills,
    );
    Navigator.of(context).pop(filter);
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).extension<AppTextStylesExtension>()!;
    final inputDecoration = Theme.of(context).inputDecorationTheme;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          Text('Фильтр вакансий', style: textStyles.heading1),

          const SizedBox(height: 16),

          Text('Название вакансии', style: textStyles.secondaryText),
          const SizedBox(height: 8),
          TextField(controller: widget.nameController),

          const SizedBox(height: 24),

          Text('Навыки', style: textStyles.secondaryText),
          const SizedBox(height: 8),
          AddSkillsWidget(skillsController: widget.skillsController),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _onApply,
              icon: const Icon(Icons.check),
              label: Text(
                'Применить фильтр',
                style: textStyles.bodyText.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tsu_skills/entities/skill/index.dart';
import 'package:tsu_skills/entities/skill/ui/add_skills_widget.dart';
import 'package:tsu_skills/shared/lib/ui/theme/text_styles.dart';

class VacancyForm extends StatefulWidget {
  const VacancyForm({
    super.key,
    required this.onSave,
    required this.saveButtonText,
    this.title,
    this.description,
    this.skills,
  });

  final void Function(
    String title,
    String description,
    List<SkillEntity> skills,
  ) onSave;

  final String saveButtonText;
  final String? title;
  final String? description;
  final List<SkillEntity>? skills;

  @override
  State<VacancyForm> createState() => _VacancyFormState();
}

class _VacancyFormState extends State<VacancyForm> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late SkillsController _skillsController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _descriptionController = TextEditingController(text: widget.description);
    _skillsController = SkillsController(widget.skills?.toList() ?? []);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).extension<AppTextStylesExtension>();
    
    if (textStyles == null) {
      return const Center(
        child: Text('Ошибка: AppTextStylesExtension не найден.'),
      );
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // --- Название вакансии ---
          Text(
            'Название вакансии',
            style: textStyles.secondaryText.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            controller: _titleController,
            style: textStyles.bodyText,
            decoration: InputDecoration(hintStyle: textStyles.hintText),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Пожалуйста, введите название вакансии';
              }
              return null;
            },
          ),
          const SizedBox(height: 24.0),

          // --- Описание вакансии ---
          Text(
            'Описание',
            style: textStyles.secondaryText.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            controller: _descriptionController,
            style: textStyles.bodyText,
            maxLines: 10,
            minLines: 5,
            decoration: InputDecoration(
              labelText: 'Подробное описание вакансии',
              alignLabelWithHint: true,
              hintStyle: textStyles.hintText,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Пожалуйста, заполните это поле';
              }
              return null;
            },
          ),
          const SizedBox(height: 24.0),

          // --- Ключевые навыки ---
          Text(
            'Ключевые навыки',
            style: textStyles.secondaryText.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          AddSkillsWidget(skillsController: _skillsController),
          const SizedBox(height: 40.0),

          // --- Кнопка сохранения ---
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.onSave(
                  _titleController.text,
                  _descriptionController.text,
                  _skillsController.skills,
                );
              }
            },
            child: Text(widget.saveButtonText),
          ),
        ],
      ),
    );
  }
}

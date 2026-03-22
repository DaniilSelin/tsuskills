import 'package:flutter/material.dart';
import 'package:tsu_skills/entities/skill/index.dart';
import 'package:tsu_skills/entities/skill/ui/add_skills_widget.dart';
import 'package:tsu_skills/shared/lib/ui/theme/text_styles.dart';

class ResumeForm extends StatefulWidget {
  const ResumeForm({
    super.key,
    required this.onSave,
    required this.saveButtonText,
    this.description,
    this.aboutMe,
    this.name,
    this.skills,
  });
  final void Function(
    String name,
    String aboutMe,
    String description,
    List<SkillEntity> skills,
  )
  onSave;
  final String saveButtonText;

  final String? description;
  final String? aboutMe;
  final String? name;
  final List<SkillEntity>? skills;

  @override
  State<ResumeForm> createState() => _ResumeFormState();
}

class _ResumeFormState extends State<ResumeForm> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _aboutMeController;
  late SkillsController _skillsController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _descriptionController = TextEditingController(text: widget.description);
    _aboutMeController = TextEditingController(text: widget.aboutMe);
    _skillsController = SkillsController(widget.skills?.toList() ?? []);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _aboutMeController.dispose();
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
          // --- Поле для заголовка (Название) ---
          Text(
            'Название резюме',
            style: textStyles.secondaryText.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            controller: _nameController,
            style: textStyles.bodyText,
            decoration: InputDecoration(hintStyle: textStyles.hintText),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Пожалуйста, введите название';
              }
              return null;
            },
          ),
          const SizedBox(height: 24.0),

          // --- Поле для полного описания ---
          Text(
            'О себе',
            style: textStyles.secondaryText.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            controller: _aboutMeController,
            style: textStyles.bodyText,
            maxLines: 10,
            minLines: 5,
            decoration: InputDecoration(
              labelText: 'Личные качества и цели',
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

          // --- Поле для полного описания ---
          Text(
            'Описание (опыт, обязанности)',
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
              labelText: 'Подробное описание вашего опыта работы',
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

          // --- Поле для навыков ---
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
                  _nameController.text,
                  _aboutMeController.text,
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

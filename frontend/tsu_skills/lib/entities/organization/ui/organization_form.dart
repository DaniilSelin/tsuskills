import 'package:flutter/material.dart';
import 'package:tsu_skills/shared/lib/ui/theme/text_styles.dart';

class OrganizationForm extends StatefulWidget {
  const OrganizationForm({
    super.key,
    required this.onSave,
    required this.saveButtonText,
    this.aboutUs,
    this.name,
  });
  final void Function(String name, String aboutMe) onSave;
  final String saveButtonText;

  final String? aboutUs;
  final String? name;

  @override
  State<OrganizationForm> createState() => _OrganizationFormState();
}

class _OrganizationFormState extends State<OrganizationForm> {
  late TextEditingController _nameController;
  late TextEditingController _aboutUsController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _aboutUsController = TextEditingController(text: widget.aboutUs);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _aboutUsController.dispose();
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
            'Название организации',
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
            controller: _aboutUsController,
            style: textStyles.bodyText,
            maxLines: 10,
            minLines: 5,
            decoration: InputDecoration(
              labelText: 'Описание вашей организации',
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
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.onSave(_nameController.text, _aboutUsController.text);
              }
            },
            child: Text(widget.saveButtonText),
          ),
        ],
      ),
    );
  }
}

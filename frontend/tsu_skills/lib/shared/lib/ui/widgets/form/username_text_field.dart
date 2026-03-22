import 'package:flutter/material.dart';
import 'package:tsu_skills/shared/lib/ui/theme/text_styles.dart';

class UsernameTextField extends StatelessWidget {
  const UsernameTextField(this._controller, {super.key});
  final TextEditingController _controller;

  String? _validateFio(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пожалуйста, введите ваше ФИО.';
    }
    final RegExp cyrillicRegExp = RegExp(r'^[а-яА-ЯёЁ\s-]+$');

    if (!cyrillicRegExp.hasMatch(value)) {
      return 'ФИО должно содержать только буквы русского алфавита.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).extension<AppTextStylesExtension>();

    return TextFormField(
      controller: _controller,
      decoration: const InputDecoration(
        labelText: 'ФИО',
        border: OutlineInputBorder(),
      ),
      style: textStyles?.bodyText,
      validator: _validateFio,
    );
  }
}

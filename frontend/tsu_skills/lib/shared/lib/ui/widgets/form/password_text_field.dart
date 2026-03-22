import 'package:flutter/material.dart';
import 'package:tsu_skills/shared/lib/ui/theme/text_styles.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField(this._controller, {super.key, this.label});
  final TextEditingController _controller;
  final String? label;

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пожалуйста, введите пароль.';
    }
    if (value.length < 8) {
      return 'Пароль должен содержать не менее 8 символов.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).extension<AppTextStylesExtension>();

    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      style: textStyles?.bodyText,
      decoration: InputDecoration(
        labelText: label ?? 'Пароль',
        border: OutlineInputBorder(),
      ),
      validator: _validatePassword,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tsu_skills/shared/lib/ui/theme/text_styles.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField(this._controller, {super.key});
  final TextEditingController _controller;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пожалуйста, введите адрес электронной почты.';
    }

    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegExp.hasMatch(value)) {
      return 'Неверный формат электронной почты.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).extension<AppTextStylesExtension>();

    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.emailAddress,
      style: textStyles?.bodyText,
      decoration: const InputDecoration(
        labelText: 'Электронная почта',
        border: OutlineInputBorder(),
      ),
      validator: _validateEmail,
    );
  }
}

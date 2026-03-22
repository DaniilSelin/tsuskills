import 'package:flutter/material.dart';
import 'package:tsu_skills/shared/lib/ui/theme/text_styles.dart';

class TelegramRefTextField extends StatelessWidget {
  const TelegramRefTextField(this._controller, {super.key});
  final TextEditingController _controller;

  String? _validateTelegramRef(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    final RegExp telegramLinkRegExp = RegExp(r'^@[a-zA-Z0-9_]{5,}$');

    if (!telegramLinkRegExp.hasMatch(value)) {
      return 'Неверный формат ника. Пример: @user_Id';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).extension<AppTextStylesExtension>();

    return TextFormField(
      controller: _controller,
      decoration: const InputDecoration(labelText: 'Telegram'),
      style: textStyles?.bodyText,
      validator: _validateTelegramRef,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tsu_skills/shared/lib/ui/theme/text_styles.dart';

class VkRefTextField extends StatelessWidget {
  const VkRefTextField(this._controller, {super.key});
  final TextEditingController _controller;

  String? _validateVkRef(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    final RegExp vkLinkRegExp = RegExp(r'^https://vk\.com/([a-zA-Z0-9_]+)$');

    if (!vkLinkRegExp.hasMatch(value)) {
      return 'Неверный формат ссылки. Пример: https://vk.com/user_id';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).extension<AppTextStylesExtension>();

    return TextFormField(
      controller: _controller,
      decoration: const InputDecoration(labelText: 'VK'),
      style: textStyles?.bodyText,
      validator: _validateVkRef,
    );
  }
}

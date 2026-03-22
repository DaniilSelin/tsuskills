import 'package:flutter/material.dart';
import 'package:tsu_skills/shared/lib/ui/theme/text_styles.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField(this._phoneController, {super.key});
  final TextEditingController _phoneController;

  String? _validateRussianPhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    // Регулярное выражение для формата +7 (XXX) XXX-XX-XX
    final RegExp phoneRegExp = RegExp(r'^\+7 \(\d{3}\) \d{3}-\d{2}-\d{2}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Неверный формат номера. Используйте: +7 (XXX) XXX-XX-XX';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).extension<AppTextStylesExtension>();

    return TextFormField(
      controller: _phoneController,
      decoration: const InputDecoration(labelText: 'Номер телефона'),
      style: textStyles?.bodyText,
      keyboardType: TextInputType.phone,
      validator: _validateRussianPhoneNumber,
    );
  }
}

import 'package:flutter/material.dart';

class AppTextStylesExtension extends ThemeExtension<AppTextStylesExtension> {
  const AppTextStylesExtension({
    required this.heading1,
    required this.heading2,
    required this.bodyText,
    required this.secondaryText,
    required this.hintText,
    required this.accentText,
  });

  final TextStyle heading1;
  final TextStyle heading2;
  final TextStyle bodyText;
  final TextStyle secondaryText;
  final TextStyle hintText;
  final TextStyle accentText;

  @override
  AppTextStylesExtension copyWith({
    TextStyle? heading1,
    TextStyle? heading2,
    TextStyle? bodyText,
    TextStyle? secondaryText,
    TextStyle? hintText,
    TextStyle? accentText,
  }) {
    return AppTextStylesExtension(
      heading1: heading1 ?? this.heading1,
      heading2: heading2 ?? this.heading2,
      bodyText: bodyText ?? this.bodyText,
      secondaryText: secondaryText ?? this.secondaryText,
      hintText: hintText ?? this.hintText,
      accentText: accentText ?? this.accentText,
    );
  }

  @override
  AppTextStylesExtension lerp(
    covariant ThemeExtension<AppTextStylesExtension>? other,
    double t,
  ) {
    if (other is! AppTextStylesExtension) {
      return this;
    }
    return AppTextStylesExtension(
      heading1: TextStyle.lerp(heading1, other.heading1, t)!,
      heading2: TextStyle.lerp(heading2, other.heading2, t)!,
      bodyText: TextStyle.lerp(bodyText, other.bodyText, t)!,
      secondaryText: TextStyle.lerp(secondaryText, other.secondaryText, t)!,
      hintText: TextStyle.lerp(hintText, other.hintText, t)!,
      accentText: TextStyle.lerp(accentText, other.accentText, t)!,
    );
  }
}

// --- ВИДЖЕТ "ЧИП" ДЛЯ НАВЫКА ---

import 'package:flutter/material.dart';

class SkillChip extends StatelessWidget {
  final String label;
  final TextStyle textStyle;
  final Widget? action;

  const SkillChip({
    super.key,
    required this.label,
    required this.textStyle,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: textStyle),
          (action != null)
              ? Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: action!,
                )
              : SizedBox(),
        ],
      ),
    );
  }
}

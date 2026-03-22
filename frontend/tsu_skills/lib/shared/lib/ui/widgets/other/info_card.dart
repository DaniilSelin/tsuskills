// Универсальный виджет для секций
import 'package:flutter/material.dart';
import 'package:tsu_skills/shared/lib/ui/theme/text_styles.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).extension<AppTextStylesExtension>()!;
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: colorScheme.primary),
              const SizedBox(width: 8),
              Text(title, style: textStyles.heading2),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

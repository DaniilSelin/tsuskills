import 'package:flutter/material.dart';
import 'package:tsu_skills/shared/lib/ui/theme/text_styles.dart';

class HeaderImage extends StatelessWidget {
  const HeaderImage({super.key, required this.imgProvider, this.title});

  final String imgProvider;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).extension<AppTextStylesExtension>();
    return SizedBox(
      width: 450,
      height: 450,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imgProvider, height: 380),
            if (title != null) ...[
              Text(title!, style: textStyles!.heading1),
              Padding(padding: const EdgeInsets.all(8.0), child: Divider()),
            ],
          ],
        ),
      ),
    );
  }
}

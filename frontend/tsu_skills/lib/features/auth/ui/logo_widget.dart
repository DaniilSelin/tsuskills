import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tsu_skills/shared/assets/assets.gen.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(Assets.icons.logo.keyName, height: 65);
  }
}

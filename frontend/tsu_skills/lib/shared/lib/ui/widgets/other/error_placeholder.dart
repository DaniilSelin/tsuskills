import 'package:flutter/material.dart';
import 'package:tsu_skills/features/auth/ui/error_container.dart' show ErrorContainer;

class ErrorPlaceholder extends StatelessWidget {
  const ErrorPlaceholder(this.message, {super.key});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(width: 400, child: ErrorContainer(message: message)),
    );
  }
}
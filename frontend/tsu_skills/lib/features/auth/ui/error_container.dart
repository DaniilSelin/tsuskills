import 'package:flutter/material.dart';

class ErrorContainer extends StatelessWidget {
  final String message;

  const ErrorContainer({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    const Color borderColor = Color(0xFFE57373);
    const Color backgroundColor = Color(0xFFFFCDD2);
    const Color iconAndTextColor = Color(0xFFB71C1C);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: borderColor, width: 2.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: iconAndTextColor),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: iconAndTextColor, fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}

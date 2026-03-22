import 'package:flutter/material.dart';

class LogoutAlertDialog {
  final BuildContext context;

  LogoutAlertDialog(this.context);

  Future<bool?> call() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Выход из профиля'),
          content: const Text('Вы точно хотите выйти из профиля?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Выйти'),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class DeleteVacancyAlertDialog {
  final BuildContext context;

  DeleteVacancyAlertDialog(this.context);

  Future<bool?> call() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Удаление вакансии'),
          content: const Text('Вы точно хотите удалить вакансию?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Удалить'),
            ),
          ],
        );
      },
    );
  }
}

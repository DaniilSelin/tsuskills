import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsu_skills/features/my_profile/bloc/profile_detail/profile_bloc.dart';
import 'package:tsu_skills/features/my_profile/ui/logout_alert_dialog.dart';

class LogoutButton extends StatefulWidget {
  final BuildContext context;

  const LogoutButton(this.context, {Key? key}) : super(key: key);

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  late final LogoutAlertDialog alertDialog;

  @override
  void initState() {
    alertDialog = LogoutAlertDialog(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final result = await alertDialog();
        if (result != null && result && context.mounted) {
          BlocProvider.of<ProfileDetailBloc>(
            context,
          ).add(ProfileEvent.logout());
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: const Text('Выйти из профиля', style: TextStyle(fontSize: 16)),
    );
  }
}

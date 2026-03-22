import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tsu_skills/app/di/di.dart';
import 'package:tsu_skills/features/auth/ui/error_container.dart';
import 'package:tsu_skills/features/my_profile/bloc/profile_edit/profile_edit_bloc.dart';
import 'package:tsu_skills/features/my_profile/ui/widgets.dart';
import 'package:tsu_skills/shared/assets/assets.gen.dart';
import 'package:tsu_skills/shared/lib/ui/theme/text_styles.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/form/form.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/loading/expanded_circular_progress_indicator.dart';

@RoutePage()
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class XFileController {
  XFile? xFile;
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _fioController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _vkController = TextEditingController();
  final _telegramController = TextEditingController();

  final _editProfileFormKey = GlobalKey<FormState>();

  final _xFileController = XFileController();

  @override
  void dispose() {
    _fioController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _vkController.dispose();
    _telegramController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).extension<AppTextStylesExtension>();
    final router = AutoRouter.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Редактирование профиля')),
      body: BlocProvider(
        create: (context) => getIt<ProfileEditBloc>(),
        child: BlocListener<ProfileEditBloc, ProfileEditState>(
          listener: (context, state) {
            state.mapOrNull(
              success: (d) {
                router.pop<bool>(true);
              },
            );
          },
          child: BlocBuilder<ProfileEditBloc, ProfileEditState>(
            builder: (context, state) {
              return state.map(
                error: (d) => ErrorContainer(message: d.message),
                loading: (d) => CircularProgressIndicatorPlaceholder(),
                success: (d) => Center(
                  child: Image.asset(Assets.image.successSavedUser.keyName),
                ),
                loaded: (d) {
                  final user = d.user;
                  _emailController.text = user.email;
                  _fioController.text = user.username;
                  _phoneController.text = user.phone ?? '';
                  _telegramController.text = user.telegramRef ?? '';
                  _vkController.text = user.vkRef ?? '';

                  return Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: 600,
                        child: Form(
                          key: _editProfileFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 20),
                              Text('Мои данные', style: textStyles?.heading1),

                              EditProfileAvatar(
                                _xFileController,
                                user.userPhotoUrl,
                              ),
                              const SizedBox(height: 16),

                              UsernameTextField(_fioController),
                              const SizedBox(height: 30),
                              const Divider(),
                              const SizedBox(height: 30),

                              // Секция "Контакты"
                              Text('Контакты', style: textStyles?.heading1),

                              const SizedBox(height: 16),

                              Column(
                                children: [
                                  EmailTextField(_emailController),
                                  const SizedBox(height: 16),
                                  PhoneTextField(_phoneController),
                                  const SizedBox(height: 16),
                                  VkRefTextField(_vkController),
                                  const SizedBox(height: 16),
                                  TelegramRefTextField(_telegramController),
                                ],
                              ),
                              const SizedBox(height: 30),
                              const Divider(),
                              const SizedBox(height: 30),

                              // Кнопка сохранения
                              ElevatedButton(
                                onPressed: () {
                                  if (_editProfileFormKey.currentState!
                                      .validate()) {
                                    BlocProvider.of<ProfileEditBloc>(
                                      context,
                                    ).add(
                                      ProfileEditEvent.sendData(
                                        email: _emailController.text,
                                        username: _fioController.text,
                                        vkRef: _vkController.text,
                                        telegramRef: _telegramController.text,
                                        phone: _phoneController.text,
                                        userPhoto: _xFileController.xFile,
                                      ),
                                    );
                                  }
                                },
                                child: const Text('Сохранить'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class EditProfileAvatar extends StatefulWidget {
  const EditProfileAvatar(this.controller, this.userPhotoUrl, {super.key});
  final XFileController controller;
  final String? userPhotoUrl;

  @override
  State<EditProfileAvatar> createState() => _EditProfileAvatarState();
}

class _EditProfileAvatarState extends State<EditProfileAvatar> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickAndUploadImage(BuildContext context) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        widget.controller.xFile = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: widget.userPhotoUrl != null
                ? NetworkImage(widget.userPhotoUrl!) as ImageProvider
                : (widget.controller.xFile != null)
                ? FileImage(File(widget.controller.xFile!.path))
                : AssetImage(Assets.image.userAvatarPlaceholder.keyName),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: IconButton(
                icon: const Icon(Icons.camera_alt, color: Colors.white),
                onPressed: () => _pickAndUploadImage(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

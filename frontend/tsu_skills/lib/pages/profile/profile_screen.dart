import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tsu_skills/app/di/di.dart';
import 'package:tsu_skills/app/router/app_router.dart';
import 'package:tsu_skills/entities/user_role/bloc/user_role_bloc.dart';
import 'package:tsu_skills/features/auth/ui/widgets.dart';
import 'package:tsu_skills/features/my_profile/bloc/profile_detail/profile_bloc.dart';
import 'package:tsu_skills/features/my_profile/ui/widgets.dart';
import 'package:tsu_skills/shared/assets/assets.gen.dart';
import 'package:tsu_skills/shared/lib/ui/theme/text_styles.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/loading/expanded_circular_progress_indicator.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).extension<AppTextStylesExtension>();
    final colorScheme = Theme.of(context).colorScheme;
    final router = AutoRouter.of(context);
    ProfileDetailBloc? bloc;

    if (textStyles == null) {
      return const Center(
        child: Text('Ошибка: AppTextStylesExtension не найден.'),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: BlocProvider(
        create: (context) {
          bloc = getIt<ProfileDetailBloc>();
          return bloc!;
        },
        child: BlocListener<ProfileDetailBloc, ProfileState>(
          listener: (context, state) {
            state.mapOrNull(
              logout: (value) {
                BlocProvider.of<UserRoleBloc>(
                  context,
                ).add(UserRoleEvent.updateRole());
              },
            );
          },
          child: BlocBuilder<ProfileDetailBloc, ProfileState>(
            builder: (context, state) {
              bloc = BlocProvider.of<ProfileDetailBloc>(context);
              return state.map(
                logout: (d) => CircularProgressIndicatorPlaceholder(),
                loading: (d) => CircularProgressIndicatorPlaceholder(),
                error: (d) => Center(child: ErrorContainer(message: d.message)),
                loaded: (d) => RefreshIndicator(
                  onRefresh: () async {
                    bloc?.add(ProfileEvent.refresh());
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: (d.user.userPhotoUrl != null)
                                ? NetworkImage(d.user.userPhotoUrl!)
                                : AssetImage(
                                    Assets.image.userAvatarPlaceholder.keyName,
                                  ),
                          ),
                          const SizedBox(height: 20),
                          // ФИО
                          Text(
                            d.user.username,
                            textAlign: TextAlign.center,
                            style: textStyles.heading1,
                          ),
                          const SizedBox(height: 8),
                          // Почта
                          Text(
                            d.user.email,
                            textAlign: TextAlign.center,
                            style: textStyles.secondaryText,
                          ),
                          const SizedBox(height: 30),
                          const Divider(),
                          const SizedBox(height: 20),
                          ListTile(
                            leading: const Icon(Icons.phone),
                            title: Text('Телефон', style: textStyles.bodyText),
                            subtitle: Text(
                              d.user.phone ?? 'Нет',
                              style: textStyles.secondaryText,
                            ),
                          ),
                          ListTile(
                            leading: SvgPicture.asset(
                              Assets.icons.telegramLogo.keyName,
                              width: 20,
                              color: Color.fromRGBO(71, 74, 81, 1),
                            ),
                            title: Text('Telegram', style: textStyles.bodyText),
                            subtitle: Text(
                              d.user.telegramRef ?? 'Нет',
                              style: textStyles.secondaryText,
                            ),
                          ),
                          ListTile(
                            leading: SvgPicture.asset(
                              Assets.icons.vkLogo.keyName,
                              width: 20,
                              color: Color.fromRGBO(71, 74, 81, 1),
                            ),
                            title: Text('VK', style: textStyles.bodyText),
                            subtitle: Text(
                              d.user.vkRef ?? 'Нет',
                              style: textStyles.secondaryText,
                            ),
                          ),

                          SizedBox(height: 50),

                          LogoutButton(context),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final didUpdate = await router.push<bool>(const EditProfileRoute());

          if (didUpdate == true) {
            bloc?.add(const ProfileEvent.refresh());
          }
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/user/model/user_entity.dart';
import 'package:tsu_skills/entities/user/repository/user_remote_repository.dart';

part 'profile_edit_event.dart';
part 'profile_edit_state.dart';
part 'profile_edit_bloc.freezed.dart';

@injectable
class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  ProfileEditBloc(this._repository) : super(_Loading()) {
    on<_Started>(_onStart);
    on<_SendData>(_onSendData);

    add(_Started());
  }
  final UserRemoteRepository _repository;

  Future<void> _onSendData(
    _SendData event,
    Emitter<ProfileEditState> emit,
  ) async {
    emit(_Loading());

    final response = await _repository.updateUser(
      username: event.username,
      email: event.email,
      phone: event.phone,
      telegramRef: event.telegramRef,
      vkRef: event.vkRef,
      userPhotoFile: event.userPhoto,
    );

    emit(
      response.fold(
        (error) => _ErrorState(error.message),
        (user) => _Success(),
      ),
    );
  }

  Future<void> _onStart(_Started event, Emitter<ProfileEditState> emit) async {
    if (state is! _Loading) {
      emit(_Loading());
    }

    final response = await _repository.getCurrentUser();

    emit(
      response.fold(
        (error) => _ErrorState(error.message),
        (user) => _Loaded(user),
      ),
    );
  }
}

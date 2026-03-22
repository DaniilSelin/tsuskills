import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/user/index.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

@injectable
class ProfileDetailBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileDetailBloc(this._repository) : super(_Loading()) {
    on<_Refresh>(_onRefresh);
    on<_Logout>(_onLogout);

    add(_Refresh());
  }
  final UserRemoteRepository _repository;

  Future<void> _onRefresh(_Refresh event, Emitter<ProfileState> emit) async {
    emit(_Loading());
    final response = await _repository.getCurrentUser();

    emit(
      response.fold(
        (error) => _ErrorState(error.message),
        (user) => _Loaded(user.copyWith()),
      ),
    );
  }

  Future<void> _onLogout(_Logout event, Emitter<ProfileState> emit) async {
    emit(_Loading());

    final response = await _repository.logout();

    emit(
      response.fold(
        (error) => _ErrorState(error.message),
        (_) => _HasLogoutState(),
      ),
    );
  }
}

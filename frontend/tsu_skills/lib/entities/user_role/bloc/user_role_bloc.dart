import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/user_role/index.dart';

part 'user_role_event.dart';
part 'user_role_state.dart';
part 'user_role_bloc.freezed.dart';

@injectable
class UserRoleBloc extends Bloc<UserRoleEvent, UserRoleState> {
  UserRoleBloc(this._repository) : super(_Loading()) {
    on<_Init>(_onInit);
    on<_UpdateRole>(_onUpdateRole);

    add(_Init());
  }

  final UserRoleRepository _repository;

  Future<void> _onInit(_Init event, Emitter<UserRoleState> emit) async =>
      await _fetchRole(emit);

  Future<void> _onUpdateRole(
    _UpdateRole event,
    Emitter<UserRoleState> emit,
  ) async => await _fetchRole(emit);

  Future<void> _fetchRole(Emitter<UserRoleState> emit) async {
    emit(_Loading());

    final response = await _repository.fetchCurrentUserRole();

    emit(response.fold((e) => _Error(e.message), (role) => _LoadedRole(role)));
  }
}

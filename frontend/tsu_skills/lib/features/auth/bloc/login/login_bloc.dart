import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/user/index.dart';
import 'package:tsu_skills/features/auth/repository/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._repository) : super(_Initial()) {
    on<_SendData>(onSendData);
  }
  final AuthRepository _repository;

  Future<void> onSendData(LoginEvent event, Emitter<LoginState> emit) async {
    emit(_Loading());

    final response = await _repository.login(event.username, event.password);

    emit(
      response.fold(
        (error) => _ErrorState(error.message),
        (user) => _Success(user),
      ),
    );
  }
}

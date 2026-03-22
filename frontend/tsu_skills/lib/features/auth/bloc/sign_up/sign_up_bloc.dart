import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/user/index.dart';
import 'package:tsu_skills/features/auth/repository/auth_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';
part 'sign_up_bloc.freezed.dart';

@injectable
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(this._repository) : super(_Initial()) {
    on<SignUpEvent>(_onSendData);
  }
  final AuthRepository _repository;

  Future<void> _onSendData(SignUpEvent event, Emitter<SignUpState> emit) async {
    if (event.password != event.repeatPassword) {
      emit(_ErrorState('Пароли не совпадают'));
      return;
    }

    emit(_Loading());

    final response = await _repository.signUp(
      event.email,
      event.username,
      event.password,
    );

    emit(
      response.fold((e) => _ErrorState(e.message), (user) => _Success(user)),
    );
  }
}

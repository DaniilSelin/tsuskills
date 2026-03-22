import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/features/auth/repository/auth_repository.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';
part 'forgot_password_bloc.freezed.dart';

@injectable
class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc(this._repository) : super(_Initial()) {
    on<ForgotPasswordEvent>(_onSendData);
  }

  final AuthRepository _repository;

  Future<void> _onSendData(
    ForgotPasswordEvent event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(_Loading());
    final response = await _repository.requestPasswordReset(event.email);

    emit(response.fold((e) => _ErrorState(e.message), (_) => _Success()));
  }
}

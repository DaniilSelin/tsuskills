part of 'create_resume_bloc.dart';

@freezed
abstract class CreateResumeState with _$CreateResumeState {
  const factory CreateResumeState.initial() = _Initial;
  const factory CreateResumeState.loading() = _Loading;
  const factory CreateResumeState.error(String message) = _Error;
  const factory CreateResumeState.success() = _Success;
}

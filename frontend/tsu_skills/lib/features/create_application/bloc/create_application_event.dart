part of 'create_application_bloc.dart';

@freezed
abstract class CreateApplicationEvent with _$CreateApplicationEvent {
  const factory CreateApplicationEvent.createApplication(String resumeId) =
      _CreateApplication;

  const factory CreateApplicationEvent.loadResumes() = _LoadResumes;
}

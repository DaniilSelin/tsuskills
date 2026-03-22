part of 'my_application_bloc.dart';

@freezed
class MyApplicationEvent with _$MyApplicationEvent {
  const factory MyApplicationEvent.loadMyApplications() = _LoadMyApplications;
  const factory MyApplicationEvent.addApplication(String applicationId) =
      _AddApplication;
}

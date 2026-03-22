part of 'resume_list_bloc.dart';

@freezed
class ResumeListEvent with _$ResumeListEvent {
  const factory ResumeListEvent.fetchMyResumes() = _FetchMyResumes;
}
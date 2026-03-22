part of 'resume_detail_bloc.dart';

@freezed
class ResumeDetailEvent with _$ResumeDetailEvent {
  const factory ResumeDetailEvent.fetchResume() = _FetchResume;

  const factory ResumeDetailEvent.deleteResume() = _DeleteResume;
}

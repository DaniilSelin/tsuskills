part of 'resume_list_bloc.dart';

@freezed
class ResumeListState with _$ResumeListState {
  const factory ResumeListState.loading() = _Loading;
  const factory ResumeListState.loaded(List<ResumeEntity> resumes) = _Loaded;
  const factory ResumeListState.error(String error) = _Error;
}

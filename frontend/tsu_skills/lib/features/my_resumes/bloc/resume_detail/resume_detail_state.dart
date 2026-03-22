part of 'resume_detail_bloc.dart';

@freezed
class ResumeDetailState with _$ResumeDetailState {
  const factory ResumeDetailState.loading() = _Loading;
  const factory ResumeDetailState.loaded(ResumeEntity resume) = _Loaded;
  const factory ResumeDetailState.error(String message) = _Error;
  const factory ResumeDetailState.deleted() = _Deleted;
}

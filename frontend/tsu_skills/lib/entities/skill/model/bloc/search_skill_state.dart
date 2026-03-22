part of 'search_skill_bloc.dart';

@freezed
abstract class SearchSkillState with _$SearchSkillState {
  const factory SearchSkillState.initial() = _Initial;

  const factory SearchSkillState.loading() = _Loading;

  const factory SearchSkillState.success({required List<SkillEntity> skills}) =
      _Success;

  const factory SearchSkillState.failure({required AppError error}) = _Failure;
}

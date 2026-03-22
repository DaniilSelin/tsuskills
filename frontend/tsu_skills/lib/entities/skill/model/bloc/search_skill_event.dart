part of 'search_skill_bloc.dart';

@freezed
abstract class SearchSkillEvent with _$SearchSkillEvent {
  const factory SearchSkillEvent.searchRequested({required String query}) =
      _SearchRequested;
}

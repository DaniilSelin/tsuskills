import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/skill/model/types/skill.dart';
import 'package:tsu_skills/entities/skill/model/repository/skill_repository.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';

part 'search_skill_event.dart';
part 'search_skill_state.dart';
part 'search_skill_bloc.freezed.dart';

@injectable
class SearchSkillBloc extends Bloc<SearchSkillEvent, SearchSkillState> {
  final SkillRepository _repository;

  SearchSkillBloc(this._repository) : super(const SearchSkillState.initial()) {
    on<SearchSkillEvent>(
      (event, emit) async {
        await event.when(
          searchRequested: (query) async {
            if (query.isEmpty) {
              return emit(const SearchSkillState.initial());
            }

            emit(const SearchSkillState.loading());

            final result = await _repository.searchSkills(query);

            result.fold(
              (error) => emit(SearchSkillState.failure(error: error)),
              (skills) => emit(SearchSkillState.success(skills: skills)),
            );
          },
        );
      },
    );
  }
}

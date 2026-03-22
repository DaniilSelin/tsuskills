import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/vacancy/index.dart';

part 'search_vacancies_event.dart';
part 'search_vacancies_state.dart';
part 'search_vacancies_bloc.freezed.dart';

@injectable
class SearchVacanciesBloc
    extends Bloc<SearchVacanciesEvent, SearchVacanciesState> {
  final VacancyRepository _repository;

  SearchVacanciesBloc(this._repository)
    : super(const SearchVacanciesState.loading()) {
    on<_Search>(_onSearch);
    on<_Clear>(_onClear);

    add(_Search());
  }

  Future<void> _onSearch(
    _Search event,
    Emitter<SearchVacanciesState> emit,
  ) async {
    emit(const SearchVacanciesState.loading());

    final result = await _repository.searchVacancies(
      name: event.name,
      skillIds: event.skillIds,
    );

    final isEmptyFilter = event.skillIds == null && event.name == null;

    result.match(
      (error) => emit(SearchVacanciesState.error(error.message)),
      (vacancies) => emit(SearchVacanciesState.loaded(vacancies, isEmptyFilter)),
    );
  }

  void _onClear(_Clear event, Emitter<SearchVacanciesState> emit) {
    emit(const SearchVacanciesState.initial());
  }
}

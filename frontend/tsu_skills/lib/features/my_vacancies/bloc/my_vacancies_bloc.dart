import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/vacancy/index.dart';

part 'my_vacancies_event.dart';
part 'my_vacancies_state.dart';
part 'my_vacancies_bloc.freezed.dart';

@injectable
class MyVacanciesBloc extends Bloc<MyVacanciesEvent, MyVacanciesState> {
  MyVacanciesBloc(this._repository) : super(_Loading()) {
    on<_FetchVacancies>(_onFetchVacancies);

    add(_FetchVacancies());
  }

  final VacancyRepository _repository;

  Future<void> _onFetchVacancies(
    _FetchVacancies event,
    Emitter<MyVacanciesState> emit,
  ) async {
    emit(_Loading());

    final response = await _repository.getMyVacancies();

    emit(
      response.fold(
        (e) => _ErrorState(e.message),
        (vacancies) => _Loaded(vacancies),
      ),
    );
  }
}

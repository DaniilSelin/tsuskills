import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/vacancy/index.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';

part 'vacancy_detail_event.dart';
part 'vacancy_detail_state.dart';
part 'vacancy_detail_bloc.freezed.dart';

@injectable
class VacancyDetailBloc extends Bloc<VacancyDetailEvent, VacancyDetailState> {
  VacancyDetailBloc(this._vacancyRepository, @factoryParam this.vacancyId)
    : super(_Loading()) {
    on<_FetchVacancy>(_onFetchVacancy);
    add(_FetchVacancy());
  }

  final VacancyRepository _vacancyRepository;
  final String vacancyId;

  Future<void> _onFetchVacancy(
    _FetchVacancy event,
    Emitter<VacancyDetailState> emit,
  ) async {
    emit(_Loading());

    final response = await _vacancyRepository.getVacancy(vacancyId);

    emit(
      response.fold((e) => _Error(e.message), (vacancy) {
        if (vacancy == null) {
          return _Error(AppError.notFound().message);
        }

        return _Loaded(vacancy);
      }),
    );
  }
}

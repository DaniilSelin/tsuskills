import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/application/model/application_entity.dart';
import 'package:tsu_skills/entities/application/repository/application_repository.dart';

part 'application_on_vacancy_event.dart';
part 'application_on_vacancy_state.dart';
part 'application_on_vacancy_bloc.freezed.dart';

@injectable
class ApplicationOnVacancyBloc
    extends Bloc<ApplicationOnVacancyEvent, ApplicationOnVacancyState> {
  ApplicationOnVacancyBloc(@factoryParam this.vacancyId, this._repository)
    : super(_Loading()) {
    on<_FetchApplications>(_onLoad);
    add(_FetchApplications());
  }

  final String vacancyId;
  final ApplicationRepository _repository;

  Future<void> _onLoad(
    _FetchApplications event,
    Emitter<ApplicationOnVacancyState> emit,
  ) async {
    emit(_Loading());

    final response = await _repository.getApplicationsByVacancy(vacancyId);

    emit(
      response.fold(
        (e) => _ErrorState(e.message),
        (entities) => _Load(entities),
      ),
    );
  }
}

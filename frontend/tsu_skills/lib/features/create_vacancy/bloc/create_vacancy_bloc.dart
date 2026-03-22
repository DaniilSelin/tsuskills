import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/skill/index.dart';
import 'package:tsu_skills/entities/vacancy/index.dart';

part 'create_vacancy_event.dart';
part 'create_vacancy_state.dart';
part 'create_vacancy_bloc.freezed.dart';

@injectable
class CreateVacancyBloc extends Bloc<CreateVacancyEvent, CreateVacancyState> {
  CreateVacancyBloc(this._repository) : super(_Initial()) {
    on<_CreateVacancy>(_onCreateVacancy);
  }

  final VacancyRepository _repository;

  Future<void> _onCreateVacancy(
    _CreateVacancy event,
    Emitter<CreateVacancyState> emit,
  ) async {
    emit(_Loading());

    final response = await _repository.createVacancy(
      name: event.title,
      description: event.description,
      skillIds: event.skills.map((el) => el.id).toList(),
    );

    emit(response.fold((e) => _Error(e.message), (_) => _Saved()));
  }
}

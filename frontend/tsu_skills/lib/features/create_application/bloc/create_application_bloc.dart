import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/application/index.dart';
import 'package:tsu_skills/entities/resume/index.dart';

part 'create_application_event.dart';
part 'create_application_state.dart';
part 'create_application_bloc.freezed.dart';

@injectable
class CreateApplicationBloc
    extends Bloc<CreateApplicationEvent, CreateApplicationState> {
  CreateApplicationBloc(
    @factoryParam this.vacancyId,
    this._applicationRepository,
    this._resumeRepository,
  ) : super(_Loading()) {
    on<_CreateApplication>(_onCreateApplication);
    on<_LoadResumes>(_onLoadResumes);
    add(_LoadResumes());
  }

  final ApplicationRepository _applicationRepository;
  final ResumeRepository _resumeRepository;
  final String vacancyId;

  Future<void> _onLoadResumes(
    _LoadResumes event,
    Emitter<CreateApplicationState> emit,
  ) async {
    emit(_Loading());

    final response = await _resumeRepository.getAvailableResumesForVacancy(
      vacancyId,
    );

    //final response = await _resumeRepository.getMyResumesList();

    emit(
      response.fold((e) => _Error(e.message), (resumes) => _Loaded(resumes)),
    );
  }

  Future<void> _onCreateApplication(
    _CreateApplication event,
    Emitter<CreateApplicationState> emit,
  ) async {
    emit(_Loading());

    final response = await _applicationRepository.createApplication(
      resumeId: event.resumeId,
      vacancyId: vacancyId,
    );

    emit(
      response.fold(
        (e) => _Error(e.message),
        (applicationId) => _CreatedApplication(applicationId),
      ),
    );
  }
}

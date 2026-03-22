import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/resume/index.dart';
import 'package:tsu_skills/entities/skill/@x/resume.dart';

part 'create_resume_event.dart';
part 'create_resume_state.dart';
part 'create_resume_bloc.freezed.dart';

@injectable
class CreateResumeBloc extends Bloc<CreateResumeEvent, CreateResumeState> {
  CreateResumeBloc(this._repository) : super(_Initial()) {
    on<_CreateResume>(_onCreateResume);
  }

  final ResumeRepository _repository;

  Future<void> _onCreateResume(
    _CreateResume event,
    Emitter<CreateResumeState> emit,
  ) async {
    emit(_Loading());

    final response = await _repository.createResume(
      name: event.name,
      description: event.description,
      aboutMe: event.aboutMe,
      skillIds: event.skills.map((el) => el.id).toList(),
    );

    emit(response.fold((e) => _Error(e.message), (_) => _Success()));
  }
}

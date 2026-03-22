import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/resume/index.dart';
import 'package:tsu_skills/entities/skill/index.dart';

part 'resume_edit_event.dart';
part 'resume_edit_state.dart';
part 'resume_edit_bloc.freezed.dart';

@injectable
class ResumeEditBloc extends Bloc<ResumeEditEvent, ResumeEditState> {
  ResumeEditBloc(this._repository, @factoryParam this._resumeId)
    : super(_Loading()) {
    on<_Init>(_onInit);
    on<_Save>(_onSave);
    add(_Init());
  }

  final ResumeRepository _repository;
  final String _resumeId;
  late final ResumeEntity currentResume;

  Future<void> _onInit(_Init event, Emitter<ResumeEditState> emit) async {
    emit(_Loading());

    final response = await _repository.getResume(resumeId: _resumeId);

    emit(
      response.fold((e) => _Error(e.message), (resume) {
        currentResume = resume;
        return _Loaded(
          name: resume.name,
          description: resume.description,
          aboutMe: resume.aboutMe,
          skills: resume.skills.toList(),
        );
      }),
    );
  }

  Future<void> _onSave(_Save event, Emitter<ResumeEditState> emit) async {
    emit(_Loading());

    final response = await _repository.updateResume(
      id: currentResume.id,
      description: (event.description == currentResume.description)
          ? null
          : event.description,
      name: (currentResume.name == event.name) ? null : event.name,
      aboutMe: (currentResume.aboutMe == event.aboutMe) ? null : event.aboutMe,
      skillIds: (listEquals(currentResume.skills, event.skills))
          ? null
          : event.skills.map((el) => el.id).toList(),
    );

    emit(response.fold((e) => _Error(e.message), (_) => _Saved()));
  }
}

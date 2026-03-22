import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/resume/index.dart';

part 'resume_detail_event.dart';
part 'resume_detail_state.dart';
part 'resume_detail_bloc.freezed.dart';

@injectable
class ResumeDetailBloc extends Bloc<ResumeDetailEvent, ResumeDetailState> {
  ResumeDetailBloc(this._repository, @factoryParam this._resumeId)
    : super(_Loading()) {
    on<_FetchResume>(_onFetchResume);
    on<_DeleteResume>(_onDeleteResume);
    add(ResumeDetailEvent.fetchResume());
  }

  Future<void> _onFetchResume(
    _FetchResume event,
    Emitter<ResumeDetailState> emit,
  ) async {
    emit(_Loading());

    final response = await _repository.getResume(resumeId: _resumeId);

    emit(
      response.fold((e) => _Error(e.message), (resumes) => _Loaded(resumes)),
    );
  }

  Future<void> _onDeleteResume(
    _DeleteResume event,
    Emitter<ResumeDetailState> emit,
  ) async {
    emit(_Loading());

    final response = await _repository.deleteResume(resumeId: _resumeId);

    emit(response.fold((e) => _Error(e.message), (_) => _Deleted()));
  }

  final ResumeRepository _repository;
  final String _resumeId;
}

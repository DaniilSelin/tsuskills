import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/resume/index.dart';

part 'resume_list_event.dart';
part 'resume_list_state.dart';
part 'resume_list_bloc.freezed.dart';

@injectable
class ResumeListBloc extends Bloc<ResumeListEvent, ResumeListState> {
  ResumeListBloc(this._repository) : super(_Loading()) {
    on<_FetchMyResumes>(_onFetchMyResumes);
    add(_FetchMyResumes());
  }
  final ResumeRepository _repository;

  Future<void> _onFetchMyResumes(
    _FetchMyResumes event,
    Emitter<ResumeListState> emit,
  ) async {
    if (state is! _Loading) {
      emit(_Loading());
    }
    final result = await _repository.getMyResumesList();
    result.fold(
      (error) => emit(ResumeListState.error(error.message)),
      (resumes) => emit(ResumeListState.loaded(resumes)),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/application/index.dart';

part 'my_application_event.dart';
part 'my_application_state.dart';
part 'my_application_bloc.freezed.dart';

@injectable
class MyApplicationBloc extends Bloc<MyApplicationEvent, MyApplicationState> {
  MyApplicationBloc(this._repository) : super(_Loading()) {
    on<_LoadMyApplications>(_onLoad);
    on<_AddApplication>(_onAddApplication);

    add(MyApplicationEvent.loadMyApplications());
  }

  final ApplicationRepository _repository;
  List<ApplicationEntity> applications = [];

  Future<void> _onLoad(
    _LoadMyApplications event,
    Emitter<MyApplicationState> emit,
  ) async {
    emit(_Loading());

    final response = await _repository.fetchMyApplication();

    emit(
      response.fold((e) => _Error(e.message), (applications) {
        this.applications = applications;
        return _Loaded(applications);
      }),
    );
  }

  Future<void> _onAddApplication(
    _AddApplication event,
    Emitter<MyApplicationState> emit,
  ) async {
    emit(_Loading());

    final response = await _repository.getMyApplicationById(
      event.applicationId,
    );

    emit(
      response.fold((e) => _Error(e.message), (entity) {
        applications.add(entity);
        return _Loaded(applications);
      }),
    );
  }
}

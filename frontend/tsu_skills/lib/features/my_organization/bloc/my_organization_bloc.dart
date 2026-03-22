import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/organization/model/repository/organization_repository.dart';
import 'package:tsu_skills/entities/organization/model/types/organization.dart';

part 'my_organization_event.dart';
part 'my_organization_state.dart';
part 'my_organization_bloc.freezed.dart';

@injectable
class MyOrganizationBloc
    extends Bloc<MyOrganizationEvent, MyOrganizationState> {
  MyOrganizationBloc(this._repository) : super(_Loading()) {
    on<_FetchOrganization>(_onFetchOrganization);
    add(MyOrganizationEvent.fetchOrganization());
  }

  final OrganizationRepository _repository;

  Future<void> _onFetchOrganization(
    _FetchOrganization event,
    Emitter<MyOrganizationState> emit,
  ) async {
    emit(_Loading());

    final response = await _repository.getMyOrganization();

    emit(response.fold((e) => _ErrorState(e.message), (org) => _Loaded(org!)));
  }
}

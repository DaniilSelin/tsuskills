import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/organization/model/repository/organization_repository.dart';
import 'package:tsu_skills/entities/organization/model/types/organization.dart';

part 'update_organization_event.dart';
part 'update_organization_state.dart';
part 'update_organization_bloc.freezed.dart';

@injectable
class UpdateOrganizationBloc
    extends Bloc<UpdateOrganizationEvent, UpdateOrganizationState> {
  UpdateOrganizationBloc(this._repository) : super(_Loading()) {
    on<_FetchOrganization>(_onFetchOrganization);
    on<_SaveOrganization>(_onSave);
    add(_FetchOrganization());
  }

  final OrganizationRepository _repository;
  String? organizationId;

  Future<void> _onFetchOrganization(
    _FetchOrganization event,
    Emitter<UpdateOrganizationState> emit,
  ) async {
    emit(_Loading());

    final response = await _repository.getMyOrganization();

    emit(
      response.fold((e) => _ErrorState(e.message), (entity) {
        organizationId = entity!.objectId;
        return _Loaded(entity);
      }),
    );
  }

  Future<void> _onSave(
    _SaveOrganization event,
    Emitter<UpdateOrganizationState> emit,
  ) async {
    emit(_Loading());

    final response = await _repository.updateOrganization(
      id: organizationId,
      name: event.name,
      aboutUs: event.aboutUs,
    );

    emit(response.fold((e) => _ErrorState(e.message), (entity) => _Saved()));
  }
}

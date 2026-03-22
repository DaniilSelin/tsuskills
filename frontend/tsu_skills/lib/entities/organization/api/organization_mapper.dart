import 'package:tsu_skills/entities/organization/api/types/organization_dto.dart';
import 'package:tsu_skills/entities/organization/model/types/organization.dart';

class OrganizationMapper {
  static OrganizationEntity toEntity(OrganizationDto dto) {
    return OrganizationEntity(
      objectId: dto.objectId,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
      aboutUs: dto.aboutUs,
      name: dto.name,
    );
  }
}

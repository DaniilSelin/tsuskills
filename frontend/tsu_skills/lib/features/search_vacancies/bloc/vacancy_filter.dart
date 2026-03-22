import 'package:tsu_skills/entities/skill/index.dart';

class VacancyFilter {
  final String? name;
  final List<SkillEntity>? skills;

  const VacancyFilter({this.name, this.skills});

  bool get isEmpty =>
      (name == null || name!.trim().isEmpty) &&
      (skills == null || skills!.isEmpty);

  factory VacancyFilter.empty() => const VacancyFilter();

  @override
  String toString() => 'VacancyFilter(name: $name, skills: ${skills ?? 0})';
}

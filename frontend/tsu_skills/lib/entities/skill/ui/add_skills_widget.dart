import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' as fp;
import 'package:tsu_skills/entities/skill/index.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';
import 'package:tsu_skills/shared/lib/ui/theme/text_styles.dart';

class SkillsController {
  SkillsController(this.skills);
  List<SkillEntity> skills;
}

class AddSkillsWidget extends StatefulWidget {
  const AddSkillsWidget({super.key, required this.skillsController});
  final SkillsController skillsController;

  @override
  State<AddSkillsWidget> createState() => _AddSkillsWidgetState();
}

class _AddSkillsWidgetState extends State<AddSkillsWidget> {
  List<SkillEntity> searchResult = [];
  AppError? _error;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).extension<AppTextStylesExtension>();
    final skills = widget.skillsController.skills;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Wrap(
          children: skills
              .mapWithIndex(
                (el, i) => SkillChip(
                  label: el.name,
                  textStyle: textStyles!.accentText,
                  action: IconButton(
                    onPressed: () {
                      setState(() {
                        skills.removeAt(i);
                      });
                    },
                    icon: Icon(Icons.close),
                  ),
                ),
              )
              .toList(),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SkillSearchInput(
            onSuccess: (skills) {
              setState(() {
                _error = null;
                _isLoading = false;
                searchResult = skills;
              });
            },
            onFailure: (error) {
              setState(() {
                _isLoading = false;
                _error = error;
              });
            },
            onLoading: () {
              setState(() {
                _isLoading = true;
              });
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Wrap(
            children: searchResult.mapWithIndex((el, i) {
              return SkillChip(
                label: el.name,
                textStyle: textStyles!.accentText,
                action: IconButton(
                  onPressed: () {
                    setState(() {
                      skills.add(searchResult[i]);
                    });
                  },
                  icon: Icon(Icons.add),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

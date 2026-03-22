import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsu_skills/app/di/di.dart';
import 'package:tsu_skills/entities/skill/model/types/skill.dart';
import 'package:tsu_skills/entities/skill/model/bloc/search_skill_bloc.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';

class SkillSearchInput extends StatefulWidget {
  final void Function(List<SkillEntity> skills) onSuccess;
  final void Function(AppError error) onFailure;
  final VoidCallback onLoading;

  const SkillSearchInput({
    super.key,
    required this.onSuccess,
    required this.onFailure,
    required this.onLoading,
  });

  @override
  State<SkillSearchInput> createState() => _SkillSearchInputState();
}

class _SkillSearchInputState extends State<SkillSearchInput> {
  final TextEditingController _controller = TextEditingController();

  void _onSearchPressed(BuildContext context) {
    final query = _controller.text.trim();
    if (query.isNotEmpty) {
      BlocProvider.of<SearchSkillBloc>(
        context,
      ).add(SearchSkillEvent.searchRequested(query: query));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SearchSkillBloc>(),
      child: BlocListener<SearchSkillBloc, SearchSkillState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: () => widget.onLoading(),
            success: widget.onSuccess,
            failure: widget.onFailure,
          );
        },
        child: BlocBuilder<SearchSkillBloc, SearchSkillState>(
          builder: (context, state) {
            final bool isLoading =
                state.mapOrNull(loading: (_) => true) ?? false;

            return TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Введите название навыка...',
                suffixIcon: isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () => _onSearchPressed(context),
                      ),
              ),
              onSubmitted: (_) => _onSearchPressed(context),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

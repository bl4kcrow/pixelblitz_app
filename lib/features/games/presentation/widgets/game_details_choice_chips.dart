import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/theme/theme.dart';
import '../presentation.dart';

class GameDetailsChoiceChips extends StatelessWidget {
  GameDetailsChoiceChips({
    super.key,
    this.onSelected,
  });

  final Function()? onSelected;

  final List<String> _chips = [
    Labels.about,
    Labels.info,
    Labels.gameSeries,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameDetailsChipSelectedCubit, int>(
      builder: (context, state) => Row(
        children: [
          for (int index = 0; index < _chips.length; index++) ...[
            ChoiceChip(
              label: Text(
                _chips[index],
                semanticsLabel:
                    '${_chips[index]} ${SemanticLabels.details} ${SemanticLabels.button}',
              ),
              selected: state == index,
              onSelected: (_) {
                context.read<GameDetailsChipSelectedCubit>().selectChip(index);
                onSelected?.call();
              },
            ),
            const SizedBox(width: Insets.small),
          ],
        ],
      ),
    );
  }
}

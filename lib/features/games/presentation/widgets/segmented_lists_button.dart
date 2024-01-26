import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/utils/utils.dart';
import '../presentation.dart';

class SegmentedListsButton extends StatefulWidget {
  const SegmentedListsButton({super.key});

  @override
  State<SegmentedListsButton> createState() => _SegmentedListsButtonState();
}

class _SegmentedListsButtonState extends State<SegmentedListsButton> {
  late Set<GameTopLists> selectedTopList;

  final String previousYear = (DateTime.now().year - 1).toString();

  RenderBox? myTextRenderBox;
  GlobalKey myTextKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    selectedTopList = <GameTopLists>{GameTopLists.recentReleases};
    WidgetsBinding.instance.addPostFrameCallback((_) => _recordSize());
  }

  void _recordSize() {
    setState(() {
      myTextRenderBox =
          myTextKey.currentContext?.findRenderObject() as RenderBox;
    });
  }

  Shader? _getTextGradient(RenderBox? renderBox) {
    Shader? linearShader;

    if (renderBox != null) {
      linearShader = const LinearGradient(
        colors: <Color>[
          AppColors.congoPink,
          AppColors.maroon,
        ],
      ).createShader(
        Rect.fromLTWH(
          renderBox.localToGlobal(Offset.zero).dx,
          renderBox.localToGlobal(Offset.zero).dy,
          renderBox.size.width,
          renderBox.size.height,
        ),
      );
    }

    return linearShader;
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Semantics(
      label: SemanticLabels.segmentedButton,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
        child: SegmentedButton(
          onSelectionChanged: (newSelectection) {
            late final DateTime fromDate;
            late final DateTime toDate;

            final dateTimeNow = DateTime.now();

            setState(() {
              selectedTopList = newSelectection;
            });

            if (selectedTopList.first == GameTopLists.best) {
              fromDate = dateTimeNow.copyWith(
                month: 01,
                day: 01,
                year: int.parse(previousYear),
              );

              toDate = dateTimeNow.copyWith(
                month: 12,
                day: 31,
                year: int.parse(previousYear),
              );
            } else if (selectedTopList.first == GameTopLists.recentReleases) {
              fromDate = DateTime(
                dateTimeNow.year,
                dateTimeNow.month - 1,
              );
              toDate = dateTimeNow;
            } else {
              fromDate = dateTimeNow.copyWith(
                month: 01,
                day: 01,
              );
              toDate = dateTimeNow;
            }

            context.read<TopListsBloc>().add(
                  GetInitial(
                    from: fromDate,
                    to: toDate,
                    listType: selectedTopList.first,
                  ),
                );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith(
              (states) => states.contains(MaterialState.selected)
                  ? AppColors.black
                  : AppColors.eerieBlack,
            ),
            side: MaterialStatePropertyAll(
              BorderSide(
                color: AppColors.white.withOpacity(0.7),
              ),
            ),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.small),
              ),
            ),
            textStyle: MaterialStateTextStyle.resolveWith(
              (states) => states.contains(MaterialState.selected)
                  ? textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..shader = _getTextGradient(myTextRenderBox),
                    )
                  : textTheme.bodySmall!,
            ),
          ),
          segments: <ButtonSegment<GameTopLists>>[
            ButtonSegment<GameTopLists>(
              value: GameTopLists.best,
              label: Text(
                '${Labels.best} $previousYear',
              ),
            ),
            ButtonSegment<GameTopLists>(
              value: GameTopLists.recentReleases,
              label: Text(
                Labels.recent,
                key: myTextKey,
              ),
            ),
            const ButtonSegment<GameTopLists>(
              value: GameTopLists.popular,
              label: Text(
                Labels.popular,
              ),
            ),
          ],
          selected: selectedTopList,
          showSelectedIcon: false,
        ),
      ),
    );
  }
}

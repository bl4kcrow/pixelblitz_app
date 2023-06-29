import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/theme/theme.dart';

enum TrendingGames { recommended, popular, news }

class SegmentedListsButton extends StatefulWidget {
  const SegmentedListsButton({super.key});

  @override
  State<SegmentedListsButton> createState() => _SegmentedListsButtonState();
}

class _SegmentedListsButtonState extends State<SegmentedListsButton> {
  late Set<TrendingGames> selectedTrendingGames;

  final String previousYear = (DateTime.now().year - 1).toString();

  RenderBox? myTextRenderBox;
  GlobalKey myTextKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    selectedTrendingGames = <TrendingGames>{TrendingGames.popular};
    WidgetsBinding.instance.addPostFrameCallback((_) => _recordSize());
  }

  void _recordSize() {
    setState(() {
      myTextRenderBox =
          myTextKey.currentContext?.findRenderObject() as RenderBox;
    });
  }

  Shader? getTextGradient(RenderBox? renderBox) {
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
      child: SegmentedButton(
        onSelectionChanged: (newSelectection) {
          setState(() {
            selectedTrendingGames = newSelectection;
          });
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) => states.contains(MaterialState.selected)
                ? AppColors.black
                : AppColors.eerieBlack,
          ),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          textStyle: MaterialStateTextStyle.resolveWith(
            (states) => states.contains(MaterialState.selected)
                ? textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..shader = getTextGradient(myTextRenderBox),
                  )
                : textTheme.bodySmall!,
          ),
        ),
        segments: <ButtonSegment<TrendingGames>>[
          const ButtonSegment<TrendingGames>(
            value: TrendingGames.recommended,
            label: Text(
              Labels.top,
            ),
          ),
          ButtonSegment<TrendingGames>(
            value: TrendingGames.popular,
            label: Text(
              Labels.popular,
              key: myTextKey,
            ),
          ),
          ButtonSegment<TrendingGames>(
            value: TrendingGames.news,
            label: Text(
              '${Labels.best} $previousYear',
            ),
          ),
        ],
        selected: selectedTrendingGames,
        showSelectedIcon: false,
      ),
    );
  }
}

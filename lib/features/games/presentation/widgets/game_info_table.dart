import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/theme/theme.dart';
import '../../domain/domain.dart';
import '../presentation.dart';

class GameInfoTable extends StatelessWidget {
  const GameInfoTable({
    super.key,
    required this.gameDetails,
  });

  final GameDetails gameDetails;

  Widget _leftSideText(
    String text,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Insets.xsmall),
      child: Text(
        text,
        style: TextStyle(color: AppColors.white.withValues(alpha: 0.7)),
      ),
    );
  }

  Widget _rightSideText(
    String text,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Insets.xsmall),
      child: Text(
        text,
      ),
    );
  }

  Widget _urlText(String text) {
    return GestureDetector(
        onTap: () async {
          await launchUrlString(
            text,
            mode: LaunchMode.externalApplication,
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: Insets.xsmall),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _rightSideText(text),
              const SizedBox(width: Insets.xsmall),
              const FaIcon(
                FontAwesomeIcons.arrowUpRightFromSquare,
                color: AppColors.melon,
                size: IconSize.xsmall / 1.5,
                semanticLabel: SemanticLabels.goToGameLink,
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(4),
      },
      children: [
        TableRow(
          children: [
            _leftSideText('${Labels.releaseDate}:'),
            gameDetails.released != null
                ? _rightSideText(
                    DateFormat.yMMMd().format(gameDetails.released!))
                : _rightSideText(Labels.notApplicable),
          ],
        ),
        TableRow(
          children: [
            _leftSideText('${Labels.website}:'),
            gameDetails.website?.isNotEmpty == true
                ? _urlText(gameDetails.website!)
                : _rightSideText(Labels.notApplicable),
          ],
        ),
        TableRow(
          children: [
            _leftSideText('${Labels.metacritic}:'),
            gameDetails.metacritic != null
                ? _rightSideText(gameDetails.metacritic.toString())
                : _rightSideText(Labels.notApplicable),
          ],
        ),
        TableRow(
          children: [
            _leftSideText('${Labels.metacriticUrl}:'),
            gameDetails.metacriticUrl?.isNotEmpty == true
                ? _urlText(gameDetails.metacriticUrl!)
                : _rightSideText(Labels.notApplicable),
          ],
        ),
        TableRow(
          children: [
            _leftSideText('${Labels.rating}:'),
            Row(
              children: [
                _rightSideText(gameDetails.rating.toStringAsFixed(1)),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: Insets.xsmall,
                    left: Insets.xsmall,
                  ),
                  child: StarRating(
                    value: gameDetails.rating,
                    iconSize: IconSize.xsmall,
                  ),
                ),
              ],
            ),
          ],
        ),
        TableRow(
          children: [
            _leftSideText('${Labels.publishers}:'),
            _rightSideText(gameDetails.publishers.join(', ')),
          ],
        ),
        TableRow(
          children: [
            _leftSideText('${Labels.genres}:'),
            _rightSideText(gameDetails.genres.join(', ')),
          ],
        ),
        TableRow(
          children: [
            _leftSideText('${Labels.stores}:'),
            gameDetails.stores != null
                ? _rightSideText(gameDetails.stores!.join(', '))
                : _rightSideText(Labels.notApplicable),
          ],
        ),
        TableRow(
          children: [
            _leftSideText('${Labels.platforms}:'),
            _rightSideText(gameDetails.platforms.join(', '))
          ],
        ),
        TableRow(
          children: [
            _leftSideText('${Labels.tags}:'),
            _rightSideText(gameDetails.tags.join(', ')),
          ],
        ),
        TableRow(
          children: [
            _leftSideText('${Labels.esrbRating}:'),
            gameDetails.esrbRating?.isNotEmpty == true
                ? _rightSideText(gameDetails.esrbRating!)
                : _rightSideText(Labels.notApplicable),
          ],
        ),
      ],
    );
  }
}

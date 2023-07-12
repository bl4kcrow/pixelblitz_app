import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/theme/theme.dart';
import '../../domain/domain.dart';

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
        style: TextStyle(color: AppColors.white.withOpacity(0.7)),
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
            _leftSideText('Release Date:'),
            gameDetails.released != null
                ? _rightSideText(
                    DateFormat.yMMMd().format(gameDetails.released!))
                : _rightSideText(Labels.notApplicable),
          ],
        ),
        TableRow(
          children: [
            _leftSideText('Website:'),
            gameDetails.website?.isNotEmpty == true
                ? _urlText(gameDetails.website!)
                : _rightSideText(Labels.notApplicable),
          ],
        ),
        TableRow(
          children: [
            _leftSideText('Metacritic:'),
            gameDetails.metacritic != null
                ? _rightSideText(gameDetails.metacritic.toString())
                : _rightSideText(Labels.notApplicable),
          ],
        ),
        TableRow(
          children: [
            _leftSideText('Metacritic URL:'),
            gameDetails.metacriticUrl?.isNotEmpty == true
                ? _urlText(gameDetails.metacriticUrl!)
                : _rightSideText(Labels.notApplicable),
          ],
        ),
        TableRow(
          children: [
            _leftSideText('Rating:'),
            _rightSideText(gameDetails.rating.toString()),
          ],
        ),
        TableRow(
          children: [
            _leftSideText('Publishers:'),
            _rightSideText(gameDetails.publishers.join(', ')),
          ],
        ),
        TableRow(
          children: [
            _leftSideText('Genres:'),
            _rightSideText(gameDetails.genres.join(', ')),
          ],
        ),
        TableRow(
          children: [
            _leftSideText('Stores:'),
            gameDetails.stores != null
                ? _rightSideText(gameDetails.stores!.join(', '))
                : _rightSideText(Labels.notApplicable),
          ],
        ),
        TableRow(
          children: [
            _leftSideText('Tags:'),
            _rightSideText(gameDetails.tags.join(', ')),
          ],
        ),
        TableRow(
          children: [
            _leftSideText('ESRB Rating:'),
            gameDetails.esrbRating?.isNotEmpty == true
                ? _rightSideText(gameDetails.esrbRating!)
                : _rightSideText(Labels.notApplicable),
          ],
        ),
      ],
    );
  }
}

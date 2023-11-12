import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/features/rating/domain/entities/competition_participant_read.dart';
import 'package:flutter/material.dart';

class ParticipationCard extends StatelessWidget {
  final CompetitionParticipantRead competitionParticipantRead;

  const ParticipationCard(
      {super.key, required this.competitionParticipantRead});

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTheme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const Pad(all: 8),
        child: Column(
          children: [
            Text(
              competitionParticipantRead.competition.name,
              style: textTheme.subtitle1,
            ),
            Text(
              "Место: ${competitionParticipantRead.place}",
              style: textTheme.subtitle2,
            ),
            Text(
              "Очки рейтинга: ${competitionParticipantRead.score}",
              style: textTheme.subtitle2,
            ),
          ],
        ),
      ),
    );
  }
}

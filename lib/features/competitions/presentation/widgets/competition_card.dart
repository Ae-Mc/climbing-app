import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/features/competitions/presentation/bloc/competitions_bloc.dart';
import 'package:climbing_app/features/rating/domain/entities/competition_read.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class CompetitionCard extends StatelessWidget {
  final CompetitionRead competition;
  final bool showDeleteButton;

  const CompetitionCard(
      {super.key, required this.competition, required this.showDeleteButton});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const Pad(all: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Название: ${competition.name}"),
                const SizedBox(height: 8),
                Text("Коэффициент: ${competition.ratio}"),
                const SizedBox(height: 8),
                Text(
                    "Дата проведения: ${GetIt.I<DateFormat>().format(competition.date)}"),
                const SizedBox(height: 8),
              ],
            ),
            if (showDeleteButton) ...[
              const SizedBox(width: 16),
              IconButton(
                onPressed: () => BlocProvider.of<CompetitionsBloc>(context)
                    .add(CompetitionsEvent.removeCompetition(competition.id)),
                icon: Icon(
                  Icons.delete_forever,
                  color: AppTheme.of(context).colorTheme.error,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

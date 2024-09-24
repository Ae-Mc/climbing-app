import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/core/entities/ascent.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class RouteAscentCard extends StatelessWidget {
  final Ascent ascent;

  const RouteAscentCard({super.key, required this.ascent});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        var shape = null;
        if (ascent.user.id ==
            state.mapOrNull(
              authorized: (value) => value.activeUser.id,
            )) {
          shape = Theme.of(context).cardTheme.shape;
          if (shape is OutlinedBorder) {
            shape = shape.copyWith(
                side: BorderSide(
                    color: AppTheme.of(context).colorTheme.primary, width: 2));
          }
        }
        return Card(
          shape: shape,
          child: Padding(
            padding: const Pad(all: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${ascent.user.lastName} ${ascent.user.firstName}',
                  style: AppTheme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 8),
                Text(
                  GetIt.I<DateFormat>().format(ascent.date),
                  style: AppTheme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

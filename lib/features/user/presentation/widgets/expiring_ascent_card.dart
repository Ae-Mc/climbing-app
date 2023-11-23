import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/core/util/category_to_color.dart';
import 'package:climbing_app/features/routes/presentation/widgets/custom_network_image.dart';
import 'package:climbing_app/features/user/domain/entities/expiring_ascent.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:climbing_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

class ExpiringAscentCard extends StatefulWidget {
  final ExpiringAscent expiringAscent;
  final void Function()? onDelete;

  const ExpiringAscentCard(
      {super.key, required this.expiringAscent, this.onDelete});

  @override
  State<ExpiringAscentCard> createState() => _ExpiringAscentCardState();

  static String durationToString(Duration duration) {
    final days = duration.inDays;
    String ending;

    if ((days % 100).between(10, 21) || days % 10 > 4 || days % 10 == 0) {
      ending = "дней";
    } else if (days % 10 == 1) {
      ending = "день";
    } else {
      ending = "дня";
    }

    return '$days $ending';
  }
}

class _ExpiringAscentCardState extends State<ExpiringAscentCard> {
  bool isRemoveShown = false;

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppTheme.of(context).colorTheme;
    final textTheme = AppTheme.of(context).textTheme;
    final route = widget.expiringAscent.ascent.route;

    return TapRegion(
      onTapInside: (event) {
        GetIt.I<Logger>()
            .d('Tap inside: ${widget.expiringAscent.ascent.route.name}');
        setState(() => isRemoveShown = true);
      },
      onTapOutside: (event) {
        GetIt.I<Logger>()
            .d('Tap outside: ${widget.expiringAscent.ascent.route.name}');
        setState(() => isRemoveShown = false);
      },
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Padding(
          padding: const Pad(horizontal: 16, vertical: 8),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: SizedBox.square(
                    dimension: 72,
                    child: Stack(
                      children: [
                        SizedBox.expand(
                          child: route.images.isNotEmpty
                              ? CustomNetworkImage(
                                  widget.expiringAscent.ascent.route.images[0]
                                      .url,
                                  fit: BoxFit.cover,
                                )
                              : Assets.images.status404.image(
                                  fit: BoxFit.cover,
                                ),
                        ),
                        if (isRemoveShown)
                          SizedBox.expand(
                            child: GestureDetector(
                              onTap: () {
                                setState(() => isRemoveShown = false);
                                BlocProvider.of<UserBloc>(context).add(
                                    UserEvent.removeAscent(
                                        widget.expiringAscent.ascent.id));
                                widget.onDelete?.call();
                              },
                              child: Container(
                                color: Colors.black54,
                                child: Icon(
                                  Icons.delete_forever,
                                  color: colorTheme.error,
                                  size: 48,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        route.name,
                        style: textTheme.subtitle1,
                      ),
                      Text(
                        'Категория: ${route.category}',
                        style: textTheme.subtitle2,
                        maxLines: 2,
                      ),
                      Text(
                        'Осталось до обесценивания: ${ExpiringAscentCard.durationToString(widget.expiringAscent.timeToExpire)}',
                        style: textTheme.subtitle2,
                        maxLines: 2,
                      ),
                      const Spacer(),
                      Container(
                        height: 8,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: categoryToColor(route.category, colorTheme),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension on int {
  bool between(int start, int end) => this >= start && this < end;
}

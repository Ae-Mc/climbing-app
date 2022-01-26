import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:itmo_climbing/models/guide.dart';
import 'package:itmo_climbing/pages/guides/base_listview_page.dart';
import 'package:itmo_climbing/router.gr.dart';

class TracksPage extends BaseListViewPage<Track> {
  final List<Track> tracks;

  TracksPage(List<Track> tracks, {Key? key})
      : tracks = tracks..sort(),
        super(key: key);

  @override
  Widget? getItemLeading(BuildContext context, Track item) {
    return IntrinsicHeight(
      child: IntrinsicWidth(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 32,
            minHeight: 32,
          ),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Theme.of(context).colorScheme.secondaryVariant,
            ),
            padding: const EdgeInsets.all(4),
            child: Text(
              item.category,
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Theme.of(context).colorScheme.surface,
                  ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  String getItemTitle(Track item) {
    return item.name;
  }

  @override
  void itemOnTap(BuildContext context, int index) {
    AutoRouter.of(context).push(TrackRoute(track: tracks[index]));
  }

  @override
  List<Track> get items => tracks;
}

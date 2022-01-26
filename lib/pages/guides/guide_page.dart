import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:itmo_climbing/generated/l10n.dart';
import 'package:itmo_climbing/models/guide.dart';
import 'package:itmo_climbing/pages/guides/base_listview_page.dart';
import 'package:itmo_climbing/router.gr.dart';

enum Stand { left, right }

class GuidePage extends BaseListViewPage<Stand> {
  @override
  List<Stand> get items => [Stand.left, Stand.right];

  @override
  String getItemTitle(Stand item) {
    switch (item) {
      case Stand.left:
        return S.current.Left;
      case Stand.right:
        return S.current.Right;
    }
  }

  final Guide guide;

  const GuidePage({required this.guide, Key? key}) : super(key: key);

  @override
  void itemOnTap(BuildContext context, int index) {
    if (items[index] == Stand.left) {
      AutoRouter.of(context).push(TracksRoute(tracks: guide.leftTracks));
    } else {
      AutoRouter.of(context).push(TracksRoute(tracks: guide.rightTracks));
    }
  }
}

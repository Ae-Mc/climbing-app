import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuarterTileWidget extends StatelessWidget {
  final String title;
  const QuarterTileWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      iconColor: AppTheme.of(context).colorTheme.primary,
      onTap: () => {},
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      title: Text(title, style: Theme.of(context).textTheme.headline5),
      trailing: const Icon(CupertinoIcons.chevron_right_circle_fill),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class BaseListViewPage<T> extends StatelessWidget {
  List<T> get items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () => itemOnTap(context, index),
        leading: getItemLeading(context, items[index]),
        title: Text(
          getItemTitle(items[index]),
          style: Theme.of(context).textTheme.subtitle1,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Icon(CupertinoIcons.right_chevron),
      ),
    );
  }

  Widget? getItemLeading(BuildContext context, T item) {
    return null;
  }

  String getItemTitle(T item);

  void itemOnTap(BuildContext context, int index);
}

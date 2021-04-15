import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  final String text;
  final Alignment alignment;

  const Cell({
    Key key,
    @required this.text,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: alignment,
      child: Text(
        text,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}

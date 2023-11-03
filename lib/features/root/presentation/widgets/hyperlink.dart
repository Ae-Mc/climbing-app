import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Hyperlink extends StatelessWidget {
  final String text;
  final String url;

  const Hyperlink({super.key, required this.url, String? text})
      : text = text ?? url;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        text,
        style: const TextStyle(decoration: TextDecoration.underline),
      ),
      onTap: () => launchUrl(Uri.parse(url)),
    );
  }
}

import 'package:flutter/material.dart';

class CenteredTextWithButton extends StatelessWidget {
  final String text;
  final Widget button;
  final TextStyle textStyle;

  const CenteredTextWithButton({
    super.key,
    required this.text,
    required this.button,
    required this.textStyle,
  });
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var containerWidth = constraints.maxWidth;
      if (containerWidth == double.infinity) {
        containerWidth = MediaQuery.of(context).size.width;
      }
      final textSize = measureTextSize(text, textStyle, containerWidth);

      return SizedBox(
        width: containerWidth,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Центрируем текст по ширине экрана
            Center(
              child: Text(text, style: textStyle),
            ),
            // Кнопка справа от текста с небольшим отступом
            Positioned(
              left: (containerWidth + textSize.width) / 2 +
                  8, // 8 — отступ между текстом и кнопкой
              child: button,
            ),
          ],
        ),
      );
    });
  }

  static Size measureTextSize(
    String text,
    TextStyle style, [
    double maxWidth = double.infinity,
  ]) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size; // содержит ширину и высоту текста
  }
}

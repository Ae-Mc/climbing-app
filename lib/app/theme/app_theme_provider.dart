import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:flutter/material.dart';

/// Виджет, включаемый в дерево, для поставки текущей темы приложения через [BuildContext]
///
/// Т к это наследник [InheritedWidget], это позволяет достучаться до провайдера из каждого виджета,
/// если включить провайдер в базовый корень всей структуры виджетов
/// Подробнее про [InheritedWidget] (https://www.youtube.com/watch?v=1t-8rBCGBYw)
@immutable
class AppThemeProvider extends InheritedWidget {
  final AppTheme theme;

  const AppThemeProvider({
    Key? key,
    required Widget child,
    required this.theme,
  }) : super(child: child, key: key);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static AppThemeProvider of(BuildContext context) {
    final themeProvider =
        context.dependOnInheritedWidgetOfExactType<AppThemeProvider>();
    if (themeProvider == null) {
      throw StateError('AppThemeProvider is not found in widget tree');
    }

    return themeProvider;
  }
}

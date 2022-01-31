import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Миксин для расширения возможностей блока на поддежку SingleResult  - событий которые необходимо отрендерить 1 раз
/// - Навгиация
/// - Тост
/// - Снек
/// - Какое-то взаимодействие с анимацией
mixin SingleResultMixin<Event, State, SingleResult> on Bloc<Event, State>
    implements
        SingleResultProvider<SingleResult>,
        SingleResultEmmiter<SingleResult> {
  @protected
  final StreamController<SingleResult> _singleResultController =
      StreamController.broadcast();

  @override
  Stream<SingleResult> get singleResults => _singleResultController.stream;

  @override
  void addSingleResult(SingleResult singleResult) {
    final observer = BlocOverrides.current?.blocObserver;
    if (observer is SingleResultBlocObserver) {
      observer.onSingleResult(this, singleResult);
    }
    if (!_singleResultController.isClosed) {
      _singleResultController.add(singleResult);
    }
  }

  @override
  Future<void> close() async {
    // ignore: avoid-ignoring-return-values
    await _singleResultController.close();

    return super.close();
  }
}

/// Протокол для предоставления потока событий [SingleResult]
abstract class SingleResultProvider<SingleResult> {
  Stream<SingleResult> get singleResults;
}

/// Протокол для приема событий [SingleResult]
abstract class SingleResultEmmiter<SingleResult> {
  void addSingleResult(SingleResult singleResult);
}

/// Расширение Observer для поддержки логирования SingleResult событий
abstract class SingleResultBlocObserver<SingleResult> extends BlocObserver {
  @protected
  @mustCallSuper
  void onSingleResult(Bloc bloc, SingleResult singleResult);
}

part of 'universal_bloc.dart';

@freezed
class UniversalBlocState<T> with _$UniversalBlocState {
  const factory UniversalBlocState.failure(Failure f) = _Failure;
  const factory UniversalBlocState.loaded(T result) = _Loaded;
  const factory UniversalBlocState.loading() = _Loading;
}

part of 'universal_bloc.dart';

@freezed
class UniversalBlocState<T> with _$UniversalBlocState<T> {
  const factory UniversalBlocState.failure(Failure f) = _Failure;
  const factory UniversalBlocState.loaded(T result) = _Loaded<T>;
  const factory UniversalBlocState.loading() = _Loading;
}

part of 'universal_bloc.dart';

@freezed
class UniversalBlocSingleResult<T> with _$UniversalBlocSingleResult {
  const factory UniversalBlocSingleResult.loaded(T result) = _;
  const factory UniversalBlocSingleResult.failure(Failure failure) = __;
}

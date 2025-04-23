part of 'universal_bloc.dart';

@freezed
sealed class UniversalBlocSingleResult<T> with _$UniversalBlocSingleResult {
  const factory UniversalBlocSingleResult.loaded(T result) =
      UniversalBlocSingleResultLoaded;
  const factory UniversalBlocSingleResult.failure(Failure failure) =
      UniversalBlocSingleResultFailure;
}

part of 'universal_bloc.dart';

@freezed
sealed class UniversalBlocState<T> with _$UniversalBlocState<T> {
  const factory UniversalBlocState.failure(Failure f) =
      UniversalBlocStateFailure;
  const factory UniversalBlocState.loaded(T result) =
      UniversalBlocStateLoaded<T>;
  const factory UniversalBlocState.loading() = UniversalBlocStateLoading;
}

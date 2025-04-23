part of 'universal_bloc.dart';

@freezed
sealed class UniversalBlocEvent with _$UniversalBlocEvent {
  const factory UniversalBlocEvent.refresh() = UniversalBlocEventRefresh;
}

part of 'universal_bloc.dart';

@freezed
class UniversalBlocEvent with _$UniversalBlocEvent {
  const factory UniversalBlocEvent.refresh() = _Refresh;
}

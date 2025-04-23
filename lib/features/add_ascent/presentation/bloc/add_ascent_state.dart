part of 'add_ascent_bloc.dart';

@freezed
sealed class AddAscentState with _$AddAscentState {
  const factory AddAscentState.loaded() = AddAscentStateLoaded;
  const factory AddAscentState.loading() = AddAscentStateLoading;
}

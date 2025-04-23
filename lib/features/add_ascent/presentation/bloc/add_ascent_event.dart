part of 'add_ascent_bloc.dart';

@freezed
sealed class AddAscentEvent with _$AddAscentEvent {
  const factory AddAscentEvent.addAscent(AscentCreate ascent) =
      AddAscentEventAddAscent;
}

part of 'add_ascent_bloc.dart';

@freezed
class AddAscentEvent with _$AddAscentEvent {
  const factory AddAscentEvent.addAscent(AscentCreate ascent) = _AddAscent;
}
